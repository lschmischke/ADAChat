with Ada.Strings.Unbounded;              use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists; use Ada.Containers;
with GNAT.SHA512;
with GNAT.Sockets;                       use GNAT.Sockets;
with Protocol;                           use Protocol;
with ada.containers.Hashed_Maps;
with ada.containers.Indefinite_Hashed_Maps;
with ada.strings.Unbounded.Hash;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dieses Paket b�ndelt Typen um Benutzer des Chats abzuspeichern.
--
-- Autoren: Daniel Kreck, Leonard Schmischke
-- Letzte �nderung: 29.04.2016
-----------------------------------------------------------------------------------------------------------------------------------------------------------
package dataTypes is

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > �ffentliche Typen

   -- In diesem Datentyp wird ein Benutzer abgelegt. Er enth�lt seinen Namen, Passwort und seine Kontaktliste
   type User;
   type UserPtr is access User;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   package UserList is new Doubly_Linked_Lists (Element_Type => UserPtr);

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   protected type User is
      -- Gibt den Namen des Benutzers zur�ck
      function getUsername return Unbounded_String;
      -- Setzt den Namen des Benutzers
      procedure setUsername (name : in Unbounded_String);
      -- Gibt das Passwort eines Benutzer zur�ck
      function getPassword return Unbounded_String;
      -- Setzt das Passwort eines Benutzers
      procedure setPassword (pw : in Unbounded_String);
      -- Setzt die Kontaktliste eines Benutzers
      procedure setContacts (contactList : in UserList.List);
      -- F�gt einen einen Benutzer zur Kontaktliste eines anderen Benutzers hinzu
      procedure addContact (contactToAdd : UserPtr);
      -- L�scht einen Benutzer von der Kontaktliste eines anderen Benutzers
      procedure removeContact (contactToRemove : UserPtr);
      -- Gibt eine Kopie der Kontaktliste des Users zur�ck
      function getContacts return UserList.List;
   private
      username : Unbounded_String;
      password : Unbounded_String;
      contacts : UserList.List;
   end User;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   type Concrete_Client;
   type Concrete_Client_Ptr is access Concrete_Client;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   package Client_List is new Doubly_Linked_Lists (Element_Type => Concrete_Client_Ptr);

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- Typ eines Chatraums. Dieser besetitz eine einzigartige ID und eine Liste mit allen Clients, die sich in diesem Chatraum befinden
   protected type chatRoom is
      -- F�gt einen Clienten zu dem Chatraum hinzu
      procedure addClientToChatroom (client : in Concrete_Client_Ptr);
      -- Entfernt einen Clienten aus dem Chatraum
      procedure removeClientFromChatroom (clientToRemove : in Concrete_Client_Ptr);
      -- Entfernt einen Clienten aus dem Chatraum. An die restlichen Teilnehmern in dem Chat wird die Abschiedsnachricht gesendet
      -- farewell => Abschiedsnachricht
      procedure removeClientFromChatroom (clientToRemove : in Concrete_Client_Ptr; farewell : String);
      -- Gibt die ID des Chatraums zur�ck
      function getChatRoomID  return Natural;
      -- Gibt eine Kopie der Liste aller Clienten in dem Chatraum zur�ck
      function getClientList return Client_List.List;
      -- Erstellt eine "userlist"-Nachricht, die die Namen aller Clienten im Chatraum enth�llt
      function generateUserlistMessage  return MessageObject;
      -- Schickt message an alle Clienten im Chatraum
      procedure broadcastToChatRoom (message : in MessageObject);
      -- Setzt die ID des Chatraums
      procedure setChatRoomID( id : in Natural);
   private
      chatRoomID : Natural;
      clientList : Client_List.List;
   end chatRoom;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Referenztyp auf einen Chatraum
   type chatRoomPtr is access chatRoom;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   package chatRoom_List is new Doubly_Linked_Lists (Element_Type => chatRoomPtr);

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Typ einer Clientinstanz. Diese haelt als Attribute ihren Socket, IP-Adresse
   -- und Port, sowieso den Benutzernamen zu dem dieser Client gehoert und
   -- den Client-Task der ihm zugeordnet ist fest.
   protected type Concrete_Client is
      -- Gibt den Benutzernamen des Benutzers, mit dem der Client eingeloggt ist, zur�ck
      function getUsernameOfClient  return Unbounded_String;
      -- sendet eine Nachricht vom Server an den Client �ber die ServerroomID des Clients
      procedure sendServerMessageToClient (messageType : MessageTypeE; content : String);
      -- sendet eine Nachricht vom Server an den Client mit der angegebenen Empf�nger-Nummer
      procedure sendServerMessageToClient (messageType : MessageTypeE; content : String; receiver: Natural);
      -- F�gt einen Chatraum in die Chatraum-Liste des Clients hinzu
      procedure addChatroom (room : chatRoomPtr);
      -- Gibt eine Kopie des Sockets des Clients zur�ck
      function getSocket return Socket_Type;
      -- Gibt die ServeroomID des Clients zur�ck
      function getServerroomID return Natural;
      -- Gibt eine Kopie der Liste der Chatr�ume zur�ck, in die sich der Client befindet
      function getChatroomList return chatroom_list.List;
      -- Gibt eine Referenz auf den User zur�ck, mit dem der Client eingeloggt ist
      function getUser return UserPtr;
      -- Gibt eine Kopie der Socketadresse des Clients zur�ck
      function getSocketAddress return Sock_Addr_Type;
      -- Setzt den Socket des Clients auf den �bergebenen Socket
      procedure setSocket (s : Socket_Type);
      -- Setzt die Socketadresse des Clients auf die �bergebene Socketadresse
      procedure setSocketAddress (sa : Sock_Addr_Type);
      -- Setzt die ServeroomID des Clients auf den �bergebenen Wert
      procedure setServerRoomID (id : Natural);
      -- Setzt den User, mit dem der Client eingeloggt ist
      procedure setUser (u : UserPtr);
   private
      user          : UserPtr;
      Socket        : Socket_Type;
      SocketAddress : Sock_Addr_Type;
      chatRoomList  : chatRoom_List.List;
      ServerRoomID  : Natural := 0;
   end Concrete_Client;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Verschl�sselt �bergebenen String - z.B. das Passwort eines Benutzers - mit SHA512
   function encodePassword (password : in Unbounded_String) return Unbounded_String;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   package userViewOnlineList is new Doubly_Linked_Lists (Element_Type => Concrete_Client_Ptr);

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   function userHash (userToHash : UserPtr) return Hash_Type;
   package userToClientMap is new Ada.Containers.Hashed_Maps(Key_Type        => UserPtr,
							 Element_Type    => Concrete_Client_Ptr,
							 Hash            => userHash,
							     Equivalent_Keys => "=");

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------


   function Hash (R : Natural) return Hash_Type;
   package chatRoomMap is new Ada.Containers.Hashed_Maps(Key_Type        => Natural,
						     Element_Type    => chatRoomPtr,
						     Hash            => Hash,
							 Equivalent_Keys => "=");

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   package userToUsersMap is new Ada.Containers.Indefinite_Hashed_Maps(Key_Type        => UserPtr,
						     Element_Type    => dataTypes.UserList.List,
						     Hash            => userHash,
								       Equivalent_Keys => "=", "=" =>dataTypes.UserList."=");

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------


end dataTypes;
