package body Concrete_Server_Logic is

   Server     : Concrete_Server_Ptr;
   concServer : aliased Concrete_Server;
   gui : STG.GUI'Class;

-----------------------------------------------------------------------------

   procedure StartNewServer (This : in out Concrete_Server; ip : String; port : Natural) is
   begin
      -- # Erzeugte Serverintanz global setzen, damit sie im Package ueberall bekannt ist #
      concServer := This;
      Server     := concServer'Access;

      -- # Datenbank laden #
      User_Databases.loadUserDatabase (Server.UserDatabase);
      Put_Line ("User database loadad.");

      --#Sockets aufbauen
      InitializeServer (Server, ip, port);

   end StartNewServer;

   -----------------------------------------------------------------------------

   function getNextChatRoomID (server : in out Concrete_Server_Ptr) return Natural is
      id : Natural;
   begin
      id                       := server.chatRoomIDCounter;
      server.chatRoomIDCounter := server.chatRoomIDCounter + 1;
      return id;
   end getNextChatRoomID;

-----------------------------------------------------------------------------

   procedure InitializeServer (This : in out Concrete_Server_Ptr; ip : String; port : Natural) is
      SubServer      : Concrete_Client_Ptr := new Concrete_Client;
      connectMessage : MessageObject;
   begin

      -- # Erzeugung und Konfiguration des Server-Sockets #
      Initialize;
      Create_Socket (Socket => Server.Socket);
      -- this.SocketAddress.Family := Gnat.Sockets.Family_Inet; -- Diskriminanten-Fehler, ka wie loesen!
      Server.SocketAddress.Addr := Inet_Addr (ip);
      Server.SocketAddress.Port := Port_Type (port);
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
           content     => To_Unbounded_String ("password"));

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
                        alreadyLoggedInMessage : MessageObject :=
                          createMessage
                            (messagetype => Protocol.Refused,
                             sender      => serverStr,
                             receiver    => 0,
                             content     => To_Unbounded_String ("user already logged in"));
                        alreadyConnectedMessage : MessageObject :=
                          createMessage
                            (messagetype => Protocol.Refused,
                             sender      => serverStr,
                             receiver    => 0,
                             content     => To_Unbounded_String ("you are already logged in to an account"));

                        userpassword : Unbounded_String;
                     begin
                        -- # Pruefe ob Benutzer registriert und Passwort richtig #
                        user := Server.UserDatabase.getUser (username => incoming_message.sender);

                        if user = null then
                           writeMessageToStream (ClientSocket => client.Socket, message => userNotFoundMessage);
                        elsif client.user /= null then
                           --# Prüefe ob Client schon mit einem User verbunden ist
                           writeMessageToStream (ClientSocket => client.Socket, message => alreadyConnectedMessage);
                        elsif Server.Connected_Clients.Contains (user) then
                           -- # Prüfe ob User, für den sich angemeldet wurde, schon angemeldet ist
                           writeMessageToStream (client.Socket, alreadyLoggedInMessage);
                        else
                           userpassword := getPassword (user);
                           -- TODO: das Passwort sollte vom Client bereits verschluesselt verschickt werden!!
                           if userpassword /= encodePassword (incoming_message.content) then
                              writeMessageToStream (client.Socket, invalidPasswordMessage);
                           else
                              -- # CONNECT ERFOLGREICH
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
                                 clientContacts      : dataTypes.UserList.List := getContacts (user);
                                 clientOnlineMessage : MessageObject;
                              begin
                                 -- # Weise Client eine ServerRoomID zu #
                                 serverRoomID        := id;
                                 client.ServerRoomID := serverRoomID;
                                 chatroom            := createChatRoom (Server, serverRoomID, client);
                                 writeMessageToStream (client.Socket, connectAcceptMessage);
                                 -- # Client in Verwaltungsliste speichern #
                                 Server.Connected_Clients.Insert (Key => user, New_Item => client);
                                 client.user := user;
                                 -- # Füge server zu Chatraumliste des Clients hinzu
                                 client.chatRoomList.Append (chatroom);
                                 -- # Sende online-Benachrichtigungen
                                 for contact of clientContacts loop
                                    declare
                                       contactClient : Concrete_Client_Ptr;
                                    begin
                                       -- # Pruefe ob Kontakt online
                                       if (Server.Connected_Clients.Contains (contact)) then
                                          -- # sende Kontakt, dass User online ist
                                          contactClient       := Server.Connected_Clients.Element (contact);
                                          clientOnlineMessage :=
                                            createMessage
                                              (Protocol.Online,
                                               serverStr,
                                               contactClient.ServerRoomID,
                                               getUsername (user));
                                          writeMessageToStream (contactClient.Socket, clientOnlineMessage);
                                          -- # sende User, dass Kontakt online ist
                                          clientOnlineMessage :=
                                            createMessage
                                              (Protocol.Online,
                                               serverStr,
                                               client.ServerRoomID,
                                               getUsername (contact));
                                          writeMessageToStream (client.Socket, clientOnlineMessage);
                                       else
                                          -- # sende User, dass Kontakt offline ist
                                          clientOnlineMessage :=
                                            createMessage
                                              (Protocol.Offline,
                                               serverStr,
                                               client.ServerRoomID,
                                               getUsername (contact));
                                          writeMessageToStream (client.Socket, clientOnlineMessage);
                                       end if;
                                    end;
                                 end loop;
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
                        --# echo Nachricht an alle Clienten im Raum
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

                  -- ### DISCONNECT ###
                  when Protocol.Disconnect => -- # disconnect:client:<ServerRoomID>:<?> #
                     begin
                        disconnectClient (client);
                        -- # Task beenden
                        exit;
                     end;

                  -- ### CHATREQUEST ###
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
                        chatRoom : chatRoomPtr;
                     begin
                        if (getContacts (user).Contains (userToAdd)) then
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
                                          ("invalid roomID in chatrequest, please use your serverRoomID for new chatrequests and the specific chatrommID for invites")));

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
                        else
                           -- # Es existiert kein Kontakt mit dem angegebenem Namen
                           declare
                              noContactMessage : MessageObject :=
                                createMessage
                                  (Protocol.Refused,
                                   serverStr,
                                   client.ServerRoomID,
                                   To_Unbounded_String ("You have no contact with name " & To_String (incoming_message.content)));
                           begin
                              writeMessageToStream (client.Socket, noContactMessage);
                           end;
                        end if;

                     end;

                  -- ### LEAVECHAT ###
                  when Protocol.Leavechat => -- # leavechat:client:<ChatRoomID>:<?> #
                     declare
                        chatRoom       : chatRoomPtr;
                        refusedMessage : MessageObject;
                        refusedText    : Unbounded_String := incoming_message.sender;
                     begin
                        --# Pruefe, ob referenziertet Raum existiert
                        if Server.chatRooms.Contains (incoming_message.receiver) then
                           chatRoom := Server.chatRooms.Element (incoming_message.receiver);

                           --# Pruefe obClient in referenziertem Chatraum
                           if (client.chatRoomList.Contains (chatRoom)) then
                              removeClientFromChatroom (chatRoom, client);
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
                                    ("there is no chatroom with id" & Integer'Image (incoming_message.receiver)));
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
                          (username => incoming_message.sender, password => encodePassword (incoming_message.content));
                        if registrationComplete = True then
                           writeMessageToStream (client.Socket, registrationAccepted);
                        else
                           writeMessageToStream (client.Socket, registrationFailed);
                        end if;
                     end;

                  -- ### ADDCONTACT ###
                  when Protocol.addContact =>
                     declare
                        requestedUser           : UserPtr             := getUser (Server.UserDatabase, incoming_message.content);
                        requestedUserClient     : Concrete_Client_Ptr := Server.Connected_Clients.Element (requestedUser);
                        messageToRequestingUser : MessageObject;
                        messageToRequestedUser  : MessageObject;
                        bool                    : Boolean;
                     --requestingUser ist user
                     begin
                        -- TODO: pruefe ob es die beiden User gibt
                        if (checkIfContactRequestExists (Server, requestedUser, user)) then
                           -- stelle Kontakt her
                           --      Kontaktanfrage aus Liste rausnehmen
                           removeContactRequest (Server, requestedUser, user);

                           -- # User_Datenbank aktualisieren
                           -- # TODO return Wert abfragen
                           bool := addContact (this => user, contactToAdd => requestedUser);
                           bool := addContact (requestedUser, user);
                           saveUserDatabase (Server.UserDatabase);

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
                                receiver    => requestedUserClient.ServerRoomID, --TODO: Element kann fehlschlagen
                                content     => To_Unbounded_String ("New Contact added: " & To_String (getUsername (user))));
                           writeMessageToStream (ClientSocket => client.Socket, message => messageToRequestingUser);
                           writeMessageToStream (ClientSocket => requestedUserClient.Socket, message => messageToRequestedUser);

                           -- # Kontakte über online Status benachrichtigen
                           messageToRequestingUser :=
                             createMessage (Protocol.Online, serverStr, client.ServerRoomID, getUsername (requestedUser));
                           messageToRequestedUser :=
                             createMessage (Protocol.Online, serverStr, requestedUserClient.ServerRoomID, getUsername (user));
                           writeMessageToStream (ClientSocket => client.Socket, message => messageToRequestingUser);
                           writeMessageToStream (ClientSocket => requestedUserClient.Socket, message => messageToRequestedUser);
                        else
                           declare
                              ulist : dataTypes.UserList.List;
                           begin
                              -- trage Kontaktanfrage in serverliste ein
                              -- gibt es UserKey von Requests in Map
                              if Server.ContactRequests.Contains (Key => user) then
                                 ulist := Server.ContactRequests.Element (Key => user);
                                 ulist.Append (New_Item => requestedUser);
                              else
                                 -- requestedUser zur Liste hinzufuegen
                                 ulist.Append (New_Item => requestedUser);
                                 -- wenn nein, Key und Liste anlegen
                                 Server.ContactRequests.Insert (Key => user, New_Item => ulist);
                              end if;
                              -- # Benachrichtige requested user über Kontaktanfrage
                              messageToRequestedUser :=
                                createMessage
                                  (Protocol.addContact,
                                   serverStr,
                                   requestedUserClient.ServerRoomID,
                                   getUsername (user));
                              writeMessageToStream (requestedUserClient.Socket, messageToRequestedUser);
                           end;
                        end if;
                     end;

                  -- ### REMCONTACT ###
                  when Protocol.remContact =>
                     declare
                        requestedUser           : UserPtr := getUser (Server.UserDatabase, incoming_message.content);
                        requestedUserClient     : Concrete_Client_Ptr     := Server.Connected_Clients.Element (requestedUser);
                        userContacts            : dataTypes.UserList.List := getContacts (user);
                        messageToRequestingUser : MessageObject           :=
                          createMessage (Protocol.remContact, serverStr, client.ServerRoomID, incoming_message.content);
                        messageToRequestedUser : MessageObject :=
                          createMessage (Protocol.remContact, serverStr, requestedUserClient.ServerRoomID, getUsername (user));
                        bool : Boolean;
                     begin
                        -- #prüfe ob Kontakt zu angegebenen User besteht
                        if userContacts.Contains (requestedUser) then
                           -- #wenn ja, entferne kontakt zu angegebenen user
                           -- #TODO Rückgabewert abfangen
                           bool := removeContact (user, requestedUser);
                           -- #entferne user aus Kontakt des angegebenen Users
                           bool := removeContact (requestedUser, user);

                           saveUserDatabase (Server.UserDatabase);

                           -- #Benachrichtige die User über Löschen des Kontakts
                           writeMessageToStream (client.Socket, messageToRequestingUser);
                           writeMessageToStream (requestedUserClient.Socket, messageToRequestedUser);

                        -- # Kontaktanfrage ablehnen über RemContact
                        elsif
                          (checkIfContactRequestExists (server => Server, requestingUser => requestedUser, requestedUser => user))
                        then
                           removeContactRequest (server => Server, requestingUser => requestedUser, requestedUser => user);
                           -- # User muss benachrichtigt werden, dass seine Kontaktanfrage abgelehnt wurde
                           messageToRequestedUser :=
                             createMessage (Protocol.remContact, serverStr, requestedUserClient.ServerRoomID, getUsername (user));
                           writeMessageToStream (requestedUserClient.Socket, messageToRequestedUser);
                        else
                           -- # wenn keine Kontaktanfrage zu diesem Kontakt vorhanden
                           messageToRequestingUser :=
                             createMessage
                               (Protocol.Refused,
                                serverStr,
                                client.ServerRoomID,
                                To_Unbounded_String ("There is no contact request from " & To_String (incoming_message.content)));
                           writeMessageToStream (client.Socket, messageToRequestingUser);
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
         disconnectClient (client);
      when Error : others =>
         Put ("Unexpected exception in Client_Task: ");
         Put_Line (Exception_Information (Error));
         disconnectClient (client);
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
      pos                              : Client_List.Cursor := room.clientList.Find (Item => clientToRemove);
      userlistMessage, userleftMessage : MessageObject;
      userleftText                     : Unbounded_String   := getUsername (clientToRemove.user);
   begin
      if room.clientList.Contains (clientToRemove) then
         room.clientList.Delete (Position => pos);

         if (room.clientList.Length >= 1) then
            -- # broadcaste die neue Userlist und teile dem Chat mit, dass der Benutzer diesen verlassen hat
            userlistMessage := generateUserlistMessage (room);
            broadcastToChatRoom (room, userlistMessage);
            Ada.Strings.Unbounded.Append (userleftText, To_Unbounded_String (" left the chat."));
            userleftMessage :=
              createMessage
                (messagetype => Protocol.Chat,
                 sender      => To_Unbounded_String ("server"),
                 receiver    => room.chatRoomID,
                 content     => userleftText);
            broadcastToChatRoom (room, userleftMessage);
         else
            -- # TODO: lösche den chatraum
            null;
         end if;

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

   function checkIfContactRequestExists
     (server         : in Concrete_Server_Ptr;
      requestingUser :    UserPtr;
      requestedUser  :    UserPtr) return Boolean
   is
      ulist : dataTypes.UserList.List;
   begin
      if (server.ContactRequests.Contains (requestingUser)) then
         ulist := server.ContactRequests.Element (requestingUser);
         return ulist.Contains (requestedUser);
      end if;
      return False;
   end checkIfContactRequestExists;

   ----------------------------------------------------------------------------------------

   procedure removeContactRequest (server : in out Concrete_Server_Ptr; requestingUser : UserPtr; requestedUser : UserPtr) is
      ulist : dataTypes.UserList.List;
      pos   : dataTypes.UserList.Cursor;
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

   ----------------------------------------------------------------------------------------

   function getChatroomsOfClient (client : in Concrete_Client_Ptr) return chatRoom_List.List is
   begin
      return client.chatRoomList;
   end getChatroomsOfClient;

   ----------------------------------------------------------------------------------------

   procedure broadcastOnlineStatusToContacts (client : in Concrete_Client_Ptr; status : MessageTypeE) is
      serverStr           : Unbounded_String        := To_Unbounded_String ("server");
      contactList         : dataTypes.UserList.List := getContacts (client.user);
      contactClient       : Concrete_Client_Ptr;
      clientStatusMessage : MessageObject;
   begin
      for contact of contactList loop
         if (Server.Connected_Clients.Contains (contact)) then
            -- # sende Kontakt den User Status
            contactClient       := Server.Connected_Clients.Element (contact);
            clientStatusMessage := createMessage (status, serverStr, contactClient.ServerRoomID, getUsername (client.user));
            writeMessageToStream (contactClient.Socket, clientStatusMessage);
         end if;
      end loop;

   end broadcastOnlineStatusToContacts;

   ----------------------------------------------------------------------------------------

   procedure disconnectClient (client : in Concrete_Client_Ptr) is
      disconnectMessage : MessageObject;
      chatRoomsOfClient : chatRoom_List.List := getChatroomsOfClient (client);
      serverStr         : Unbounded_String   := To_Unbounded_String ("server");
   begin
      -- # Sende Disconnect-Bestaetigung
      disconnectMessage :=
        createMessage
          (messagetype => Protocol.Disconnect,
           sender      => serverStr,
           receiver    => client.ServerRoomID,
           content     => To_Unbounded_String ("ok"));
      writeMessageToStream (client.Socket, disconnectMessage);
      -- # Client verlässt alle Chaträume
      for chatRoom of chatRoomsOfClient loop
         removeClientFromChatroom (chatRoom, client);
      end loop;
      -- # Sende Offline-Status an alle Kontakte vom Client #
      broadcastOnlineStatusToContacts (client, Protocol.Offline);
      -- # Schliesse Socket zu Client #
      Close_Socket (client.Socket);
      -- # Setze User als offline #
      Server.Connected_Clients.Delete (client.user);
      -- # TODO: Benachrichtige GUI über Änderung der Connected_Clients
   end disconnectClient;

   ----------------------------------------------------------------------------------------

   overriding procedure startServer (thisServer : aliased in Concrete_Server; ipAdress : String; port : Natural) is
      serv : aliased Concrete_Server := thisServer;
   begin
      StartNewServer (serv, ipAdress, port);
   end startServer;

   ----------------------------------------------------------------------------------------

   ----------------------------------------------------------------------------------------

   procedure kickUserWithName (thisServer : aliased in Concrete_Server; username : String) is
      user   : UserPtr             := getUser (Server.UserDatabase, username => To_Unbounded_String (username));
      client : Concrete_Client_Ptr := Server.Connected_Clients.Element (user);
   begin
      disconnectClient (client);
   end kickUserWithName;

   ----------------------------------------------------------------------------------------

   procedure stopServer (thisServer : aliased in Concrete_Server) is
   begin
      --# TODO
      null;
   end stopServer;
   ----------------------------------------------------------------------------------------

   overriding
   function loadDB(thisServer : aliased in Concrete_Server; DataFile : File_type) return Boolean is
   begin
      -- TODO
      return false;
   end loadDB;

   ----------------------------------------------------------------------------------------

   procedure saveDB(thisServer : aliased in Concrete_Server; DataFile : File_type) is
   begin
      -- TODO
      null;
   end saveDB;

   ----------------------------------------------------------------------------------------

   procedure closeServer(thisServer : aliased in Concrete_Server) is
   begin
      -- TODO
      null;
   end closeServer;

   ----------------------------------------------------------------------------------------

   procedure sendMessageToUser(thisServer : aliased in Concrete_Server; username : String; messagestring : String) is
   begin
      -- TODO
      null;
   end sendMessageToUser;

   ----------------------------------------------------------------------------------------

   procedure deleteUserFromDatabase(thisServer : aliased in Concrete_Server; username : String) is
   begin
      -- TODO
      null;
   end deleteUserFromDatabase;

   ----------------------------------------------------------------------------------------

end Concrete_Server_Logic;
