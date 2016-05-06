package body dataTypes is

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   protected body User is
      function getUsername return Unbounded_String is
      begin
         return username;
      end getUsername;

      --------------------------------------------------------------------------------------------------------------------------------------------------------

      procedure setUsername (name : in Unbounded_String) is
      begin
         username := name;
      end setUsername;

      --------------------------------------------------------------------------------------------------------------------------------------------------------

      function getPassword return Unbounded_String is
      begin
         return password;
      end getPassword;

      --------------------------------------------------------------------------------------------------------------------------------------------------------

      procedure setPassword (pw : in Unbounded_String) is
      begin
         password := pw;
      end setPassword;

      --------------------------------------------------------------------------------------------------------------------------------------------------------

      procedure setContacts (contactList : in UserList.List) is
      begin
         contacts := contactList;
      end setContacts;

      --------------------------------------------------------------------------------------------------------------------------------------------------------

      procedure addContact (contactToAdd : UserPtr) is
      begin

         if not contacts.Contains (contactToAdd) then
            contacts.Append (New_Item => contactToAdd);
         end if;
      end addContact;

      --------------------------------------------------------------------------------------------------------------------------------------------------------

      procedure removeContact (contactToRemove : UserPtr) is
         pos : UserList.Cursor := contacts.Find (Item => contactToRemove);
      begin
         if contacts.Contains (contactToRemove) then
            contacts.Delete (Position => pos);
         end if;
      end removeContact;

      function getContacts return UserList.List is
      begin
	 return contacts;
      end getContacts;
   end User;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   protected body Concrete_Client is

       procedure setSocket (s : Socket_Type) is
      begin
	 socket := s;
      end setSocket;

      procedure setSocketAddress (sa : Sock_Addr_Type) is
      begin
	 SocketAddress := sa;
      end setSocketAddress;

      procedure setServerRoomID (id : Natural) is
      begin
	 ServerRoomID := id;
      end setServerRoomID;

      procedure setUser (u : UserPtr) is
      begin
	 user := u;
      end setUser;

      procedure addChatroom (room : chatRoomPtr) is
      begin
	 chatRoomList.Append(room);
      end addChatroom;

      function getUsernameOfClient return Unbounded_String is
      begin
         return user.getUsername;
      end getUsernameOfClient;
      --------------------------------------------------------------------------------------------------------------------------------------------------------

      function getServerroomID return Natural is
      begin
	 return ServerRoomID;
      end getServerroomID;

      function getChatroomList return chatroom_list.List is
      begin
	 return chatRoomList;
      end  getChatroomList;

      function getUser return UserPtr is
      begin
	 return user;
      end getUser;
      function getSocketAddress return Sock_Addr_Type is
      begin
	 return SocketAddress;
      end getSocketAddress;

      ----------------------------------------------------------------------------------------
      procedure sendServerMessageToClient (messageType : MessageTypeE; content : String) is
      begin
         sendServerMessageToClient (messageType, content, ServerRoomID);
      end sendServerMessageToClient;
      --------------------------------------------------------------------------------------------------------------------------------------------------------

      procedure sendServerMessageToClient (messageType : MessageTypeE; content : String; receiver : Natural) is
         message : MessageObject :=
           createMessage (messageType, To_Unbounded_String ("server"), receiver, To_Unbounded_String (content));
      begin
         printMessageToInfoConsole (message);
         writeMessageToStream (Socket, message);
      end sendServerMessageToClient;
      --------------------------------------------------------------------------------------------------------------------------------------------------------

      function getSocket return Socket_Type is
      begin
         return Socket;
      end getSocket;
      --------------------------------------------------------------------------------------------------------------------------------------------------------

   end Concrete_Client;

   protected body chatRoom is

      function getClientList return Client_List.List is
      begin
	 return clientList;
      end getClientList;

      procedure addClientToChatroom (client : in Concrete_Client_Ptr) is
      begin
         clientList.Append (client);
      end addClientToChatroom;
      --------------------------------------------------------------------------------------------------------------------------------------------------------

      procedure removeClientFromChatroom (clientToRemove : in Concrete_Client_Ptr) is
         pos                              : Client_List.Cursor := clientList.Find (Item => clientToRemove);
         userlistMessage, userleftMessage : MessageObject;
         userleftText                     : Unbounded_String   := clientToRemove.getUsernameOfClient;
      begin
         if clientList.Contains (clientToRemove) then
            clientList.Delete (Position => pos);

            if (clientList.Length >= 1) then
               -- # broadcaste die neue Userlist und teile dem Chat mit, dass der Benutzer diesen verlassen hat
               userlistMessage := generateUserlistMessage;
               broadcastToChatRoom (userlistMessage);
               Ada.Strings.Unbounded.Append (userleftText, To_Unbounded_String (" left the chat."));
               userleftMessage :=
                 createMessage
                   (messagetype => Protocol.Chat,
                    sender      => To_Unbounded_String ("server"),
                    receiver    => getChatRoomID,
                    content     => userleftText);
               broadcastToChatRoom (userleftMessage);
            else
               -- # TODO: lösche den chatraum
               null;
            end if;
         end if;
      end removeClientFromChatroom;
      --------------------------------------------------------------------------------------------------------------------------------------------------------

      function getChatRoomID return Natural is
      begin
         return chatRoomID;
      end getChatRoomID;
      --------------------------------------------------------------------------------------------------------------------------------------------------------

      function generateUserlistMessage return MessageObject is
         result  : Unbounded_String;
         clients : Client_List.List := clientList;
         message : MessageObject;
      begin
         for client of clients loop
            Append (result, To_Unbounded_String (Protocol.Seperator));
            Append (result, client.getUsernameOfClient);
         end loop;
         Ada.Strings.Unbounded.Delete (result, 1, 1);
         message :=
           createMessage
             (messagetype => Protocol.Userlist,
              sender      => To_Unbounded_String ("server"),
              receiver    => getChatRoomID,
              content     => result);
         return message;
      end generateUserlistMessage;
      --------------------------------------------------------------------------------------------------------------------------------------------------------

      procedure broadcastToChatRoom (message : in MessageObject) is
      begin
         for client of clientList loop
            writeMessageToStream (client.getSocket, message);
         end loop;
      end broadcastToChatRoom;
      --------------------------------------------------------------------------------------------------------------------------------------------------------
      procedure setChatRoomID( id : in Natural) is
      begin
	 chatRoomID := id;
      end setChatRoomID;
   end chatRoom;

   function encodePassword (password : in Unbounded_String) return Unbounded_String is
   begin
      return To_Unbounded_String (GNAT.SHA512.Digest (To_String (password)));
   end encodePassword;

      function userHash (userToHash : UserPtr) return Hash_Type is
   begin
      return Ada.Strings.Unbounded.Hash (userToHash.getUsername);
   end userHash;


   function Hash (R : Natural) return Hash_Type is
   begin
      return Hash_Type (R);
   end Hash;

end dataTypes;
