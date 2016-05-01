with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;
with GNAT.SHA512;
with GNAT.Sockets; use GNAT.Sockets;

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
   type User is tagged private;
   type UserPtr is access User;

   package UserList is new Doubly_Linked_Lists(Element_Type => UserPtr);

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > Funktionen zum Typ UserPtr

   -- Gibt den Namen des Benutzers zurück
   function getUsername(this : in UserPtr) return Unbounded_String;

   -- Setzt den Namen des Benutzers
   procedure setUsername(this : in out UserPtr; name : in Unbounded_String);

   -- Verschlüsselt das Passwort eines Benutzers mit SHA512
   function encodePassword(password : in Unbounded_String) return Unbounded_String;

   -- Gibt das Passwort eines Benutzer zurück
   function getPassword(this : in UserPtr) return Unbounded_String;

   -- Setzt das Passwort eines Benutzers
   function setPassword(this : in out UserPtr; password : in Unbounded_String) return Boolean;

   -- Gibt die Kontaktliste eines Benutzers zurück
   function getContacts (this : in UserPtr) return UserList.List;

   -- Setzt die Kontaktliste eines Benutzers
   procedure setContacts (this : in out UserPtr; contacts : in UserList.List);

   -- Fügt einen einen Benutzer zur Kontaktliste eines anderen Benutzers hinzu
   function addContact (this : in out UserPtr; contactToAdd : UserPtr) return Boolean;

   -- Löscht einen Benutzer von der Kontaktliste eines anderen Benutzers
   function removeContact (this : in out UserPtr; contactToRemove : UserPtr) return boolean;

   --------------------------------------------------------------------------------------------------------------------------------------------------------





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

private

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > Private Typen

   type User is tagged
      record
         username : Unbounded_String;
         password : Unbounded_String;
         contacts : UserList.List;
      end record;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

end dataTypes;
