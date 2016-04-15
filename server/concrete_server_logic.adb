package body Concrete_Server_Logic is

   Server : Concrete_Server_Ptr;

   -----------------------------------------------------------------------------

   procedure StartServer(This : in out Concrete_Server_Ptr) is
   begin
      InitializeServer(this);
   end StartServer;

   -----------------------------------------------------------------------------

   procedure InitializeServer(This : in out Concrete_Server_Ptr) is
      SubServer : Concrete_Client_Ptr := new Concrete_Client;
   begin
      -- # Erzeugte Serverintanz global setzen, damit sie im Package ueberall bekannt ist #
      server := this;

      -- # Erzeugung und Konfiguration des Server-Sockets #
      Create_Socket(Socket => Server.Socket);
      -- this.SocketAddress.Family := Gnat.Sockets.Family_Inet; -- Diskriminanten-Fehler, ka wie loesen!
      Server.SocketAddress.Addr := Inet_Addr("127.0.0.1");
      Server.SocketAddress.Port := 12321;
      Bind_Socket(Socket => Server.Socket, Address => Server.SocketAddress);
      Listen_Socket(Socket => Server.Socket);

       -- # Server starten #
      Ada.Text_IO.Put_Line("Server initialization successful, starting Server Listener Task...");
      Main_Server_Task.Start;

      -- # Erzeugung des SubServer-Sockets #
      Create_Socket(Socket => SubServer.Socket);
      -- # SubServer mit Server verbinden, Server wartet mit Accept - SubServer fragt mit Connect an #
      Connect_Socket(Socket => SubServer.Socket, Server => Server.SocketAddress);
      String'Write(Stream(SubServer.Socket), "connect" & Seperator & "server");

      Exception
       when Error: Socket_Error =>
         Put("Socket_Error in InitializeServer: ");
         Put_Line (Exception_Information(Error));
       when Error: others =>
         Put ("Unexpected exception in InitializeServer: ");
         Put_Line (Exception_Information(Error));
   end InitializeServer;

   -----------------------------------------------------------------------------

   procedure dummy3(This : in out Concrete_Server_Ptr) is null;

   -----------------------------------------------------------------------------

   task body Main_Server_Task is
   begin
      accept Start;

      -- # Abhoerroutine auf Aktivitaet am Server-Socket #
      loop
         declare
            Client : Concrete_Client_Ptr := new Concrete_Client;
         begin
            -- # Auf Verbindungsanfrage warten, annehmen, Client-Socket erzeugen und neue Adresse an diesen binden #
            Ada.Text_IO.Put_Line("Ready to accept incoming Conncetions...");
            Accept_Socket(Server => server.Socket , Socket => Client.Socket, Address => Client.SocketAddress); -- Blockierender Aufruf
            Ada.Text_IO.Put_Line("Incoming Connection from " & GNAT.Sockets.Image(Client.SocketAddress) & " accepted");

            -- # Neuen Client in globale Verwaltungsliste eintragen #
            server.Connected_Clients.Append(New_Item => Client);

            -- # Neuen Kommunikationstask f¸r Client erzeugen, hinterlegen und starten #
            Client.CommunicationTask := new Client_Task;
            Client.CommunicationTask.Start(Socket => Client.Socket, SocketAddress => Client.SocketAddress);
         end;
      end loop;

      Exception
       when Error: Socket_Error =>
         Put("Socket_Error in Main_Server_Task: ");
         Put_Line(Exception_Information(Error));
       when Error: others =>
         Put ("Unexpected exception in Main_Server_Task: ");
         Put_Line(Exception_Information(Error));
   end Main_Server_Task;

   -----------------------------------------------------------------------------

   task body Client_Task is
      -- InputChannel : Stream_Access;
      OutputChannel : Stream_Access;
      ClientSocket : Socket_Type;
      ClientSocketAddress : Sock_Addr_Type;
      MyUsername : Unbounded_String;
   begin
      -- # Info: waehrend dieser Aktivierungsphase wird der aufrufende Task blockiert
      accept Start(Socket : Socket_Type; SocketAddress : Sock_Addr_Type) do
         ClientSocket := Socket;
         ClientSocketAddress := SocketAddress;
      end Start; -- Jetzt laeuft dieser erst nebenlaeufig weiter! #

      Ada.Text_IO.Put_Line("New Client Task for " & GNAT.Sockets.Image(ClientSocketAddress) & " successfully started");

      -- InputChannel := Stream(ClientSocket);

      Ada.Text_IO.Put_Line("Waiting for incoming data from " & GNAT.Sockets.Image(ClientSocketAddress) & " ...");

      -- # Abhoerroutine2 auf Aktivitaet am Client-Socket #
      <<Continue>>
      loop
         declare
            incoming_data : Stream_Element_Array(1..4096);
            incoming_data_size : Stream_Element_Offset;
            incoming_message : Ada.Strings.Unbounded.Unbounded_String;
         begin
            -- # Eigehende Nachrichten lesen (blockierender Aufruf) #
            Receive_Socket(Socket => ClientSocket, Item => incoming_data, Last => incoming_data_size);

            -- # Eingegangene Nachricht aus Character-Array in String zusammebauen #
            for i in 1 .. incoming_data_size loop
               incoming_message := incoming_message & Character'Val(incoming_data(i));
            end loop;

            -- # Nachricht liegt vor, nun wird diese verarbeitet und interpretiert #
            declare
               Substrings : GNAT.String_Split.Slice_Set;
               MessagePart : Unbounded_String;
               Count : Slice_Number;
               userlist : Unbounded_String := Ada.Strings.Unbounded.To_Unbounded_String("userlist");
            begin
               -- # Nachricht wird an definiertem Trennzeichen zerstueckelt #
               GNAT.String_Split.Create(S => Substrings, From => Ada.Strings.Unbounded.To_String(incoming_message),
                                        Separators => Seperator, Mode => GNAT.String_Split.Multiple);
               Count := GNAT.String_Split.Slice_Count(Substrings);

               --Kann speater raus, Nachricht und deren Laenge anzeigen---------
               for i in 1 .. GNAT.String_Split.Slice_Count(Substrings) loop
                  declare
                     MessagePart : constant String := GNAT.String_Split.Slice(Substrings, i);
                  begin
                     Put_Line(GNAT.String_Split.Slice_Number'Image(i) & " -> " & MessagePart & " (length" & Positive'Image(MessagePart'Length) & ")");
                  end;
               end loop;

               Ada.Text_IO.Put_Line(Ada.Strings.Unbounded.To_String(incoming_message));
               -----------------------------------------------------------------

               -- # Welche Art von Nachricht liegt vor und was soll getan werden? #
               if Count > 0 then
                  MessagePart := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(Substrings, 1));
                  if MessagePart = "connect" then
                     if Count = 2 then -- # Verbindungsanfrage, Format: connect:<Benutzername> #
                        MessagePart := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(Substrings, 2));
                        -- # Anfrage auf Gueltigkeit testen #
                        for c of server.all.Connected_Clients loop
                           if c.all.Username = MessagePart then
                              OutputChannel := Stream(ClientSocket);
                              String'Write(OutputChannel, "refused" & Seperator & "name already in use");
                              -- Socket wieder schlieﬂen und aus Liste austragen etc.
                              goto Continue;
                           end if;
                        end loop;
                        -- # Client in Verwaltungsliste suchen und Usernamen zur speateren Kommunikation setzen #
                        for c of server.all.Connected_Clients loop
                           if c.all.SocketAddress = ClientSocketAddress then
                              c.all.Username := MessagePart;
                              MyUsername := MessagePart;
                           end if;
                           userlist := userlist & Seperator & c.all.Username;
                        end loop;

                        -- # Userlist an alle Teilnehmer senden #
                        for c of server.all.Connected_Clients loop
                           OutputChannel := Stream(c.all.Socket);
                           String'Write(OutputChannel, Ada.Strings.Unbounded.To_String(userlist));
                        end loop;
                     else
                        Put_Line("Wrong Input: " & Ada.Strings.Unbounded.To_String(incoming_message));
                     end if;
                  elsif MessagePart = "message" then
                     if count = 2 then  -- # Nachricht an alle versenden, Format: message:<Nachricht> #
                        -- # MessagePart ist hier die eigentliche Nachricht #
                        MessagePart := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(Substrings, 2));
                        -- # An alle User aus der Verwaltungsliste, ausser an sich selbst, die Broadcast-Nachricht versenden #
                        for c of server.all.Connected_Clients loop
                           if c.all.Username /= MyUsername then -- # Der Versender der Nachricht, soll den Broadcast nicht bekommen, sonst doppelte Nachricht #
                           OutputChannel := Stream(c.all.Socket);
                           String'Write(OutputChannel, Ada.Strings.Unbounded.To_String("message" & Seperator & MyUsername & Seperator & MessagePart));
                           end if;
                        end loop;
                     elsif Count = 3 then -- # Nachricht an jemand Bestimmten versenden, Format: message:<Benutzername>:<Nachricht> #
                        -- # MessagePart ist hier der Name des Users #
                        MessagePart := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(Substrings, 2));
                        -- # Bestimmten Benutzer in Verwaltungsliste suchen und an diesen die Nachricht zustellen #
                        for c of server.all.Connected_Clients loop
                           if c.all.Username = MessagePart then
                              -- # MessagePart ist hier die eigentliche Nachricht #
                              MessagePart := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(Substrings, 3));
                              OutputChannel := Stream(c.all.Socket);
                              String'Write(OutputChannel, Ada.Strings.Unbounded.To_String("message" & Seperator & MyUsername & Seperator & MessagePart));
                           end if;
                        end loop;
                     else
                        Put_Line("Wrong Input: " & Ada.Strings.Unbounded.To_String(incoming_message));
                     end if;
                  elsif MessagePart = "disconnect" then
                     OutputChannel := Stream(ClientSocket);
                     String'Write(OutputChannel, "disconnect" & Seperator & "ok");

                     for c of server.all.Connected_Clients loop
                        if c.all.Username = MyUsername then
                           Close_Socket(c.all.Socket); -- wirft noch Fehler
                        end if;
                     end loop;
                     -- aus Liste austragen und Objekt loeschen und Task beenden
                  end if;
               else
                  Put_Line("Wrong Input: " & Ada.Strings.Unbounded.To_String(incoming_message));
               end if;
            end;
         end;
      end loop;

      Exception
      when Error: Socket_Error =>
         Put("Socket_Error in Client_Task: ");
         Put_Line(Exception_Information(Error));
      when Error: others =>
         Put ("Unexpected exception in Client_Task: ");
         Put_Line(Exception_Information(Error));
   end Client_Task;

end Concrete_Server_Logic;
