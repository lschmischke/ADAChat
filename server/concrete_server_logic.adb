with Concrete_Server_Gui_Logic; use Concrete_Server_Gui_Logic;

package body Concrete_Server_Logic is

   Server     : Concrete_Server_Ptr;
   concServer : aliased Concrete_Server;
   gui : GUIPtr := new Concrete_Server_Gui_Logic.Server_Gui;


-----------------------------------------------------------------------------

   procedure StartNewServer (This : in out Concrete_Server; ip : String; port : Natural) is
   begin
      -- # Erzeugte Serverintanz global setzen, damit sie im Package ueberall bekannt ist #
      concServer := This;
      Server     := concServer'Access;
      Server.
      -- # Datenbank laden #
      User_Databases.loadUserDatabase (Server.UserDatabase);
      gui.printInfoMessage("User database loadad.");

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
      gui.printInfoMessage("Server initialization successful, starting Server Listener Task...");
      Main_Server_Task.Start;

      -- # Erzeugung des SubServer-Sockets #
      Create_Socket (Socket => SubServer.Socket);

      -- # SubServer mit Server verbinden, Server wartet mit Accept - SubServer fragt mit Connect an #
      Connect_Socket (Socket => SubServer.Socket, Server => Server.SocketAddress);
      sendServerMessageToClient(SubServer,Connect,"password");

   exception
      when Error : Socket_Error =>
	 gui.printErrorMessage("Socket_Error in InitializeServer: " & Exception_Information (Error));
      when Error : others =>
	 gui.printErrorMessage("Unexpected exception in InitializeServer: " & Exception_Information (Error));
   end InitializeServer;

-----------------------------------------------------------------------------

   task body Main_Server_Task is
   begin
      accept Start;

      -- # Abhoerroutine auf Aktivitaet am Server-Socket #
      loop
         declare
	    Client : Concrete_Client_Ptr := new Concrete_Client;
	    cTask : Client_Task_Ptr:= new Client_Task;
         begin
            -- # Auf Verbindungsanfrage warten, annehmen, Client-Socket erzeugen und neue Adresse an diesen binden #
            gui.printInfoMessage("Ready to accept incoming Connections...");
            Accept_Socket
              (Server  => Server.Socket,
               Socket  => Client.Socket,
               Address => Client.SocketAddress); -- Blockierender Aufruf
            gui.printInfoMessage("Incoming Connection from " & GNAT.Sockets.Image (Client.SocketAddress) & " accepted");

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
      accept Start (newClient : Concrete_Client_Ptr) do
         client := newClient;
      end Start; -- Jetzt laeuft dieser erst nebenlaeufig weiter! #

      gui.printInfoMessage("New Client Task for " & GNAT.Sockets.Image (client.SocketAddress) & " successfully started");

      -- InputChannel := Stream(ClientSocket);

      gui.printInfoMessage("Waiting for incoming data from " & GNAT.Sockets.Image (client.SocketAddress) & " ...");

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


               -----------------------------------------------------------------

               case incoming_message.messagetype is
                  -- ### CONNECT ###
                  when Protocol.Connect => -- # connect:client:0:<passwort> #
		     declare

			userpassword : Unbounded_String;
			msgContent : Unbounded_String;
                     begin
                        -- # Pruefe ob Benutzer registriert und Passwort richtig #
                        user := Server.UserDatabase.getUser (username => incoming_message.sender);

			if user = null then
			   declineConnectionWithRefusedMessage(client,"user '"& To_String(incoming_message.sender)& "' not found in database");
                        elsif client.user /= null then
			   --# Prüefe ob Client schon mit einem User verbunden ist
			   declineConnectionWithRefusedMessage(client,"you are already logged in to an account");
                        elsif Server.Connected_Clients.Contains (user) then
			   -- # Prüfe ob User, für den sich angemeldet wurde, schon angemeldet ist
			   declineConnectionWithRefusedMessage(client,"user '"& To_String(incoming_message.sender)& "' already logged in");
                        else
                           userpassword := getPassword (user);
                           -- TODO: das Passwort sollte vom Client bereits verschluesselt verschickt werden!!
			   if userpassword /= encodePassword (incoming_message.content) then
			      declineConnectionWithRefusedMessage(client,"invalid password");
                           else
                              -- # CONNECT ERFOLGREICH
                              --# hole serverroomid zu diesem client vom server
                              declare
                                 id                   : Natural       := getNextChatRoomID (Server);
                                 chatroom             : chatRoomPtr;
                                 clientContacts      : dataTypes.UserList.List := getContacts (user);
                              begin
                                 -- # Weise Client eine ServerRoomID zu und init Client #
                                 serverRoomID        := id;
				 client.ServerRoomID := serverRoomID;
				 client.user := user;
                                 chatroom            := createChatRoom (Server, serverRoomID, client);
				 sendServerMessageToClient(client,Connect,"ok");

                                 -- # Client in Verwaltungsliste speichern #
                                 Server.Connected_Clients.Insert (Key => user, New_Item => client);

                                 -- # Füge server zu Chatraumliste des Clients hinzu
				 client.chatRoomList.Append (chatroom);

                                 -- # teile GUI mit, dass user online gekommen ist
                                 gui.updateNumberOfContacts(Integer(server.Connected_Clients.Length));
				 gui.updateOnlineUserOverview(connectedClientsToClientList(this => server));
				 gui.printInfoMessage("'"&To_String(getUsername(user)) & "' has come online.");

                                 -- # Sende online-Benachrichtigungen
                                 for contact of clientContacts loop
                                    declare
                                       contactClient : Concrete_Client_Ptr;
                                    begin
                                       -- # Pruefe ob Kontakt online
				       if (Server.Connected_Clients.Contains (contact)) then
					  contactClient := server.Connected_Clients.Element(contact);
                                          -- # sende Kontakt, dass User online ist
					  sendServerMessageToClient(contactClient,Online,To_String(getUsername(user)));
                                          -- # sende User, dass Kontakt online ist
					  sendServerMessageToClient(client,Online,To_String(getUsername (contact)));
                                       else
                                          -- # sende User, dass Kontakt offline ist
					  sendServerMessageToClient(client,Offline,To_String(getUsername (contact)));
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
                     begin
                        -- # Pruefe, ob Chatraum mit angegebener Nummer existiert
                        if (Server.chatRooms.Contains (incoming_message.receiver)) then
                           chatRoom := Server.chatRooms.Element (incoming_message.receiver);

                           -- # Pruefe, ob Client in ChatRoom eingeschrieben #
			   if (getClientList (chatRoom).Contains (client)) then
			      --# echo Nachricht an alle Clienten im Raum
                              broadcastToChatRoom (chatRoom, incoming_message);
                              gui.printChatMessage(incoming_message);
                           else
			      sendServerMessageToClient(client,Refused,"you are not in the chatroom with id " & Integer'Image (incoming_message.receiver)&".");
                           end if;
                        else
			   sendServerMessageToClient(client,Refused,"there is no chatroom with id " & Integer'Image (incoming_message.receiver)&".");
                        end if;
                     end;

                  -- ### DISCONNECT ###
                  when Protocol.Disconnect => -- # disconnect:client:<ServerRoomID>:<?> #
                     begin
			disconnectClient (client,"ok");
                        -- # TODO: Task beenden
                        exit;
                     end;

                  -- ### CHATREQUEST ###
                  when Protocol.Chatrequest => -- # chatrequest:clientA:<ServerRoomID>:clientB #
                     declare
                        roomID               : Natural             := getNextChatRoomID (Server);
                        requestingUser       : UserPtr             := getUser (Server.UserDatabase, incoming_message.sender);
                        userToAdd            : UserPtr             := getUser (Server.UserDatabase, incoming_message.content);
                        clientToAdd          : Concrete_Client_Ptr := Server.Connected_Clients.Element (userToAdd);
			chatRoom : chatRoomPtr;
		     begin
			--# TODO: getUser Fehler abfangen
			--# Pruefe, ob Kontakt zu angegebenem User besteht
                        if (getContacts (user).Contains (userToAdd)) then
			   --# Pruefe, ob Chat mit dieser Nummer bereits existiert
			   if not Server.chatRooms.Contains (incoming_message.receiver) then
			      sendServerMessageToClient(client,Refused,"invalid roomID in chatrequest, please use your serverRoomID for new chatrequests and the specific chatroomID for invites");
			      gui.printErrorMessage("Chatroomrequest from '"&To_String(getUsername(user) &"' denied: invalid roomID (does not exist)."));
                           elsif incoming_message.receiver = serverRoomID then
			      --# neuen Raum anlegen
                              chatRoom := createChatRoom (server => Server, id => roomID, firstClient => client);
			      addClientToChatroom (room => chatRoom, client => clientToAdd);

			      -- # Füge Chatroom in Liste beider Clients hinzu
                              client.chatRoomList.Append (chatRoom);
			      clientToAdd.chatRoomList.Append (chatRoom);
			      sendServerMessageToClient(client,Chatrequest,"ok",roomID);

			      -- # Benachrichtige GUI
			      gui.printInfoMessage("Chatroomrequest from '"&To_String(getUsername(user))& "' accepted: created chatroom '"&Natural'Image(chatroom.chatRoomID) & "' with user '"&To_String(getUsername(userToAdd)));
                           else
			      --# alter Raum, User einladen
                              chatRoom := Server.chatRooms.Element (incoming_message.receiver);
                              addClientToChatroom (room => chatRoom, client => clientToAdd);
			      clientToAdd.chatRoomList.Append (chatRoom);

			      --# userlist rumschicken
			      broadcastToChatRoom (chatRoom, generateUserlistMessage (chatRoom));

			      -- # Benachrichtige GUI
			       gui.printInfoMessage("Chatroomrequest from '"&To_String(getUsername(user))& "' accepted: invited '"&To_String(getUsername(userToAdd))&"' to chatroom '"&Natural'Image(chatroom.chatRoomID));
                           end if;
                        else
                           -- # Es existiert kein Kontakt mit dem angegebenem Namen
			   sendServerMessageToClient(client,Refused,"You have no contact with name " & To_String (incoming_message.content)&".");
			   gui.printErrorMessage("Chatroomrequest from '"&To_String(getUsername(user) &"' denied: not contact with '"& To_string(getUsername(userToAdd)&"'.")));
                        end if;

                     end;

                  -- ### LEAVECHAT ###
                  when Protocol.Leavechat => -- # leavechat:client:<ChatRoomID>:<?> #
                     declare
                        chatRoom       : chatRoomPtr;
                     begin
                        --# Pruefe, ob referenziertet Raum existiert
                        if Server.chatRooms.Contains (incoming_message.receiver) then
                           chatRoom := Server.chatRooms.Element (incoming_message.receiver);
                           --# Pruefe ob Client in referenziertem Chatraum
                           if (client.chatRoomList.Contains (chatRoom)) then
			      removeClientFromChatroom (chatRoom, client);
                           else
			      sendServerMessageToClient(client,Refused,"you are not in the chatroom with id " & Integer'Image (incoming_message.receiver)&".");
                           end if;
                        else
			   sendServerMessageToClient(client,Refused,"there is no chatroom with id" & Integer'Image (incoming_message.receiver)&".");
                        end if;
                     end;

                  -- ### REGISTER ###
                  when Protocol.Register => -- # register:<username>:0:<passwort>
                     declare
                        registrationComplete : Boolean;
                     begin
                        registrationComplete :=
                          Server.UserDatabase.registerUser
                          (username => incoming_message.sender, password => encodePassword (incoming_message.content));
			if registrationComplete = True then
			   sendServerMessageToClient(client,Register,"ok");
			   gui.printInfoMessage("New user '"&To_String(incoming_message.sender)&"' registrated");
			else
			   sendServerMessageToClient(client,Refused,"registration failed, name in use");
                        end if;
                     end;

                  -- ### ADDCONTACT ###
                  when Protocol.addContact =>
                     declare
                        requestedUser           : UserPtr             := getUser (Server.UserDatabase, incoming_message.content);
                        requestedUserClient     : Concrete_Client_Ptr := Server.Connected_Clients.Element (requestedUser);
                        bool                    : Boolean;
                     --requestingUser ist user
                     begin
			-- TODO: pruefe ob es die beiden User gibt

			-- # Pruefe, ob eine Kontaktanfrage beantortet wird
                        if (checkIfContactRequestExists (Server, requestedUser, user)) then
                           -- # stelle Kontakt her
                           -- # Kontaktanfrage aus Liste rausnehmen
                           removeContactRequest (Server, requestedUser, user);

                           -- # User_Datenbank aktualisieren
                           -- # TODO return Wert abfragen
                           bool := addContact (this => user, contactToAdd => requestedUser);
                           bool := addContact (requestedUser, user);
                           saveUserDatabase (Server.UserDatabase);

                           --  # User benachrichten
			   sendServerMessageToClient(requestedUserClient,Chat,"New Contact added: " & To_String (getUsername (user)));
			   sendServerMessageToClient(client,Chat,"New Contact added: " & To_String (getUsername (requestedUser)));

                           -- # Kontakte über online Status benachrichtigen
			   sendServerMessageToClient(client,Online,To_String(getUsername(requestedUser)));
			   sendServerMessageToClient(requestedUserClient,Online,To_String(getUsername(user)));

			   -- # GUI informieren
			   gui.printInfoMessage("'"&To_string(getUsername(user))&"' accepted contact request from '"&To_String(getUsername(user))&"'.");
			   gui.printInfoMessage("'"&To_String(getUsername(user))&"' and '"&To_String(getUsername(requestedUser))&"' are now contacts.");
                        else
                           declare
                              ulist : dataTypes.UserList.List;
                           begin
                              -- # trage Kontaktanfrage in serverliste ein
                              -- # gibt es UserKey von Requests in Map
                              if Server.ContactRequests.Contains (Key => user) then
                                 ulist := Server.ContactRequests.Element (Key => user);
                                 ulist.Append (New_Item => requestedUser);
                              else
                                 -- # requestedUser zur Liste hinzufuegen
                                 ulist.Append (New_Item => requestedUser);
                                 -- # wenn nein, Key und Liste anlegen
                                 Server.ContactRequests.Insert (Key => user, New_Item => ulist);
                              end if;
                              -- # Benachrichtige requested user über Kontaktanfrage
			      sendServerMessageToClient(requestedUserClient,addContact,To_String(getUsername(user)));

			      -- # Benachrichtige GUI
			      gui.printInfoMessage("'"&To_String(getUsername(user))&"' sent contact request to '"&To_String(getUsername(requestedUser))&"'.");
                           end;
                        end if;
                     end;

                  -- ### REMCONTACT ###
                  when Protocol.remContact =>
                     declare
                        requestedUser           : UserPtr := getUser (Server.UserDatabase, incoming_message.content);
                        requestedUserClient     : Concrete_Client_Ptr     := Server.Connected_Clients.Element (requestedUser);
                        userContacts            : dataTypes.UserList.List := getContacts (user);
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
			   sendServerMessageToClient(client,remContact,To_String(incoming_message.content));
			   sendServerMessageToClient(requestedUserClient,remContact,To_String(getUsername (user)));

			   -- # Benachrichtige GUI
			   gui.printInfoMessage("'"&To_String(getUsername(user)&"' and '" &To_String(getUsername(requestedUser)&"' are no longer contacts")));

                        -- # Kontaktanfrage ablehnen über RemContact
                        elsif checkIfContactRequestExists (Server, requestedUser, user) then
                           removeContactRequest (server => Server, requestingUser => requestedUser, requestedUser => user);
                           -- # User muss benachrichtigt werden, dass seine Kontaktanfrage abgelehnt wurde
			   sendServerMessageToClient(requestedUserClient,remContact,To_String(getUsername (user)));
			   -- # GUI benachrichtigen
			   gui.printInfoMessage("'"&To_String(getUsername(user))&"' has declined the contact request from '"&To_String(getUsername(requestedUser))&"'.");
                        else
                           -- # wenn keine Kontaktanfrage zu diesem Kontakt vorhanden
			   sendServerMessageToClient(client,Refused,"There is no contact request from " & To_String (incoming_message.content));
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
         removeClientRoutine(client);
      when Error : others =>
         Put ("Unexpected exception in Client_Task: ");
         Put_Line (Exception_Information (Error));
         disconnectClient (client,"unspecified error");
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
	    gui.printInfoMessage("'"&To_String(getUsernameOfClient(clientToRemove))&"' left the chatroom with ID '"&Natural'Image(room.chatRoomID)&"'");
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

   procedure disconnectClient (client : in Concrete_Client_Ptr; msg : String) is
      serverStr         : Unbounded_String   := To_Unbounded_String ("server");
   begin

      Put_Line("disconnect nachricht");
      -- # Sende Disconnect-Bestaetigung
      sendServerMessageToClient(client,Disconnect,msg);
      removeClientRoutine(client);
   end disconnectClient;

   ----------------------------------------------------------------------------------------
   procedure removeClientRoutine(client : Concrete_Client_Ptr) is
      chatRoomsOfClient : chatRoom_List.List := getChatroomsOfClient (client);
   begin
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
      -- # Benachrichtige GUI über Änderung der Connected_Clients
      gui.printInfoMessage("'"&To_String(getUsername(client.user)) & "' disconnected.");
      gui.updateOnlineUserOverview(connectedClientsToClientList(server));
      gui.updateNumberOfContacts(Integer(server.Connected_Clients.Length));
   end removeClientRoutine;

   ----------------------------------------------------------------------------------------

   overriding
   procedure startServer (thisServer : aliased in Concrete_Server; ipAdress : String; port : Natural) is
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
      disconnectClient (client,"kicked");
   end kickUserWithName;

   ----------------------------------------------------------------------------------------

   procedure stopServer (thisServer : aliased in Concrete_Server) is
   begin
      for client of Server.Connected_Clients loop
	 disconnectClient(client,"server shut down");
      end loop;

      Close_Socket(server.Socket);
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


   procedure sendMessageToUser(thisServer : aliased in Concrete_Server; username : String; messagestring : String) is
      user : UserPtr := thisServer.UserDatabase.getUser(To_Unbounded_String(username));
      client : Concrete_Client_Ptr := thisServer.Connected_Clients.Element(user);
      msg : MessageObject := createMessage(messagetype => Protocol.Chat,
                                           sender      => To_Unbounded_String("server"),
                                           receiver    => client.ServerRoomID,
                                           content     => To_Unbounded_String(messagestring));
   begin
      writeMessageToStream(ClientSocket => client.Socket,
                           message      => msg);
      null;
   end sendMessageToUser;

   ----------------------------------------------------------------------------------------

   procedure deleteUserFromDatabase(thisServer : aliased in Concrete_Server; username : String) is
   begin
      -- TODO
      null;
   end deleteUserFromDatabase;

   ----------------------------------------------------------------------------------------

   function connectedClientsToClientList(this : in Concrete_Server_Ptr) return userViewOnlineList.List is
      clientMap : userToClientMap.Map := this.Connected_Clients;
      clientList : userViewOnlineList.List;
   begin
      for user of clientMap loop
         clientList.Append(New_Item => user);
      end loop;

      return clientList;
   end connectedClientsToClientList;

   ----------------------------------------------------------------------------------------

   function getUsernameOfClient(client : Concrete_Client_Ptr) return Unbounded_String
   is
   begin
      return getUsername(client.user);
   end getUsernameOfClient;

   ----------------------------------------------------------------------------------------

   procedure declineConnectionWithRefusedMessage(client : Concrete_Client_Ptr; messageContent : String)is
      refusedMessage : MessageObject := createMessage(Protocol.Refused,To_Unbounded_String("server"),client.ServerRoomID,To_Unbounded_String(messageContent));
   begin
      writeMessageToStream(client.Socket,refusedMessage);
      gui.printErrorMessage("Connection request from " & Gnat.Sockets.Image(client.SocketAddress.Addr) & " declined: " & messageContent);
   end declineConnectionWithRefusedMessage;

   ----------------------------------------------------------------------------------------
   procedure sendServerMessageToClient(client : Concrete_Client_Ptr; messageType : MessageTypeE; content : String)is
      begin
      sendServerMessageToClient(client,messageType,content,client.ServerRoomID);

   end sendServerMessageToClient;
   ----------------------------------------------------------------------------------------

   procedure sendServerMessageToClient(client : Concrete_Client_Ptr; messageType : MessageTypeE; content : String; receiver : Natural) is
      message : MessageObject := createMessage(messageType,To_Unbounded_String("server"),receiver,To_Unbounded_String(content));
   begin
      Put_Line("OUT:");
      printMessageToInfoConsole(message);
      writeMessageToStream(client.Socket,message);
   end sendServerMessageToClient;

   ----------------------------------------------------------------------------------------
   -- SERVER GETTER --

   protected body Concrete_Server is
      procedure getSocket(s : out Socket_Type) is
      begin
	 s := Socket;
      end getSocket;
      procedure getSocketAddress(sAddress: out Sock_Addr_Type) is
      begin
	 sAddress := SocketAddress;
      end getSocketAddress;

      procedure getConnectedClients(connectedClients : out userToClientMap.Map) is
      begin
	 connectedClients := Connected_Clients;
      end getConnectedClients;

      procedure getUserDatabase (dataBase : out User_Database) is
      begin
	 dataBase := UserDatabase;
      end getUserDatabase;

      procedure getChatrooms(cRooms : out chatRoomMap.Map) is
      begin
	 cRooms := chatRooms;
      end getChatrooms;

      procedure getContactRequests(cRequests : out userToUsersMap.Map) is
      begin
	 cRequests := ContactRequests;
      end getContactRequests;
   end Concrete_Server;




end Concrete_Server_Logic;
