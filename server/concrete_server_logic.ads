with Protocol; use Protocol;
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;
with GNAT.String_Split; use GNAT.String_Split;
with Ada.Characters.Conversions;
with User_Databases; use User_Databases;
with dataTypes; use dataTypes;
with ada.containers.Indefinite_Hashed_Maps;
with Ada.Containers.Hashed_Maps;
with Ada.Strings.Unbounded.Hash;
with GUI_to_Server_Communication;
with Server_To_GUI_Communication; use Server_To_GUI_Communication;



-- # TODOs #
--       Sicherstellen dass man keine Fremden in Chat einladen kann nur Kontakte
--       prüfen ob Kontakt beim Add bereits in Kontaktliste
--       Sicherstellen, dass man keine Nutzer in den Chat mit dem Server eintragen kann
--       GetUser = null überall Abfragen
--       Kontaktrequest ablehnen funktioniert nicht
--       Generelle Kontrolle einführen, ob username richtig und ob gültiger Receiver


-- Dieses Paket spiegelt die serverseitige Funktionalitaet der Chatanwendung wieder.
package Concrete_Server_Logic is
   package GTS renames GUI_to_Server_Communication;

      function userHash (userToHash : UserPtr) return Hash_Type;
   package userToClientMap is new Ada.Containers.Hashed_Maps(Key_Type        => UserPtr,
							 Element_Type    => Concrete_Client_Ptr,
							 Hash            => userHash,
							 Equivalent_Keys => "=");


   function Hash (R : Natural) return Hash_Type;
   package chatRoomMap is new Ada.Containers.Hashed_Maps(Key_Type        => Natural,
						     Element_Type    => chatRoomPtr,
						     Hash            => Hash,
                                                         Equivalent_Keys => "=");

   package userToUsersMap is new Ada.Containers.Indefinite_Hashed_Maps(Key_Type        => UserPtr,
						     Element_Type    => dataTypes.UserList.List,
						     Hash            => userHash,
                                                     Equivalent_Keys => "=", "=" =>dataTypes.UserList."=");


   -- Typ einer Serverinstanz. Diese haelt als Attribute ihren Socket, IP-Adresse
   -- und Port, sowieso eine Verwaltungsliste von allen angemeldeten  Clients.

    -- type Concrete_Server is new Server_Interface with record
   protected type Concrete_Server is new GTS.Server with
	procedure getSocket( s : out Socket_Type);
      procedure getSocketAddress(sAddress: out Sock_Addr_Type);
      procedure getConnectedClients(connectedClients : out userToClientMap.Map);
      procedure getUserDatabase (dataBase : out User_Database);
      procedure getChatrooms(cRooms : out chatRoomMap.Map);
      procedure getContactRequests(cRequests : out userToUsersMap.Map);
   private

      Socket : Socket_Type;
      SocketAddress : Sock_Addr_Type;
      Connected_Clients : userToClientMap.Map;
      UserDatabase : User_Database;
      chatRoomIDCounter : Natural:= 1;
      chatRooms : chatRoomMap.Map;
      ContactRequests : userToUsersMap.Map;
   end Concrete_Server;
   type Concrete_Server_Ptr is access all Concrete_Server;



   -- Diese Prozedur leitet die Initialisierung des Servers ein und startet
   -- diesen anschliessend. Dies bedeutet insbesondere, dass von nun an auf
   -- einkommende Verbindungsanfragen gelauscht wird und fuer neue Clients
   -- separate Tasks zur Verfuegung gestellt werden, die es ihnen ermoeglichen
   -- untereinander zu kommunizieren.
   procedure StartNewServer (This : in out Concrete_Server; ip : String; port : Natural) ;
   function createChatRoom(server : in out Concrete_Server_Ptr; id : in Natural; firstClient : in Concrete_Client_Ptr) return chatRoomPtr ;
   procedure declineConnectionWithRefusedMessage (thisServer : Concrete_Server_Ptr; client : Concrete_Client_Ptr; messageContent : String);
   procedure disconnectClient (client : in Concrete_Client_Ptr; msg : String);
   procedure removeClientRoutine (thisServer : Concrete_Server_Ptr; client : Concrete_Client_Ptr);
   procedure broadcastOnlineStatusToContacts (thiServer : Concrete_Server_Ptr; status : MessageTypeE);



   type Client_Task is limited private;
   type Client_Task_Ptr is access Client_Task;



private

   -- Jede Instanz dieses Tasks ist pro Client fuer die eigentliche Kommunikation
   -- zwischen den Clients und die Interpretation der Nachrichten zustaendig.
   task type Client_Task is
      entry Start(newClient : Concrete_Client_Ptr);
   end Client_Task;

    -------------------------------------------------------------------------------------------
   -- # Implementierung ServerGUICommunication #
   procedure startServer(thisServer :  aliased in Concrete_Server; ipAdress: String; port : Natural);
   procedure stopServer(thisServer : aliased in  Concrete_Server);
   function loadDB(thisServer : aliased in Concrete_Server; DataFile : File_type) return Boolean;
   procedure saveDB(thisServer : aliased in Concrete_Server; DataFile : File_type);
   procedure sendMessageToUser(thisServer : aliased in Concrete_Server; username : String; messagestring : String);
   procedure deleteUserFromDatabase(thisServer : aliased in Concrete_Server; username : String);
   procedure kickUserWithName(thisServer : aliased in Concrete_Server; username:String);
   -------------------------------------------------------------------------------------------

   function checkIfContactRequestExists(server : in Concrete_Server_Ptr; requestingUser : UserPtr; requestedUser : UserPtr) return Boolean;

   procedure removeContactRequest (server : in out Concrete_Server_Ptr; requestingUser : UserPtr; requestedUser : UserPtr);

   -- gibt die nächste ID für den Chatraum
   function getNextChatRoomID( server: in out Concrete_Server_Ptr) return Natural;

   -- Diese Prozedur nimmt eine zuvor erzeuge Serverinstanz entgegen und erstellt
   -- fuer diese einen Server-Socket, welchem eine IP-Adresse und Portnr.
   -- zugewiesen wird.
   procedure InitializeServer(This : in out Concrete_Server_Ptr; ip : String; port :Natural);


   -- Dieser Task lauscht auf einkommende Verbindungen von neuen Clients und
   -- erstellt fuer diese jeweils einen eigenen Socket und Task, in dem anschliessend
   -- parallel auf Nachrichten jeglicher Art von diesen Clients gelauscht wird.
   -- Die eigentliche Verbindungsanfrage (connect) wird ebenfalls erst in den
   -- Client-Tasks vorgenommen. Hier wird lediglich ein Kanal zur Erstkommunikation
   -- aufgebaut und zur Verfuegung gestellt. Es gibt nur eine Instanz von diesem Task.
   task Main_Server_Task is
      entry Start;
      --entry Stop;
   end;

   function connectedClientsToClientList(this : in Concrete_Server_Ptr) return userViewOnlineList.List;




end Concrete_Server_Logic;
