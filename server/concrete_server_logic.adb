package body Concrete_Server_Logic is

   server : Concrete_Server_Ptr;

   procedure dummy1(This : in out Concrete_Server_Ptr) is
   begin
      InitializeServer(this);
   end dummy1;

   procedure InitializeServer(This : in out Concrete_Server_Ptr) is
   begin
      server := this;

      Create_Socket(Socket => server.Socket);
      --this.SocketAddress.Family := Gnat.Sockets.Family_Inet; -- Fehler!
      server.SocketAddress.Addr := Inet_Addr("127.0.0.1");
      server.SocketAddress.Port := 12321;
      Bind_Socket(Socket => server.Socket, Address => server.SocketAddress);
      Listen_Socket(Socket => server.Socket);

      Ada.Text_IO.Put_Line("Server initialization successful, starting Server Listener Task...");
      Main_Server_Task.Start;

      Exception
       when Error: Socket_Error =>
         Put("Socket_Error: ");
         Put_Line (Exception_Information(Error));
       when Error: others =>
         Put ("Unexpected exception: ");
         Put_Line (Exception_Information(Error));
   end InitializeServer;

   procedure dummy3(This : in out Concrete_Server_Ptr) is null;

   task body Main_Server_Task is
   begin
      accept Start;

      -- Abhörroutine auf Aktivität am Server-Socket
      loop
         declare
            Client : Concrete_Client_Ptr := new Concrete_Client;
            ClientSocket : Socket_Type;
            ClientSocketAddress : Sock_Addr_Type;
         begin
            -- auf Verbindungsanfrage warten, annehmen, Client-Socket erzeugen und neue Adresse an diesen binden
            Ada.Text_IO.Put_Line("Ready to accept incoming Conncetions...");
            Accept_Socket(Server => server.Socket , Socket => ClientSocket, Address => ClientSocketAddress); -- Blockierender Aufruf
            Ada.Text_IO.Put_Line("Incoming Connection from " & GNAT.Sockets.Image(ClientSocketAddress) & " accepted");

            -- neuen Client in globale Client Liste eintragen
            Client.Socket := ClientSocket;
            Client.SocketAddress := ClientSocketAddress;
            server.Connected_Clients.Append(New_Item => Client);

            -- neuen Kommunikationstask für Client hinterlegen und starten
            Client.CommunicationTask := new Client_Task;
            Client.CommunicationTask.Start(Socket => ClientSocket, SocketAddress => ClientSocketAddress);
         end;
      end loop;

      Exception
       when Error: Socket_Error =>
         Put("Socket_Error: ");
         Put_Line (Exception_Information(Error));
       when Error: others =>
         Put ("Unexpected exception: ");
         Put_Line (Exception_Information(Error));

   end Main_Server_Task;

   task body Client_Task is
      InputChannel : Stream_Access;
      OutputChannel : Stream_Access;
      ClientSocket : Socket_Type;
      ClientSocketAddress : Sock_Addr_Type;
      MyUsername : Unbounded_String;
   begin
      accept Start(Socket : Socket_Type; SocketAddress : Sock_Addr_Type) do -- Info: während dieser Aktivierungsphase wird der aufrufende Task blockiert
         ClientSocket := Socket;
         ClientSocketAddress := SocketAddress;
      end Start; -- Jetzt läuft er erst nebenläufig weiter!

      Ada.Text_IO.Put_Line("New Client Task for " & GNAT.Sockets.Image(ClientSocketAddress) & " successfully started");

      InputChannel := Stream(ClientSocket);

      Ada.Text_IO.Put_Line("Waiting for incoming data from " & GNAT.Sockets.Image(ClientSocketAddress) & " ...");

      loop
         declare
            incoming_data : Stream_Element_Array(1..4096);
            incoming_data_size : Stream_Element_Offset;
            incoming_message : Ada.Strings.Unbounded.Unbounded_String;
         begin
            Receive_Socket(Socket => ClientSocket, Item => incoming_data, Last => incoming_data_size);

            for i in 1 .. incoming_data_size loop
               incoming_message := incoming_message & Character'Val(incoming_data(i));
            end loop;

            declare
               Substrings : GNAT.String_Split.Slice_Set;
               Seperator : constant String := ":";
               Sub : Unbounded_String;
               Count : Slice_Number;
            begin
               GNAT.String_Split.Create(S => Substrings, From => Ada.Strings.Unbounded.To_String(incoming_message),
                                        Separators => Seperator, Mode => GNAT.String_Split.Multiple);
               -----------------------------------------------------------------
               for i in 1 .. GNAT.String_Split.Slice_Count(Substrings) loop
                  declare
                     Sub : constant String := GNAT.String_Split.Slice(Substrings, i);
                  begin
                     Put_Line(GNAT.String_Split.Slice_Number'Image(i) & " -> " & Sub & " (length" & Positive'Image(Sub'Length) & ")");
                  end;
               end loop;

               Ada.Text_IO.Put_Line(Ada.Strings.Unbounded.To_String(incoming_message));
               -----------------------------------------------------------------
               Count := GNAT.String_Split.Slice_Count(Substrings);
               if Count > 1 then
                  Sub := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(Substrings, 1));
                  if sub = "connect" then
                     if Count = 2 then
                        Sub := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(Substrings, 2));
                        for c of server.all.Connected_Clients loop
                           if c.all.SocketAddress = ClientSocketAddress then
                              c.all.Username := Sub;
                              MyUsername := Sub;
                           end if;
                        end loop;
                     else
                        Put_Line("Wrong Input: " & Ada.Strings.Unbounded.To_String(incoming_message));
                     end if;
                  elsif sub = "message" then
                     if Count = 3 then
                        Sub := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(Substrings, 2));
                        for c of server.all.Connected_Clients loop
                           if c.all.Username = Sub then
                              Sub := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(Substrings, 3));
                              OutputChannel := Stream(c.all.Socket);
                              String'Write(OutputChannel, Ada.Strings.Unbounded.To_String("message:" & MyUsername & ":" & Sub));
                           end if;
                        end loop;
                     else
                        Put_Line("Wrong Input: " & Ada.Strings.Unbounded.To_String(incoming_message));
                     end if;
                  elsif sub = "refuse" then
                     null;
                  elsif sub = "disconnect" then
                     null;
                  end if;
               else
                  Put_Line("Wrong Input: " & Ada.Strings.Unbounded.To_String(incoming_message));
               end if;
            end;
         end;
      end loop;

      Exception
      when Error: Socket_Error =>
         Put("Socket_Error: ");
         Put_Line (Exception_Information(Error));
      when Error: others =>
         Put ("Unexpected exception: ");
         Put_Line (Exception_Information(Error));
   end Client_Task;
end Concrete_Server_Logic;
