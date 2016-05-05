with Ada.Strings.Unbounded;              use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists; use Ada.Containers;
with GNAT.SHA512;
with GNAT.Sockets;                       use GNAT.Sockets;
with Protocol;                           use Protocol;

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
   package UserList is new Doubly_Linked_Lists (Element_Type => UserPtr);

   protected type User is
      -- Gibt den Namen des Benutzers zurück
      function getUsername return Unbounded_String;
      -- Setzt den Namen des Benutzers
      procedure setUsername (name : in Unbounded_String);
      -- Gibt das Passwort eines Benutzer zurück
      function getPassword return Unbounded_String;
      -- Setzt das Passwort eines Benutzers
      procedure setPassword (pw : in Unbounded_String);
      -- Setzt die Kontaktliste eines Benutzers
      procedure setContacts (contactList : in UserList.List);
      -- Fügt einen einen Benutzer zur Kontaktliste eines anderen Benutzers hinzu
      procedure addContact (contactToAdd : UserPtr);
      -- Löscht einen Benutzer von der Kontaktliste eines anderen Benutzers
      procedure removeContact (contactToRemove : UserPtr);

      function getContacts return UserList.List;
   private
      username : Unbounded_String;
      password : Unbounded_String;
      contacts : UserList.List;
   end User;

   -- Verschlüsselt das Passwort eines Benutzers mit SHA512
   function encodePassword (password : in Unbounded_String) return Unbounded_String;

   type Concrete_Client;
   type Concrete_Client_Ptr is access Concrete_Client;

   package Client_List is new Doubly_Linked_Lists (Element_Type => Concrete_Client_Ptr);

   protected type chatRoom is
      procedure addClientToChatroom (client : in Concrete_Client_Ptr);
      procedure removeClientFromChatroom (clientToRemove : in Concrete_Client_Ptr);
      function getChatRoomID  return Natural;
      function generateUserlistMessage  return MessageObject;
      procedure broadcastToChatRoom (message : in MessageObject);
   private
      chatRoomID : Natural;
      clientList : Client_List.List;
   end chatRoom;
   type chatRoomPtr is access chatRoom;
   package chatRoom_List is new Doubly_Linked_Lists (Element_Type => chatRoomPtr);

   -- Typ einer Clientinstanz. Diese haelt als Attribute ihren Socket, IP-Adresse
   -- und Port, sowieso den Benutzernamen zu dem dieser Client gehoert und
   -- den Client-Task der ihm zugeordnet ist fest.
   protected type Concrete_Client is
      function getUsernameOfClient  return Unbounded_String;
      procedure sendServerMessageToClient (messageType : MessageTypeE; content : String);
      procedure sendServerMessageToClient (messageType : MessageTypeE; content : String; receiver: Natural);
      function getSocket return Socket_Type;
      private
      user          : UserPtr;
      Socket        : Socket_Type;
      SocketAddress : Sock_Addr_Type;
      chatRoomList  : chatRoom_List.List;
      ServerRoomID  : Natural := 0;
   end Concrete_Client;

   package userViewOnlineList is new Doubly_Linked_Lists (Element_Type => Concrete_Client_Ptr);



   --TODO
   --function getClientList (room : in chatRoomPtr) return Client_List.List;


   --TODO
   --function getChatroomsOfClient (client : in Concrete_Client_Ptr) return chatRoom_List.List;




private

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > Private Typen

   --------------------------------------------------------------------------------------------------------------------------------------------------------

end dataTypes;
