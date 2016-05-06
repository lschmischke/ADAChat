with Concrete_Server_Gui_Logic; use Concrete_Server_Gui_Logic;

package body Concrete_Server_Logic is

   gui : GUIPtr := new Concrete_Server_Gui_Logic.Server_Gui;
   Server : Concrete_Server_Ptr;

-----------------------------------------------------------------------------

   task body Main_Server_Task is
   begin
      accept Start;

      -- # Abhoerroutine auf Aktivitaet am Server-Socket #
      loop
         declare
	    Client : Concrete_Client_Ptr := new Concrete_Client;
	    cTask : Client_Task_Ptr:= new Client_Task;
	    cSocket : Socket_Type;
	    cAddress : Sock_Addr_Type;
         begin
            -- # Auf Verbindungsanfrage warten, annehmen, Client-Socket erzeugen und neue Adresse an diesen binden #
            gui.printInfoMessage("Ready to accept incoming Connections...");
            Accept_Socket
              (Server  => Server.getSocket,
               Socket  => cSocket,
	       Address => cAddress); -- Blockierender Aufruf
	    client.setSocket(cSocket);
	    client.setSocketAddress(cAddress);
            gui.printInfoMessage("Incoming Connection from " & GNAT.Sockets.Image (Client.getSocketAddress) & " accepted");

	    -- # Neuen Kommunikationstask für Client erzeugen, hinterlegen und starten #
	    cTask.Start(Client);
	 end;
      end loop;
   exception
      when Error : Socket_Error =>
	 gui.printErrorMessage("Socket_Error in Main_Server_Task: " & "terminated Main Server Task");
      when Error : others =>
         gui.printErrorMessage("Unexpected exception in Main_Server_Task: " & Exception_Information (Error));
   end Main_Server_Task;

-----------------------------------------------------------------------------

   task body Client_Task is
      client       : Concrete_Client_Ptr;
      user         : UserPtr;
      serverRoomID : Integer;
      serverStr    : Unbounded_String := To_Unbounded_String ("server");
   begin
-- # Info: waehrend dieser Aktivierungsphase wird der aufrufende Task blockiert
      accept Start (newClient : Concrete_Client_Ptr)do
	 client := newClient;
      end Start; -- Jetzt laeuft dieser erst nebenlaeufig weiter! #

      gui.printInfoMessage("New Client Task for " & GNAT.Sockets.Image (client.getSocketAddress) & " successfully started");

      -- InputChannel := Stream(ClientSocket);

      gui.printInfoMessage("Waiting for incoming data from " & GNAT.Sockets.Image (client.getSocketAddress) & " ...");

      -- # Abhoerroutine2 auf Aktivitaet am Client-Socket #
      <<Continue>>
      loop
         declare
            incoming_message : MessageObject;
            invalidMessageContent : Unbounded_String := To_Unbounded_String("illegal receiver, message ignored");
            validReceiver : Boolean := false;
         begin

            -- # Nachricht liegt vor, nun wird diese verarbeitet und interpretiert #
            declare
            begin
               -- # Nachricht wird aus String erstellt #
               incoming_message := readMessageFromStream (ClientSocket => client.getSocket);

               -- # Stelle die Nachricht dar
               if incoming_message.messagetype /= Protocol.Invalid then
                  Protocol.printMessageToInfoConsole (message => incoming_message);
	       end if;

               -- # Prüft bei gültig zusammengestellten Nachrichten, ob der Sender dem eingeloggten Benutzer entspricht und ob eine gültiger Chatraum adressiert wurde
	       if incoming_message.messagetype /= INVALID and then user /= null and then user.getUsername /= incoming_message.sender then
                  invalidMessageContent := To_Unbounded_String("sender doesn't match with username, messaged ignored");
                  Put_Line("illegal username");
                  validReceiver := false;
               elsif incoming_message.receiver = 0 and then client.getServerroomID = 0 then
                  validReceiver := true;
               else
                  for chatRoom of client.getChatroomList loop
                     if chatRoom.getChatRoomID = incoming_message.receiver then
                        validReceiver := true;
                        exit;
                     end if;
                  end loop;
               end if;

               if validReceiver = false then
                  Put_Line("illegal username or receiver");
                  incoming_message.messagetype := Invalid;
                  client.sendServerMessageToClient(Refused,To_String(invalidMessageContent));
               end if;

               -----------------------------------------------------------------

               case incoming_message.messagetype is
                  -- ### CONNECT ###
                  when Protocol.Connect => -- # connect:client:0:<passwort> #
		     declare

			userpassword : Unbounded_String;
			messageContent: Unbounded_String;
                     begin
                        -- # Pruefe ob Benutzer registriert und Passwort richtig #
                        user := Server.getUserDatabase.getUser (username => incoming_message.sender);

			if user = null then
			   messageContent := To_Unbounded_String("user '"& To_String(incoming_message.sender)& "' not found in database");
			   Server.declineConnectionWithRefusedMessage(client,To_String(messageContent));
			   gui.printErrorMessage("Connection request from " & Gnat.Sockets.Image(client.getSocketAddress.Addr) & " declined: " & To_String(messageContent));
                        elsif client.getUser /= null then
			   --# Prüefe ob Client schon mit einem User verbunden ist
			   messageContent := To_Unbounded_String("you are already logged in to an account");
			   Server.declineConnectionWithRefusedMessage(client, To_String(messageContent));
			   gui.printErrorMessage("Connection request from " & Gnat.Sockets.Image(client.getSocketAddress.Addr) & " declined: " & To_String(messageContent));
                        elsif Server.getConnectedClients.Contains (user) then
			   -- # Prüfe ob User, für den sich angemeldet wurde, schon angemeldet ist
			   messageContent := To_Unbounded_String("user '"& To_String(incoming_message.sender)& "' already logged in");
			   Server.declineConnectionWithRefusedMessage(client,To_String(messageContent));
			   gui.printErrorMessage("Connection request from " & Gnat.Sockets.Image(client.getSocketAddress.Addr) & " declined: " & To_String(messageContent));
                        else
                           userpassword := user.getPassword;
                           -- TODO: das Passwort sollte vom Client bereits verschluesselt verschickt werden!!
			   if userpassword /= encodePassword (incoming_message.content) then
			      messageContent := To_Unbounded_String("invalid password");
			      Server.declineConnectionWithRefusedMessage(client,To_String(messageContent));
			      gui.printErrorMessage("Connection request from " & Gnat.Sockets.Image(client.getSocketAddress.Addr) & " declined: " & To_String(messageContent));
                           else
                              -- # CONNECT ERFOLGREICH
                              --# hole serverroomid zu diesem client vom server
                              declare
                                 chatroom             : chatRoomPtr;
                                 clientContacts      : dataTypes.UserList.List := user.getContacts;
                              begin
				 -- # Weise Client eine ServerRoomID zu und init Client #
				 Server.createChatRoom (client,chatroom);
                                 serverRoomID        := chatroom.getChatRoomID;
				 client.setServerRoomID(serverRoomID);
				 client.setUser(user);

				 client.sendServerMessageToClient(Connect,"ok");

                                 -- # Client in Verwaltungsliste speichern #
                                 Server.addClientToConnectedClients(client);

                                 -- # Füge server zu Chatraumliste des Clients hinzu
				 client.addChatroom (chatroom);

                                 -- # teile GUI mit, dass user online gekommen ist
				 gui.updateOnlineUserOverview(Server.connectedClientsToClientList);
                                 gui.printInfoMessage("'"&To_String(user.getUsername) & "' has come online.");
                                 gui.updateChatroomOverview(Server.getChatrooms);

                                 -- # Sende online-Benachrichtigungen
                                 for contact of clientContacts loop
                                    declare
				       contactClient : Concrete_Client_Ptr;
				       connectedClients : userToClientMap.Map := Server.getConnectedClients;
                                    begin
                                       -- # Pruefe ob Kontakt online
				       if (connectedClients.Contains (contact)) then
					  contactClient := server.getClientToConnectedUser(contact);
                                          -- # sende Kontakt, dass User online ist
					  contactClient.sendServerMessageToClient(Online,To_String(user.getUsername));
                                          -- # sende User, dass Kontakt online ist
					  client.sendServerMessageToClient(Online,To_String(contact.getUsername));
                                       else
                                          -- # sende User, dass Kontakt offline ist
					  client.sendServerMessageToClient(Offline,To_String(contact.getUsername));
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
                        outMessage : MessageObject := createMessage(incoming_message.messagetype,incoming_message.sender,incoming_message.receiver,incoming_message.content);
                     begin
                        -- # Pruefe, ob Chatraum mit angegebener Nummer existiert
                        if (Server.getChatrooms.Contains (incoming_message.receiver)) then
                           chatRoom := Server.getChatrooms.Element (incoming_message.receiver);

                           -- # Pruefe, ob Client in ChatRoom eingeschrieben #
			   if (chatRoom.getClientList.Contains (client)) then
			      --# echo Nachricht an alle Clienten im Raum
                              chatRoom.broadcastToChatRoom (outMessage);
                              gui.printChatMessage(incoming_message);
                           else
			      client.sendServerMessageToClient(Refused,"you are not in the chatroom with id " & Integer'Image (incoming_message.receiver)&".");
                           end if;
                        else
			   client.sendServerMessageToClient(Refused,"there is no chatroom with id " & Integer'Image (incoming_message.receiver)&".");
                        end if;
                     end;

                  -- ### DISCONNECT ###
                  when Protocol.Disconnect => -- # disconnect:client:<ServerRoomID>:<?> #
                     begin
			Server.disconnectClient (client,"ok");
                        -- # TODO: Task beenden
                        exit;
                     end;

                  -- ### CHATREQUEST ###
                  when Protocol.Chatrequest => -- # chatrequest:clientA:<ServerRoomID>:clientB #
                     declare
                        requestingUser       : UserPtr             := Server.getUserDatabase.getUser (incoming_message.sender);
			userToAdd            : UserPtr             := Server.getUserDatabase.getUser (incoming_message.content);
			clientToAdd          : Concrete_Client_Ptr := Server.getClientToConnectedUser(userToAdd);
			chatRoom : chatRoomPtr;
		     begin
			--# TODO: getUser Fehler abfangen
			--# Pruefe, ob Kontakt zu angegebenem User besteht
                        if (user.getContacts.Contains (userToAdd)) then
			   --# Pruefe, ob Chat mit dieser Nummer bereits existiert
			   if not Server.getChatrooms.Contains (incoming_message.receiver) then
			      client.sendServerMessageToClient(Refused,"invalid roomID in chatrequest, please use your serverRoomID for new chatrequests and the specific chatroomID for invites");
			      gui.printErrorMessage("Chatroomrequest from '"&To_String(user.getUsername) &"' denied: invalid roomID (does not exist).");
                           elsif incoming_message.receiver = serverRoomID then
			      --# neuen Raum anlegen
                              Server.createChatRoom (firstClient => client,room => chatRoom );
			      chatRoom.addClientToChatroom (client => clientToAdd);

			      -- # Füge Chatroom in Liste beider Clients hinzu
			      client.addChatroom(chatRoom);
			      clientToAdd.addChatroom(chatRoom);
                              client.sendServerMessageToClient(Chatrequest,To_String(userToAdd.getUsername),chatRoom.getChatRoomID);

                              -- # Teile den Teilnehmern die Userlist mit
                              chatRoom.broadcastToChatRoom(chatRoom.generateUserlistMessage);

                              -- # Benachrichtige GUI
                              gui.updateChatroomOverview(Server.getChatrooms);
			      gui.printInfoMessage("Chatroomrequest from '"&To_String(user.getUsername)& "' accepted: created chatroom '"&Natural'Image(chatroom.getChatRoomID) & "' with user '"&To_String(userToAdd.getUsername));
                           else
                              --# alter Raum, User einladen

                              -- # Prüfe, ob es sich beim angegebenen Raum um den Serverchat handelt
                              chatRoom := Server.getchatRooms.Element (incoming_message.receiver);
                              chatRoom.addClientToChatroom (client => clientToAdd);
			      clientToAdd.addChatroom(chatRoom);

			      --# userlist rumschicken
			      chatRoom.broadcastToChatRoom (chatRoom.generateUserlistMessage);

                              -- # Benachrichtige GUI
                              gui.updateChatroomOverview(Server.getChatrooms);
			       gui.printInfoMessage("Chatroomrequest from '"&To_String(user.getUsername)& "' accepted: invited '"&To_String(userToAdd.getUsername)&"' to chatroom '"&Natural'Image(chatroom.getChatRoomID));
                           end if;
                        else
                           -- # Es existiert kein Kontakt mit dem angegebenem Namen
			   client.sendServerMessageToClient(Refused,"You have no contact with name " & To_String (incoming_message.content)&".");
			   gui.printErrorMessage("Chatroomrequest from '"&To_String(user.getUsername &"' denied: not contact with '"& To_string(userToAdd.getUsername&"'.")));
                        end if;

                     end;

                  -- ### LEAVECHAT ###
                  when Protocol.Leavechat => -- # leavechat:client:<ChatRoomID>:<?> #
                     declare
                        chatRoom       : chatRoomPtr;
                     begin
                        --# Pruefe, ob referenziertet Raum existiert
                        if Server.getChatrooms.Contains (incoming_message.receiver) then
                           chatRoom := Server.getChatrooms.Element (incoming_message.receiver);
                           --# Pruefe ob Client in referenziertem Chatraum
                           if (client.getChatroomList.Contains (chatRoom)) then
                              chatRoom.removeClientFromChatroom (client);
                              gui.updateChatroomOverview(Server.getChatrooms);
			      gui.printInfoMessage("'"&To_String(client.getUsernameOfClient)&"' left the chatroom with ID '"&Natural'Image(chatRoom.getChatRoomID)&"'");
                           else
			      client.sendServerMessageToClient(Refused,"you are not in the chatroom with id " & Integer'Image (incoming_message.receiver)&".");
                           end if;
                        else
			   client.sendServerMessageToClient(Refused,"there is no chatroom with id" & Integer'Image (incoming_message.receiver)&".");
                        end if;
                     end;

                  -- ### REGISTER ###
                  when Protocol.Register => -- # register:<username>:0:<passwort>
                     declare
                        registrationComplete : Boolean;
                     begin
                          Server.getUserDatabase.registerUser
                          (username => incoming_message.sender, password => encodePassword (incoming_message.content),success => registrationComplete);
			if registrationComplete = True then
			   client.sendServerMessageToClient(Register,"ok");
			   gui.printInfoMessage("New user '"&To_String(incoming_message.sender)&"' registered");
			else
			   client.sendServerMessageToClient(Refused,"registration failed, name in use");
                        end if;
                     end;

                  -- ### ADDCONTACT ###
                  when Protocol.addContact =>
                     declare
                        requestedUser           : UserPtr             := Server.getUserDatabase.getUser (incoming_message.content);
                        requestedUserClient     : Concrete_Client_Ptr := Server.getConnectedClients.Element (requestedUser);
                     --requestingUser ist user
                     begin
			-- TODO: pruefe ob es die beiden User gibt
			if requestedUser = null then
			   client.sendServerMessageToClient(refused,"'"&To_String(incoming_message.content&"' doesn't exist."));
			   goto Continue;
			end if;

			-- # Pruefe, ob eine Kontaktanfrage beantwortet wird
                        if (Server.checkIfContactRequestExists (requestedUser, user)) then
                           -- # stelle Kontakt her
                           -- # Kontaktanfrage aus Liste rausnehmen
                           Server.removeContactRequest (requestedUser, user);

                           -- # User_Datenbank aktualisieren
                           user.addContact (contactToAdd => requestedUser);
                           requestedUser.addContact (user);
                           Server.getUserDatabase.saveUserDatabase;

                           --  # User benachrichten
			   requestedUserClient.sendServerMessageToClient(Chat,"New Contact added: " & To_String (user.getUsername));
			   client.sendServerMessageToClient(Chat,"New Contact added: " & To_String (requestedUser.getUsername));

                           -- # Kontakte über online Status benachrichtigen
			   client.sendServerMessageToClient(Online,To_String(requestedUser.getUsername));
			   requestedUserClient.sendServerMessageToClient(Online,To_String(user.getUsername));

			   -- # GUI informieren
			   gui.printInfoMessage("'"&To_string(user.getUsername)&"' accepted contact request from '"&To_String(requestedUser.getUsername)&"'.");
			   gui.printInfoMessage("'"&To_String(user.getUsername)&"' and '"&To_String(requestedUser.getUsername)&"' are now contacts.");
                        else
                           declare
                              ulist : dataTypes.UserList.List;
                           begin
			      -- # trage Kontaktanfrage in serverliste ein
			      Server.addContactRequest(user,requestedUser);

                              -- # Benachrichtige requested user über Kontaktanfrage
			      requestedUserClient.sendServerMessageToClient(addContact,To_String(user.getUsername));

			      -- # Benachrichtige GUI
			      gui.printInfoMessage("'"&To_String(user.getUsername)&"' sent contact request to '"&To_String(requestedUser.getUsername)&"'.");
                           end;
                        end if;
                     end;

                  -- ### REMCONTACT ###
                  when Protocol.remContact =>
                     declare
                        requestedUser           : UserPtr := Server.getUserDatabase.getUser (incoming_message.content);
                        requestedUserClient     : Concrete_Client_Ptr     := Server.getConnectedClients.Element (requestedUser);
                        userContacts            : dataTypes.UserList.List := user.getContacts;
		     begin
			-- # prüfe, ob requestierter Nutzer existiert
			if requestedUser = null then
			   client.sendServerMessageToClient(refused,"'"&To_String(incoming_message.content&"' doesn't exist."));
			   goto Continue;
			end if;

                        -- #prüfe ob Kontakt zu angegebenen User besteht
                        if userContacts.Contains (requestedUser) then
                           -- #wenn ja, entferne kontakt zu angegebenen user
                           user.removeContact (requestedUser);
                           -- #entferne user aus Kontakt des angegebenen Users
                           requestedUser.removeContact (user);

                           Server.getUserDatabase.saveUserDatabase;

                           -- #Benachrichtige die User über Löschen des Kontakts
			   client.sendServerMessageToClient(remContact,To_String(incoming_message.content));
			   if requestedUserClient /= null then
			      requestedUserClient.sendServerMessageToClient(remContact,To_String(user.getUsername));
			   end if;

			   -- # Benachrichtige GUI
			   gui.printInfoMessage("'"&To_String(user.getUsername&"' and '" &To_String(requestedUser.getUsername&"' are no longer contacts")));

                        -- # Kontaktanfrage ablehnen über RemContact
                        elsif Server.checkIfContactRequestExists (requestedUser, user) then
                           Server.removeContactRequest (requestingUser => requestedUser, requestedUser => user);
                           -- # User muss benachrichtigt werden, dass seine Kontaktanfrage abgelehnt wurde
			   requestedUserClient.sendServerMessageToClient(remContact,To_String(user.getUsername ));
			   -- # GUI benachrichtigen
			   gui.printInfoMessage("'"&To_String(user.getUsername)&"' has declined the contact request from '"&To_String(requestedUser.getUsername)&"'.");
                        else
                           -- # wenn keine Kontaktanfrage zu diesem Kontakt vorhanden
			   client.sendServerMessageToClient(Refused,"There is no contact request from " & To_String (incoming_message.content));
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
         Server.removeClientRoutine(client);
      when Error : others =>
         Put ("Unexpected exception in Client_Task: ");
         Put_Line (Exception_Information (Error));
         Server.disconnectClient (client,"unspecified error");
   end Client_Task;

   ----------------------------------------------------------------------------------------

   function Hash (R : Natural) return Hash_Type is
   begin
      return Hash_Type (R);
   end Hash;

   ----------------------------------------------------------------------------------------

   function userHash (userToHash : UserPtr) return Hash_Type is
   begin
      return Ada.Strings.Unbounded.Hash (userToHash.getUsername);
   end userHash;

   ----------------------------------------------------------------------------------------

   overriding
   procedure startServer (thisServer : aliased in out Concrete_Server; ipAdress : String; port : Natural) is
   begin
      Server := thisServer'Access;
      Server.StartNewServer (ipAdress, port);
   end startServer;

   ----------------------------------------------------------------------------------------

   procedure kickUserWithName (thisServer : aliased in out Concrete_Server; username : String) is
      user   : UserPtr             := thisServer.getUserDatabase.getUser (username => To_Unbounded_String (username));
      client : Concrete_Client_Ptr := thisServer.getConnectedClients.Element (user);
   begin
      thisServer.disconnectClient (client,"kicked");
   end kickUserWithName;

   ----------------------------------------------------------------------------------------

   procedure stopServer (thisServer : aliased in out Concrete_Server) is
   begin
      for client of thisServer.getConnectedClients loop
	 thisServer.disconnectClient(client,"server shut down");
      end loop;

      Close_Socket(thisServer.getSocket);
   end stopServer;

   ----------------------------------------------------------------------------------------

   overriding
   function loadDB(thisServer : aliased in out Concrete_Server; DataFile : File_type) return Boolean is
   begin
      -- TODO
      return false;
   end loadDB;

   ----------------------------------------------------------------------------------------

   procedure saveDB(thisServer : aliased in out Concrete_Server; DataFile : File_type) is
   begin
      -- TODO
      null;
   end saveDB;

   ----------------------------------------------------------------------------------------

   procedure sendMessageToUser(thisServer : aliased in out Concrete_Server; username : String; messagestring : String) is
      user : UserPtr := thisServer.getUserDatabase.getUser(To_Unbounded_String(username));
      client : Concrete_Client_Ptr := thisServer.getConnectedClients.Element(user);
      msg : MessageObject := createMessage(messagetype => Protocol.Chat,
                                           sender      => To_Unbounded_String("server"),
                                           receiver    => client.getServerRoomID,
                                           content     => To_Unbounded_String(messagestring));
   begin
      writeMessageToStream(ClientSocket => client.getSocket,
                           message      => msg);
   end sendMessageToUser;

   ----------------------------------------------------------------------------------------

   procedure deleteUserFromDatabase(thisServer : aliased in out Concrete_Server; username : String) is
   begin
      null;
   end deleteUserFromDatabase;

   ----------------------------------------------------------------------------------------
   ----------------------------------------------------------------------------------------

   protected body Concrete_Server is
      ----------------------------------------------------------------------------------------

      function getSocket return Socket_Type is
      begin
	 return Socket;
      end getSocket;

      ----------------------------------------------------------------------------------------

      function getSocketAddress return Sock_Addr_Type is
      begin
	 return SocketAddress;
      end getSocketAddress;

      ----------------------------------------------------------------------------------------

      function getConnectedClients return userToClientMap.Map is
      begin
	 return Connected_Clients;
      end getConnectedClients;

      ----------------------------------------------------------------------------------------

      function getUserDatabase return User_Database_Ptr is
      begin
	 return UserDatabase;
      end getUserDatabase;

      ----------------------------------------------------------------------------------------

      function getChatrooms return chatRoomMap.Map is
      begin
	 return chatRooms;
      end getChatrooms;

      ----------------------------------------------------------------------------------------

      function getContactRequests return userToUsersMap.Map is
      begin
	 return ContactRequests;
      end getContactRequests;

      ----------------------------------------------------------------------------------------

      procedure StartNewServer (ip : String; port : Natural) is
      begin
      -- # Erzeugte Serverintanz global setzen, damit sie im Package ueberall bekannt ist #
      -- # Datenbank laden #
	 UserDatabase.loadUserDatabase;
	 gui.printInfoMessage("User database loadad.");

	 --#Sockets aufbauen
	 InitializeServer (ip, port);
      end StartNewServer;

      ----------------------------------------------------------------------------------------

      procedure InitializeServer (ip : String; port : Natural) is
	 SubServer      : Concrete_Client_Ptr := new Concrete_Client;
	 subServerSocket : Socket_Type;
      begin
      -- # Erzeugung und Konfiguration des Server-Sockets #
      Initialize;
      Create_Socket (Socket => Socket);
      SocketAddress.Addr := Inet_Addr (ip);
      SocketAddress.Port := Port_Type (port);
      Bind_Socket (Socket => Socket, Address => SocketAddress);
      Listen_Socket (Socket => Socket);

         -- # Server starten #
         gui.printInfoMessage("Server initialization successful, starting Server Listener Task...");

          pragma Warnings(Off,"potentially blocking operation in protected operation");
         Main_Server_Task.Start;
          pragma Warnings(On ,"potentially blocking operation in protected operation");
      -- # Erzeugung des SubServer-Sockets #
	 Create_Socket (Socket => subServerSocket);
	 SubServer.setSocket(subServerSocket);

      -- # SubServer mit Server verbinden, Server wartet mit Accept - SubServer fragt mit Connect an #
      Connect_Socket (Socket => SubServer.getSocket, Server => Server.getSocketAddress);
      SubServer.sendServerMessageToClient(Connect,"password");

      exception
      when Error : Socket_Error =>
	 gui.printErrorMessage("Socket_Error in InitializeServer: " & Exception_Information (Error));
      when Error : others =>
	 gui.printErrorMessage("Unexpected exception in InitializeServer: " & Exception_Information (Error));
      end InitializeServer;

      ----------------------------------------------------------------------------------------

      procedure createChatRoom(firstClient : in     Concrete_Client_Ptr; room : out chatRoomPtr)
      is
	 id : Natural;
      begin
	 getNextChatRoomID(id);
	 room := new chatRoom;
	 room.setChatRoomID(id);
	 room.addClientToChatroom (client => firstClient);
	 chatRooms.Insert(room.getChatRoomID,room);
      end createChatRoom;

      ----------------------------------------------------------------------------------------

      procedure declineConnectionWithRefusedMessage (client : Concrete_Client_Ptr; messageContent : String) is
	 refusedMessage : MessageObject :=
	   createMessage (Protocol.Refused, To_Unbounded_String ("server"), client.getServerroomID, To_Unbounded_String (messageContent));
      begin
         writeMessageToStream (client.getSocket, refusedMessage);
      end declineConnectionWithRefusedMessage;

      ----------------------------------------------------------------------------------------

      procedure disconnectClient (client : in Concrete_Client_Ptr; msg : String) is
      serverStr         : Unbounded_String   := To_Unbounded_String ("server");
      begin
	 -- # Sende Disconnect-Bestaetigung
	 client.sendServerMessageToClient(Disconnect,msg);
	 removeClientRoutine(client);
      end disconnectClient;

      ----------------------------------------------------------------------------------------

      procedure removeClientRoutine(client : Concrete_Client_Ptr) is
	 chatRoomsOfClient : chatRoom_List.List := client.getChatroomList;
      begin
	 -- # Client verlässt alle Chaträume
	 for chatRoom of chatRoomsOfClient loop
	    chatRoom.removeClientFromChatroom (client);
	    gui.printInfoMessage("'"&To_String(client.getUsernameOfClient)&"' left the chatroom with ID '"&Natural'Image(chatRoom.getChatRoomID)&"'");
	 end loop;
	 -- # Sende Offline-Status an alle Kontakte vom Client #
	 broadcastOnlineStatusToContacts (client, Protocol.Offline);
	 -- # Schliesse Socket zu Client #
	 Close_Socket (client.getSocket);
	 -- # Setze User als offline #
	 Connected_Clients.Delete (client.getUser);
	 -- # Benachrichtige GUI über Änderung der Connected_Clients
	 gui.printInfoMessage("'"&To_String(client.getUsernameOfClient) & "' disconnected.");
	 gui.updateOnlineUserOverview(connectedClientsToClientList);
      end removeClientRoutine;

      ----------------------------------------------------------------------------------------

      procedure getNextChatRoomID (id : out Natural) is
      begin
	 id := chatRoomIDCounter;
	 chatRoomIDCounter := chatRoomIDCounter+1;
      end getNextChatRoomID;

      ----------------------------------------------------------------------------------------

     procedure broadcastOnlineStatusToContacts (client : in Concrete_Client_Ptr; status : MessageTypeE) is
	 serverStr           : Unbounded_String        := To_Unbounded_String ("server");
	 u : UserPtr := client.getUser;
	 contactList         : dataTypes.UserList.List := u.getContacts;
	 contactClient       : Concrete_Client_Ptr;
	 clientStatusMessage : MessageObject;
      begin
	 if status = Online or status = Offline then
	    for contact of contactList loop
	       if (Connected_Clients.Contains (contact)) then
		  -- # sende Kontakt den User Status
		  contactClient       := Connected_Clients.Element (contact);
		  clientStatusMessage := createMessage (status, serverStr, contactClient.getServerRoomID, client.getUsernameOfClient);
		  writeMessageToStream (contactClient.getSocket, clientStatusMessage);
	       end if;
	    end loop;
	 end if;
      end broadcastOnlineStatusToContacts;

      ----------------------------------------------------------------------------------------

      function checkIfContactRequestExists(requestingUser :    UserPtr;requestedUser  :    UserPtr) return Boolean is
	 ulist : dataTypes.UserList.List;
      begin
	 if (ContactRequests.Contains (requestingUser)) then
	    ulist := ContactRequests.Element (requestingUser);
	    return ulist.Contains (requestedUser);
	 end if;
	 return False;
      end checkIfContactRequestExists;

      ----------------------------------------------------------------------------------------

      procedure removeContactRequest (requestingUser : UserPtr; requestedUser : UserPtr) is
	 ulist : dataTypes.UserList.List;
	 pos   : dataTypes.UserList.Cursor;
      begin
	 if ContactRequests.Contains (requestingUser) then
	    ulist := ContactRequests.Element (requestingUser);
	    pos   := ulist.Find (requestedUser);
	    -- TODO: find kann fehlschalgen, noch pruefen
	    ulist.Delete (pos);
	    if ulist.Is_Empty then
	       ContactRequests.Delete (requestingUser);
	    end if;
	 end if;
      end removeContactRequest;

      ----------------------------------------------------------------------------------------

      function connectedClientsToClientList return userViewOnlineList.List is
	 clientMap : userToClientMap.Map := Connected_Clients;
	 clientList : userViewOnlineList.List;
      begin
         for client of clientMap loop
	    clientList.Append(New_Item => client);
	 end loop;
	 return clientList;
      end connectedClientsToClientList;

      ----------------------------------------------------------------------------------------

      procedure addContactRequest(requestingUser: UserPtr; requestedUser: UserPtr) is
	 ulist : dataTypes.UserList.List;
      begin
	   -- # gibt es UserKey von Requests in Map
	 if ContactRequests.Contains (Key => requestingUser) then
	    ulist := ContactRequests.Element (Key => requestingUser);
	    ulist.Append (New_Item => requestedUser);
	 else
	    -- # requestedUser zur Liste hinzufuegen
	    ulist.Append (New_Item => requestedUser);
	    -- # wenn nein, Key und Liste anlegen
	    ContactRequests.Insert (Key => requestingUser, New_Item => ulist);
	 end if;
      end addContactRequest;

      ----------------------------------------------------------------------------------------

      procedure addClientToConnectedClients(client : Concrete_Client_Ptr) is
      begin
	 Connected_Clients.Insert(Key      => client.getUser, New_Item => client);
      end addClientToConnectedClients;

      ----------------------------------------------------------------------------------------

      function getClientToConnectedUser ( user : UserPtr) return Concrete_Client_Ptr is
      begin
	 if Connected_Clients.Contains(user) then
	    return Connected_Clients.Element(user);
	 else
	    return null;
	 end if;
      end;

      ----------------------------------------------------------------------------------------

   end Concrete_Server;
   ----------------------------------------------------------------------------------------
   ----------------------------------------------------------------------------------------

end Concrete_Server_Logic;
