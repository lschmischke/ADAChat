package body Concrete_Server_Logic is

   Server : Concrete_Server_Ptr;

-----------------------------------------------------------------------------

   procedure StartServer (This : in out Concrete_Server_Ptr) is
   begin
      -- # Erzeugte Serverintanz global setzen, damit sie im Package ueberall bekannt ist #
      Server := This;

      -- # Datenbank laden #
      User_Databases.loadUserDatabase (Server.UserDatabase);
      Put_Line ("User database loadad.");

      --#Sockets aufbauen
      InitializeServer (This);

      --# Infrastruktur aufsetzen

   end StartServer;

   -----------------------------------------------------------------------------

   function getNextChatRoomID (server : in out Concrete_Server_Ptr) return Natural is
      id : Natural;
   begin
      id                       := server.chatRoomIDCounter;
      server.chatRoomIDCounter := server.chatRoomIDCounter + 1;
      return id;
   end getNextChatRoomID;

-----------------------------------------------------------------------------

   procedure InitializeServer (This : in out Concrete_Server_Ptr) is
      SubServer      : Concrete_Client_Ptr := new Concrete_Client;
      connectMessage : MessageObject;
   begin

      -- # Erzeugung und Konfiguration des Server-Sockets #
      Create_Socket (Socket => Server.Socket);
      -- this.SocketAddress.Family := Gnat.Sockets.Family_Inet; -- Diskriminanten-Fehler, ka wie loesen!
      Server.SocketAddress.Addr := Inet_Addr ("127.0.0.1");
      Server.SocketAddress.Port := 12321;
      Bind_Socket (Socket => Server.Socket, Address => Server.SocketAddress);
      Listen_Socket (Socket => Server.Socket);

      -- # Server starten #
      Ada.Text_IO.Put_Line ("Server initialization successful, starting Server Listener Task...");
      Main_Server_Task.Start;

      -- # Erzeugung des SubServer-Sockets #
      Create_Socket (Socket => SubServer.Socket);
      -- # SubServer mit Server verbinden, Server wartet mit Accept - SubServer fragt mit Connect an #

      Connect_Socket (Socket => SubServer.Socket, Server => Server.SocketAddress);
      connectMessage :=
        createMessage
          (messagetype => Protocol.Connect,
           sender      => To_Unbounded_String ("server"),
           receiver    => 0,
           content     => To_Unbounded_String ("passwort"));

      writeMessageToStream (SubServer.Socket, connectMessage);

   exception
      when Error : Socket_Error =>
         Put ("Socket_Error in InitializeServer: ");
         Put_Line (Exception_Information (Error));
      when Error : others =>
         Put ("Unexpected exception in InitializeServer: ");
         Put_Line (Exception_Information (Error));
   end InitializeServer;

-----------------------------------------------------------------------------

   procedure dummy3 (This : in out Concrete_Server_Ptr) is null;

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
            Ada.Text_IO.Put_Line ("Ready to accept incoming Conncetions...");
            Accept_Socket
              (Server  => Server.Socket,
               Socket  => Client.Socket,
               Address => Client.SocketAddress); -- Blockierender Aufruf
            Ada.Text_IO.Put_Line ("Incoming Connection from " & GNAT.Sockets.Image (Client.SocketAddress) & " accepted");

            -- # Neuen Kommunikationstask für Client erzeugen, hinterlegen und starten #
            Client.CommunicationTask := new Client_Task;
            Client.CommunicationTask.Start (Client);
         end;
      end loop;

   exception
      when Error : Socket_Error =>
         Put ("Socket_Error in Main_Server_Task: ");
         Put_Line (Exception_Information (Error));
      when Error : others =>
         Put ("Unexpected exception in Main_Server_Task: ");
         Put_Line (Exception_Information (Error));
   end Main_Server_Task;

-----------------------------------------------------------------------------

   task body Client_Task is
      client       : Concrete_Client_Ptr;
      user         : UserPtr;
      serverRoomID : Integer;
      serverStr    : Unbounded_String := To_Unbounded_String ("server");
   begin
-- # Info: waehrend dieser Aktivierungsphase wird der aufrufende Task blockiert
      accept Start (newClient : Concrete_Client_Ptr) do
         client := newClient;
      end Start; -- Jetzt laeuft dieser erst nebenlaeufig weiter! #

      Ada.Text_IO.Put_Line ("New Client Task for " & GNAT.Sockets.Image (client.SocketAddress) & " successfully started");

      -- InputChannel := Stream(ClientSocket);

      Ada.Text_IO.Put_Line ("Waiting for incoming data from " & GNAT.Sockets.Image (client.SocketAddress) & " ...");

      -- # Abhoerroutine2 auf Aktivitaet am Client-Socket #
      <<Continue>>
      loop
         declare
            incoming_message : MessageObject;
         begin

            -- # Nachricht liegt vor, nun wird diese verarbeitet und interpretiert #
            declare
            begin
               -- # Nachricht wird aus String erstellt #
               incoming_message := readMessageFromStream (ClientSocket => client.Socket);

               --Kann speater raus, Nachricht und deren Laenge anzeigen---------
               if incoming_message.messagetype /= Protocol.Invalid then
                  Protocol.printMessageToInfoConsole (message => incoming_message);
               end if;

               Ada.Text_IO.Put_Line (messageObjectToString (incoming_message));
               -----------------------------------------------------------------

               case incoming_message.messagetype is

                  -- ### CONNECT ###
                  when Protocol.Connect => -- # connect:client:0:<passwort> #
                     declare

                        userNotFoundMessage : MessageObject :=
                          createMessage
                            (messagetype => Protocol.Refused,
                             sender      => serverStr,
                             receiver    => 0,
                             content     => To_Unbounded_String ("user not found in database"));
                        invalidPasswordMessage : MessageObject :=
                          createMessage
                            (messagetype => Protocol.Refused,
                             sender      => serverStr,
                             receiver    => 0,
                             content     => To_Unbounded_String ("invalid password"));

                        userpassword : Unbounded_String;
                     begin
                        -- # Pruefe ob Benutzer registriert und Passwort richtig #
                        user := Server.UserDatabase.getUser (username => incoming_message.sender);
			Put_Line("Ausgabe nach Prüfung ob User bei Connect existiert.");
			if user = null then
			   Put_Line("Ausgabe nach if");
                           writeMessageToStream (ClientSocket => client.Socket, message => userNotFoundMessage);
			else
			   Put_Line("Ausgabe nach else");
                           userpassword := getPassword (user);
                           -- TODO: das Passwort sollte vom Client bereits verschluesselt verschickt werden!!
                           if userpassword /= encodePassword (incoming_message.content) then
                              writeMessageToStream (client.Socket, invalidPasswordMessage);
                           else
                              --# hole serverroomid zu diesem client vom server
                              declare
                                 id                   : Natural       := getNextChatRoomID (Server);
                                 chatroom             : chatRoomPtr;
                                 connectAcceptMessage : MessageObject :=
                                   createMessage
                                     (messagetype => Protocol.Connect,
                                      sender      => serverStr,
                                      receiver    => id,
                                      content     => To_Unbounded_String ("ok"));

                              begin
                                 -- # Weise Client eine ServerRoomID zu #
                                 serverRoomID := id;
                                 chatroom     := createChatRoom (Server, serverRoomID, client);
                                 writeMessageToStream (client.Socket, connectAcceptMessage);
                                 -- # Client in Verwaltungsliste speichern #
                                 Server.Connected_Clients.Insert (Key => user, New_Item => client);
                                 client.user := user;

                                 client.chatRoomList.Append (chatroom);

                                 client.ServerRoomID := serverRoomID;

                                 -- # setze Client auf online #
                                 -- # Sende online-Benachrichtigung an alle Kontakte des Clients#

                              end;
                           end if;
                        end if;
                     end;

                  -- ### CHAT ###
                  when Protocol.Chat => -- # chat:client:<ChatRoomID>:Hi #
                     declare
                        chatRoom       : chatRoomPtr;
                        refusedMessage : MessageObject;
                     begin
                        -- # echo Nachricht an alle Clienten im Raum
                        if (Server.chatRooms.Contains (incoming_message.receiver)) then
                           chatRoom := Server.chatRooms.Element (incoming_message.receiver);

                           -- # Pruefe, ob Client in ChatRoom eingeschrieben #
                           if (getClientList (chatRoom).Contains (client)) then
                              broadcastToChatRoom (chatRoom, incoming_message);
                           else
                              refusedMessage :=
                                createMessage
                                  (messagetype => Protocol.Refused,
                                   sender      => serverStr,
                                   receiver    => serverRoomID,
                                   content     =>
                                     To_Unbounded_String
                                       ("you are not in the chatroom with id " & Integer'Image (incoming_message.receiver)));
                              writeMessageToStream (client.Socket, refusedMessage);
                           end if;
                        else
                           refusedMessage :=
                             createMessage
                               (messagetype => Protocol.Refused,
                                sender      => serverStr,
                                receiver    => serverRoomID,
                                content     =>
                                  To_Unbounded_String
                                    ("there is no chatroom with id " & Integer'Image (incoming_message.receiver)));
                           writeMessageToStream (client.Socket, refusedMessage);
                        end if;
                     end;

                  ---### DISCONNECT ###
                  when Protocol.Disconnect => -- # disconnect:client:<ServerRoomID>:<?> #
                     declare
                        disconnectMessage : MessageObject;
                     begin
                        -- # Pruefe, ob die ServerRoomID die ServerRoomID des Clients ist
                        -- # Sende Disconnect-Bestaetigung
                        disconnectMessage :=
                          createMessage
                            (messagetype => Protocol.Disconnect,
                             sender      => serverStr,
                             receiver    => serverRoomID,
                             content     => To_Unbounded_String ("ok"));
                        writeMessageToStream (client.Socket, disconnectMessage);
                        -- # Schliesse Socket zu Client #
                        Close_Socket (client.Socket);
                        -- # Setze User als offline #
                        Server.Connected_Clients.Delete (user);
                        -- # Benachrichtige GUI über Änderung der Connected_Clients
                        -- # Sende Offline-Status an alle Kontakte vom Client # #
                     end;

                  --- ### CHATREQUEST ###
                  when Protocol.Chatrequest => -- # chatrequest:clientA:<ServerRoomID>:clientB #
                     declare
                        roomID               : Natural             := getNextChatRoomID (Server);
                        requestingUser       : UserPtr             := getUser (Server.UserDatabase, incoming_message.sender);
                        userToAdd            : UserPtr             := getUser (Server.UserDatabase, incoming_message.content);
                        clientToAdd          : Concrete_Client_Ptr := Server.Connected_Clients.Element (userToAdd);
                        requestAcceptMessage : MessageObject       :=
                          createMessage
                            (messagetype => Protocol.Chatrequest,
                             sender      => serverStr,
                             receiver    => roomID,
                             content     => To_Unbounded_String ("ok"));
                        --#TODO welcher content in requestAcceptMessage?
                        chatRoom : chatRoomPtr;
                     begin
                        --#pruefe ob chat mit dieser Nummer bereits existiert
                        if not Server.chatRooms.Contains (incoming_message.receiver) then
                           writeMessageToStream
                             (ClientSocket => client.Socket,
                              message      =>
                                createMessage
                                  (messagetype => Protocol.Refused,
                                   sender      => serverStr,
                                   receiver    => serverRoomID,
                                   content     =>
                                     To_Unbounded_String
                                       ("invalid roomID in chatrequest, please use your serverRoomID for new chatrequests and the chatrommID for invites")));

                        elsif incoming_message.receiver = serverRoomID then
                           --#neuer Raum
                           chatRoom := createChatRoom (server => Server, id => roomID, firstClient => client);
                           writeMessageToStream (client.Socket, message => requestAcceptMessage);
                           addClientToChatroom (room => chatRoom, client => clientToAdd);
                           client.chatRoomList.Append (chatRoom);
                           clientToAdd.chatRoomList.Append (chatRoom);

                        else
                           --#alter Raum, User einladen
                           chatRoom := Server.chatRooms.Element (incoming_message.receiver);
                           addClientToChatroom (room => chatRoom, client => clientToAdd);
                           clientToAdd.chatRoomList.Append (chatRoom);
                           --#userlist rumschicken
                           broadcastToChatRoom (chatRoom, generateUserlistMessage (chatRoom));
                        end if;
                     end;

                  --- ### LEAVECHAT ###
                  when Protocol.Leavechat => -- # leavechat:client:<ChatRoomID>:<?> #
                     declare
                        chatRoom        : chatRoomPtr;
                        userlistMessage : MessageObject;
                        userleftMessage : MessageObject;
                        refusedMessage  : MessageObject;
                        refusedText     : Unbounded_String := incoming_message.sender;
                     begin
                        --# Pruefe, ob referenziertet Raum existiert
                        if Server.chatRooms.Contains (incoming_message.receiver) then
                           chatRoom := Server.chatRooms.Element (incoming_message.receiver);

                           --# Pruefe obClient in referenziertem Chatraum
                           if (client.chatRoomList.Contains (chatRoom)) then
                              removeClientFromChatroom (chatRoom, client);
                              userlistMessage := generateUserlistMessage (chatRoom);
                              broadcastToChatRoom (chatRoom, userlistMessage);
                              Ada.Strings.Unbounded.Append (refusedText, To_Unbounded_String (" left the chat."));
                              userleftMessage :=
                                createMessage
                                  (messagetype => Protocol.Chat,
                                   sender      => serverStr,
                                   receiver    => incoming_message.receiver,
                                   content     => refusedText);
                              broadcastToChatRoom (chatRoom, userleftMessage);
                           else
                              refusedMessage :=
                                createMessage
                                  (messagetype => Protocol.Refused,
                                   sender      => serverStr,
                                   receiver    => serverRoomID,
                                   content     =>
                                     To_Unbounded_String
                                       ("you are not in the chatroom with id " & Integer'Image (incoming_message.receiver)));
                              writeMessageToStream (client.Socket, refusedMessage);
                           end if;
                        else
                           refusedMessage :=
                             createMessage
                               (messagetype => Protocol.Refused,
                                sender      => serverStr,
                                receiver    => serverRoomID,
                                content     =>
                                  To_Unbounded_String
                                    ("there is no chatroom with id " & Integer'Image (incoming_message.receiver)));
                           writeMessageToStream (client.Socket, refusedMessage);
                        end if;

                     end;

                  -- ### REGISTER ###
                  when Protocol.Register => -- # register:<username>:0:<passwort>
                     declare
                        registrationComplete : Boolean;
                        registrationAccepted : MessageObject :=
                          createMessage
                            (messagetype => Protocol.Register,
                             sender      => serverStr,
                             receiver    => 0,
                             content     => To_Unbounded_String ("ok"));
                        registrationFailed : MessageObject :=
                          createMessage
                            (messagetype => Protocol.Refused,
                             sender      => serverStr,
                             receiver    => 0,
                             content     => To_Unbounded_String ("registration failed, name in use"));
                     begin
                        registrationComplete :=
                          Server.UserDatabase.registerUser
                          (username => incoming_message.sender, password => incoming_message.content);
                        if registrationComplete = True then
                           writeMessageToStream (client.Socket, registrationAccepted);
                        else
                           writeMessageToStream (client.Socket, registrationFailed);
                        end if;
                     end;

                  -- ### ADDCONTACT ###
                  when Protocol.addContact =>
                     declare
                        requestedUser           : UserPtr := getUser (Server.UserDatabase, incoming_message.content);
                        messageToRequestingUser : MessageObject;
                        messageToRequestedUser  : MessageObject;
                        bool                    : Boolean;
                     --requestingUser ist user
                     begin
			-- TODO: pruefe ob es die beiden User gibt

			-- #Pruefe, ob der umgekehrte Request beim Server eingetragen ist
                        if (checkIfCorrespondingContactRequestExists (Server, user, requestedUser)) then
			   -- #wenn ja -> stelle Kontakt her

                           -- #Kontaktanfrage aus Server-Liste rausnehmen
			   removeContactRequest (Server, requestedUser, user);

			   --  #User_Datenbank aktualisieren
                           bool := addContact (database => Server.UserDatabase, thisUser => user, contactToAdd => requestedUser);
			   bool := addContact (database => Server.UserDatabase, thisUser => requestedUser, contactToAdd => user);

                           --  # User benachrichten
                           messageToRequestingUser :=
                             createMessage
                               (messagetype => Protocol.Chat,
                                sender      => serverStr,
                                receiver    => serverRoomID,
                                content => To_Unbounded_String ("New Contact added: " & To_String (getUsername (requestedUser))));
                           messageToRequestedUser :=
                             createMessage
                               (messagetype => Protocol.Chat,
                                sender      => serverStr,
                                receiver    =>
                                  Server.Connected_Clients.Element (requestedUser).ServerRoomID, --TODO: Element kann fehlschlagen
                                content => To_Unbounded_String ("New Contact added: " & To_String (getUsername (user))));
                           writeMessageToStream (ClientSocket => client.Socket, message => messageToRequestingUser);
                           writeMessageToStream
                             (ClientSocket => Server.Connected_Clients.Element (requestedUser).Socket,
			      message      => messageToRequestedUser);


                        else
                           declare
                              ulist : dataTypes.UserSet.Set;
                           begin
                              -- # trage Kontaktanfrage in Serverliste ein
                              -- # Pruefe: hat dieser User schon offene Anfragen in der Serverliste
			      if Server.ContactRequests.Contains (Key => user) then
				 -- # Ja -> Füge Anfrage in bestehendes Set ein
                                 ulist := Server.ContactRequests.Element (Key => user);
                                 ulist.Insert (New_Item => requestedUser);
			      else
				 -- # Nein -> Erstelle neues Set mit der Anfrage
                                 ulist.Insert (New_Item => requestedUser);
                                 -- # Füge Anfragenliste des Users in die Map ein
                                 Server.ContactRequests.Insert (Key => user, New_Item => ulist);
                              end if;
                           end;
                        end if;
                     end;

                  -- ### OTHERS ###
                  when others => -- # Online/Offline/Userlist/Refused/Invalid/ #
                     null;
               end case;

            end;
         end;
      end loop;

   exception
      when Error : Socket_Error =>
         Put ("Socket_Error in Client_Task: ");
         Put_Line (Exception_Information (Error));
      when Error : others =>
         Put ("Unexpected exception in Client_Task: ");
         Put_Line (Exception_Information (Error));
   end Client_Task;

   ----------------------------------------------------------------------------------------

   function Hash (R : Natural) return Hash_Type is
   begin
      return Hash_Type (R);
   end Hash;

   ----------------------------------------------------------------------------------------

   procedure addClientToChatroom (room : in out chatRoomPtr; client : in Concrete_Client_Ptr) is
   begin
      room.clientList.Append (client);
   end addClientToChatroom;

   ----------------------------------------------------------------------------------------

   procedure removeClientFromChatroom (room : in out chatRoomPtr; clientToRemove : in Concrete_Client_Ptr) is
      pos : Client_List.Cursor := room.clientList.Find (Item => clientToRemove);
   begin
      if room.clientList.Contains (clientToRemove) then
         room.clientList.Delete (Position => pos);
      end if;
   end removeClientFromChatroom;

   ----------------------------------------------------------------------------------------

   function createChatRoom
     (server      : in out Concrete_Server_Ptr;
      id          : in     Natural;
      firstClient : in     Concrete_Client_Ptr) return chatRoomPtr
   is
      room : chatRoomPtr := new chatRoom;
   begin
      room            := new chatRoom;
      room.chatRoomID := id;
      addClientToChatroom (room => room, client => firstClient);
      server.chatRooms.Insert (Key => id, New_Item => room);
      return room;

   end createChatRoom;

   ----------------------------------------------------------------------------------------

   function userHash (userToHash : UserPtr) return Hash_Type is
   begin
      return Ada.Strings.Unbounded.Hash (getUsername (userToHash));
   end userHash;

   ----------------------------------------------------------------------------------------

   function getClientList (room : in chatRoomPtr) return Client_List.List is
   begin
      return room.clientList;
   end getClientList;

   ----------------------------------------------------------------------------------------

   function generateUserlistMessage (room : in chatRoomPtr) return MessageObject is
      result     : Unbounded_String;
      clientList : Client_List.List := room.clientList;
      message    : MessageObject;
   begin
      for client of clientList loop
         Append (result, To_Unbounded_String (Protocol.Seperator));
         Append (result, getUsername (client.user));
      end loop;
      Ada.Strings.Unbounded.Delete (result, 1, 1);
      message :=
        createMessage
          (messagetype => Protocol.Userlist,
           sender      => To_Unbounded_String ("server"),
           receiver    => getChatRoomID (room),
           content     => result);
      return message;
   end generateUserlistMessage;

   ----------------------------------------------------------------------------------------

   procedure broadcastToChatRoom (room : in chatRoomPtr; message : in MessageObject) is
   begin
      for client of getClientList (room) loop
         writeMessageToStream (client.Socket, message);
      end loop;
   end broadcastToChatRoom;

   ----------------------------------------------------------------------------------------

   function getChatRoomID (room : in chatRoomPtr) return Natural is
   begin
      return room.chatRoomID;
   end getChatRoomID;

   ----------------------------------------------------------------------------------------

   function checkIfCorrespondingContactRequestExists
     (server         : in Concrete_Server_Ptr;
      requestingUser :    UserPtr;
      requestedUser  :    UserPtr) return Boolean
   is
      ulist : dataTypes.UserSet.Set;
   begin
      if (server.ContactRequests.Contains (requestedUser)) then
         ulist := server.ContactRequests.Element (requestedUser);
         return ulist.Contains (requestingUser);
      end if;
      return False;
   end checkIfCorrespondingContactRequestExists;

   procedure removeContactRequest (server : in out Concrete_Server_Ptr; requestingUser : UserPtr; requestedUser : UserPtr) is
      ulist : dataTypes.UserSet.Set;
      pos   : dataTypes.UserSet.Cursor;
   begin
      if server.ContactRequests.Contains (requestingUser) then
         ulist := server.ContactRequests.Element (requestingUser);
         pos   := ulist.Find (requestedUser);
         -- TODO: find kann fehlschalgen, noch pruefen
         ulist.Delete (pos);
         if ulist.Is_Empty then
            server.ContactRequests.Delete (requestingUser);
         end if;
      end if;

   end removeContactRequest;

end Concrete_Server_Logic;
