package body Concrete_Server_Logic is

   procedure dummy1(This : in out Concrete_Server) is
      CRLF : constant String := ASCII.CR & ASCII.LF;
      Host : constant String := "www.google.de";

      Host_Entry : Gnat.Sockets.Host_Entry_Type
        := GNAT.Sockets.Get_Host_By_Name(Host);

      Address : GNAT.Sockets.Sock_Addr_Type;
      Socket  : GNAT.Sockets.Socket_Type;
      Channel : GNAT.Sockets.Stream_Access;
      Data    : Ada.Streams.Stream_Element_Array (1..1024);
      Size    : Ada.Streams.Stream_Element_Offset;
      Ret     : Ada.Strings.Unbounded.Unbounded_String;
   begin
      -- Open a connection to the host
      Address.Addr := GNAT.Sockets.Addresses(Host_Entry, 1);
      Address.Port := 80;
      GNAT.Sockets.Create_Socket (Socket);
      GNAT.Sockets.Connect_Socket (Socket, Address);

      -- Prepare stream to accept incoming data and push the
      -- GET request
      Channel := Gnat.Sockets.Stream (Socket);
      String'Write (Channel, "GET /sqlrest HTTP/1.1" & CRLF &
                      "Host: " & Host & CRLF & CRLF);

      -- Receive what's in the socket, and put it into
      -- our unbounded string
      GNAT.Sockets.Receive_Socket(Socket,Data,Size);
      for i in 1 .. Size loop
         Ret := Ret & Character'Val(Data(i));
      end loop;

      -- Write it out to the console
      Ada.Text_IO.Put_Line (Ada.Strings.Unbounded.To_String(Ret));

      Main_Server_Task.Start;
   end dummy1;

   procedure dummy2(This : in out Concrete_Server) is
   begin
      null;
   end dummy2;

   procedure dummy3(This : in out Concrete_Server) is null;

   task body Main_Server_Task is
      --Address : Sock_Addr_Type;
      --Server : Socket_Type;
      --Socket : Socket_Type;
      --Channel : Stream_Access;
      Receiver : Socket_Type;
      --Connection : Socket_Type;
      Client_Address : Sock_Addr_Type;
      --Channel : Stream_Access;
      Sockets : Socket_Set_Type;
      Socket_Selector : Selector_Type;
      Write_Sockets : Socket_Set_Type;
   begin
      accept Start;

      -- Aufsetzen des Server-Socket - Receiver
      Create_Socket(Socket => Receiver);
      Set_Socket_Option(Socket => Receiver, Option => (Name => Reuse_Address, Enabled => True));
      Bind_Socket(Socket => Receiver, Address => (Family => Family_Inet, addr => Inet_Addr("127.0.0.1"), Port => 12321));
      Listen_Socket(Socket => Receiver);
      Set(Item => Sockets, Socket => Receiver);
      Create_Selector(Selector => Socket_Selector);

      -- Abhörroutine auf Aktivität bzgl. neuen oder verbundenen Sockets
      loop
         declare
            Read_Sockets : Socket_Set_Type;
            SelectorStatus : Selector_Status;
         begin
            Copy(Source => Sockets, Target => Read_Sockets);
            -- Warten ob etwas auf den Sockets passiert
            Check_Selector(Selector => Socket_Selector, R_Socket_Set => Read_Sockets, W_Socket_Set => Write_Sockets, Status => SelectorStatus);
            -- Aufruf ist zurückgekehrt => ein Socket ist bereit Daten zu lesen oder zu schreiben
            -- Wie ist der Status?
            if SelectorStatus = Completed then
               -- Erfolgreich. Es gilt herauszufinden welches Socket bereit ist und dieses zu bearbeiten
               -- Sollten dies mehr als eines sein, werden diese im nächsten Durchlauf behandelt
               declare
                  Active_Socket : Socket_Type;
               begin
                  GNAT.Sockets.Get(Read_Sockets, Active_Socket);
                  if Active_Socket = Receiver then
                     -- der Server ist bereit => neuer Client will sich verbinden
                     -- Routine zum Bestätigen der Verbindungsanfrage:
                     -- 1. neuen Socket anlegen, 2. in die globale Socketverwaltungsliste eintragen
                     Accept_Socket(Server => Receiver, Socket => Active_Socket, Address => Client_Address);
                     Set(Item => Sockets, Socket => Active_Socket);
                  elsif Active_Socket = No_Socket then
                     -- keiner der Sockets hat Daten zum Senden oder Empfangen
                     null;
                  else
                     -- mal schauen
                     null;
                  end if;
               end;
            else
               -- Expired oder Aborted
               null;
            end if;
            -- Aufräumen
            Empty(Item => Read_Sockets);
         end;
      end loop;

      Close_Socket(Socket => Receiver);


         --Accept_Socket(Server => Receiver, Socket => Connection, Address => Client);
         --Ada.Text_IO.Put_Line("Client connected from " & GNAT.Sockets.Image(Client));
         --Channel := GNAT.Sockets.Stream (Connection);
         --begin
            --loop
               --String'Output(Channel, "Welcome");
               --String'Output(Channel, String'Input(Channel));
               --Character'Output (Channel, Character'Input (Channel));
            --end loop;
         --exception
            --when Ada.IO_Exceptions.End_Error =>
               --null;
         --end;
         --GNAT.Sockets.Close_Socket (Connection);
      --end loop;
      --------------------------------------------------------------------------
      -- Get the IP-Address of localhost and assign a portnumber
      --Address.Addr := Addresses(Get_Host_By_Name(Host_Name));
      --Address.Port := 20000;

      -- Create Socket
      --Create_Socket(Server);
      --Set_Socket_Option(Server, Socket_Level,(Reuse_Address, True));
      --Bind_Socket(Server, Address);

      --Listen_Socket(Server);

      --Ada.Text_IO.Put_Line("Accepting Conncetions");
      --Accept_Socket(Server, Socket, Address);

   --        --  Return a stream associated to the connected socket.
      --Ada.Text_IO.Put_Line("Writing on Channel");
      --Channel := Stream(Socket);
      --String'Write (Channel, "Welcome");
   end Main_Server_Task;

end Concrete_Server_Logic;
