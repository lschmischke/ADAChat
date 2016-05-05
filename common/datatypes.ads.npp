with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;
with GNAT.SHA512;
with GNAT.Sockets; use GNAT.Sockets;
with Protocol; use Protocol;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dieses Paket bündelt Typen um Benutzer des Chats abzuspeichern.
--
-- Autoren: Daniel Kreck, Leonard Schmischke
-- Letzte Änderung: 29.04.2016
-----------------------------------------------------------------------------------------------------------------------------------------------------------
package dataTypes is

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > Öffentliche Typen

   -- In diesem Datentyp wird ein Benutzer abgelegt. Er enthält seinen Namen, Passwort und seine Kontaktliste
   type User;
   type UserPtr is access User;
   package UserList is new Doubly_Linked_Lists(Element_Type => UserPtr);


   protected type User is
   -- Gibt den Namen des Benutzers zurück
      function getUsername return Unbounded_String;
         -- Setzt den Namen des Benutzers
      procedure setUsername(name : in Unbounded_String);
         -- Gibt das Passwort eines Benutzer zurück
      function getPassword return Unbounded_String;
         -- Setzt das Passwort eines Benutzers
      procedure setPassword(pw : in Unbounded_String);
      -- Setzt die Kontaktliste eines Benutzers
      procedure setContacts (contactList : in UserList.List);
      -- Fügt einen einen Benutzer zur Kontaktliste eines anderen Benutzers hinzu
   procedure addContact (contactToAdd : UserPtr);
   -- Löscht einen Benutzer von der Kontaktliste eines anderen Benutzers
   procedure removeContact (contactToRemove : UserPtr);
      private
      username : Unbounded_String;
      password : Unbounded_String;
      contacts : UserList.List;
   end User;




   -- Verschlüsselt das Passwort eines Benutzers mit SHA512
   function encodePassword(password : in Unbounded_String) return Unbounded_String;


   type Concrete_Client;
   type Concrete_Client_Ptr is access Concrete_Client;

   package Client_List is new Doubly_Linked_Lists(Element_Type => Concrete_Client_Ptr);

   type chatRoom is tagged
      record
	 chatRoomID : Natural;
	 clientList : Client_List.List;
      end record;
   type chatRoomPtr is access chatRoom;
   package chatRoom_List is new Doubly_Linked_Lists(Element_Type => chatRoomPtr);

      -- Typ einer Clientinstanz. Diese haelt als Attribute ihren Socket, IP-Adresse
   -- und Port, sowieso den Benutzernamen zu dem dieser Client gehoert und
   -- den Client-Task der ihm zugeordnet ist fest.
   type Concrete_Client is tagged record
      user : UserPtr;
      Socket : Socket_Type;
      SocketAddress : Sock_Addr_Type;
      chatRoomList : chatRoom_List.List;
      ServerRoomID : Natural := 0;
   end record;

   package userViewOnlineList is new Doubly_Linked_Lists(Element_Type => Concrete_Client_Ptr );



   procedure addClientToChatroom(room : in out ChatRoomPtr; client : in Concrete_Client_Ptr);
   procedure removeClientFromChatroom(room : in out chatRoomPtr; clientToRemove : in Concrete_Client_Ptr);
   function getChatRoomID(room : in chatRoomPtr) return Natural;
   function generateUserlistMessage(room : in chatRoomPtr) return MessageObject;
   function getClientList(room : in chatRoomPtr) return Client_List.List;
   procedure broadcastToChatRoom(room : in chatRoomPtr; message : in MessageObject);










   function getUsernameOfClient(client : Concrete_Client_Ptr) return Unbounded_String;
   function getChatroomsOfClient(client : in Concrete_Client_Ptr) return chatRoom_List.List;
   procedure broadcastOnlineStatusToContacts(client : in Concrete_Client_Ptr; status : MessageTypeE);
   procedure disconnectClient(client : in Concrete_Client_Ptr; msg : String);
   procedure declineConnectionWithRefusedMessage(client : Concrete_Client_Ptr; messageContent : String);
   procedure sendServerMessageToClient(client : Concrete_Client_Ptr; messageType : MessageTypeE; content : String);
   procedure sendServerMessageToClient(client : Concrete_Client_Ptr; messageType : MessageTypeE; content : String; receiver : Natural);
   procedure removeClientRoutine(client : Concrete_Client_Ptr);

private

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > Private Typen


   --------------------------------------------------------------------------------------------------------------------------------------------------------

end dataTypes;
