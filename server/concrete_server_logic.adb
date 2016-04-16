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
      connectMessage : MessageObject;
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

      -- # Datenbank laden #
      User_Databases.loadUserDatabase(server.UserDatabase);
      Put_Line("User database loadad.");

      -- # Erzeugung des SubServer-Sockets #
      Create_Socket(Socket => SubServer.Socket);
      -- # SubServer mit Server verbinden, Server wartet mit Accept - SubServer fragt mit Connect an #

      Connect_Socket(Socket => SubServer.Socket, Server => Server.SocketAddress);
      connectMessage := createMessage(messagetype => Protocol.Connect,
                                      sender      => To_Unbounded_String("server"),
                                      receiver    => 0,
                                      content     => To_Unbounded_String("passwort"));

      writeMessageToStream(SubServer.socket,connectMessage);



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

            -- # Neuen Kommunikationstask für Client erzeugen, hinterlegen und starten #
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
      ClientSocket : Socket_Type;
      ClientSocketAddress : Sock_Addr_Type;
      MyUsername : Unbounded_String;
      serverRoomID : Integer := 3;
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
            incoming_message : MessageObject;
         begin


            -- # Nachricht liegt vor, nun wird diese verarbeitet und interpretiert #
            declare
               Substrings : GNAT.String_Split.Slice_Set;
               MessagePart : Unbounded_String;
               userlist : Unbounded_String := Ada.Strings.Unbounded.To_Unbounded_String("userlist");
               incoming_string : Unbounded_String;
            begin
               -- # Nachricht wird aus String erstellt #
               incoming_message := readMessageFromStream(ClientSocket => ClientSocket);

               --Kann speater raus, Nachricht und deren Laenge anzeigen---------
               Protocol.printMessageToInfoConsole(message => incoming_message);
               incoming_string:=To_Unbounded_String(messageObjectToString(incoming_message));
               Ada.Text_IO.Put_Line(messageObjectToString(incoming_message));
               -----------------------------------------------------------------



               case incoming_message.messagetype is
                  when Protocol.Connect => -- # connect:client:0:<passwort> #
                                          declare
                        user : UserPtr;
                        userNotFoundMessage : MessageObject := createMessage(messagetype => Protocol.Refused,
                                                                             sender      => To_Unbounded_String("server"),
                                                                             receiver    => 0,
                                                                             content     => To_Unbounded_String("user not found in database"));
                        invalidPasswordMessage : MessageObject := createMessage(messagetype => Protocol.Refused,
                                                                                sender      => To_Unbounded_String("server"),
                                                                                receiver    => 0,
                                                                                content     => To_Unbounded_String("invalid passwort"));
                        connectAcceptMessage : MessageObject := createMessage(messagetype => Protocol.Connect,
                                                                              sender      => To_Unbounded_String("server"),
                                                                              receiver    => serverRoomID ,
                                                                              content     => To_Unbounded_String("ok"));
                        userpassword : Unbounded_String;
                     begin
                        -- # Pruefe ob Benutzer registriert und Passwort richtig #
                        user := server.UserDatabase.getUser(username => incoming_message.sender);

                        if user = null then
                           writeMessageToStream(ClientSocket => ClientSocket,message => userNotFoundMessage);
                        else
                           userpassword := getPassword(user);
                           if userpassword /= incoming_message.content then
                              writeMessageToStream(ClientSocket,invalidPasswordMessage);
                           else
                              --# hole serverroomid zu diesem client vom server
                              writeMessageToStream(clientSocket,connectAcceptMessage);
                           end if;
                        end if;
                     end;

                    -- # Client in Verwaltungsliste suchen und Usernamen zur speateren Kommunikation setzen #
                     for c of server.all.Connected_Clients loop
                           if c.all.SocketAddress = ClientSocketAddress then
                              c.all.Username := MessagePart;
                              MyUsername := MessagePart;
                           end if;
                           userlist := userlist & Seperator & c.all.Username;
                     end loop;
                     -- # Weise Client eine ServerRoomID zu #
                     -- # setze Client auf online #
                     -- # Sende online-Benachrichtigung an alle Kontakte des Clients#

                  when Protocol.Chat => -- # chat:client:<ChatRoomID>:Hi #

                     -- # Pruefe, ob Client in ChatRoom eingeschrieben #
                     -- # Hole Liste aller Cients in diesem ChatRoom #
                     -- # Sende Nachricht an alle Clients in diesem ChatRoom #


                     null;
                  when Protocol.Disconnect => -- # disconnect:client:<ServerRoomID>:<?> #
                     declare
                        disconnectMessage : MessageObject;
                     begin

                     -- # Pruefe, ob die ServerRoomID die ServerRoomID des Clients ist
                     -- # Sende Disconnect-Bestaetigung
                        disconnectMessage := createMessage(messagetype => Protocol.Disconnect,
                                      sender      => To_Unbounded_String("server"),
                                      receiver    => serverRoomID,
                                      content     => To_Unbounded_String("ok"));
                        writeMessageToStream(ClientSocket,disconnectMessage);
                     -- # Schliesse Socket zu Client #
                     -- # Setze User als offline #

                        -- # Sende Offline-Status an alle Kontakte vom Client # #

                     end;
                  when Protocol.Chatrequest => -- # chatrequest:clientA:<ServerRoomID>:clientB #
                     null;
                  when Protocol.Leavechat => -- # leavechat:client:<ChatRoomID>:<?> #
                     null;
                  when others => -- # Online/Offline/Userlist/Refused #
                     null;
                  end case;

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
