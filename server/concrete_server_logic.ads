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

-- Dieses Paket spiegelt die serverseitige Funktionalitaet der Chatanwendung wieder.
package Concrete_Server_Logic is
   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   package GTS renames GUI_to_Server_Communication;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Typ einer Serverinstanz. Diese haelt als Attribute ihren Socket, IP-Adresse
   -- und Port, sowieso eine Verwaltungsliste von allen angemeldeten  Clients und ein Übersicht über alle Chaträume.
   protected type Concrete_Server is new GTS.Server with
      -- Gibt den Socket des Servers zurück
      function getSocket return Socket_Type;
      -- Gibt die SocketAdresse des Servers zurück
      function getSocketAddress return Sock_Addr_Type;
      -- Gibt eine Kopie der Liste verbundener Clients zurück
      function getConnectedClients return userToClientMap.Map;
      -- Gibt eine Referenz auf die User-Datenbank zurück. Sie enthält alle bereits registrierten Benutzer und deren Informationen.
      function getUserDatabase return User_Database_Ptr;
      -- Gibt eine Kopie der Chatraum-Map zurück. Diese bildet die ID des Chatraums auf die Referenz des Chatraums ab.
      function getChatrooms return chatRoomMap.Map;
      -- Gibt eine Kopie der Kontaktanfragen Map zurück. Diese enthält alle Kontaktfragen, gemappt auf den jeweiligen User, der die Anfrage gestellt hat
      function getContactRequests return userToUsersMap.Map;
      -- Startet den Server auf der übergebenen IP mit dem übergebenem Port
      procedure StartNewServer (ip : String; port : Natural) ;
      -- Diese Prozedur leitet die Initialisierung des Servers ein und startet
      -- diesen anschliessend. Dies bedeutet insbesondere, dass von nun an auf
      -- einkommende Verbindungsanfragen gelauscht wird und fuer neue Clients
      -- separate Tasks zur Verfuegung gestellt werden, die es ihnen ermoeglichen
      -- untereinander zu kommunizieren.
      procedure InitializeServer (ip : String; port : Natural);
      -- Erstellt einen neuen Chatraum, mit der übergebenen ID und fügt automatisch den übergebenen Client zu dem Chatraum hinzu.
      -- firstClient => Client, der direkt hinzugefügt wird
      -- room => Referenz auf den Chatraum, die rausgegeben wird
      procedure createChatRoom(firstClient : in Concrete_Client_Ptr; room : out chatRoomPtr);
      -- Lehnt eine Verbindungsanfrage von dem übergebenen Client ab. Der Inhalt der Nachricht kann angegeben werden.
      -- client => Client, dessen Verbindungsanfrage abgelehnt wird
      -- messageContent => Inhalt, der "refused"-Nachricht, die dem Client geschickt wird, sollte den Grund der Ablehnung beinhalten
      procedure declineConnectionWithRefusedMessage (client : Concrete_Client_Ptr; messageContent : String);
      -- Unterbricht eine bestehende Verbindung mit dem Client.
      -- Dieser wird aus allen Chaträumen entfernt, anschließend wird die Verbindung getrennt und die Kontakte benachrichtigt.
      -- Dann wird der Socket geschlossen.
      -- cliet => Client, der enfernt werden soll
      procedure removeClientRoutine (client : Concrete_Client_Ptr);
      -- Ruft "removeClientRoutine" mit client auf und sendet zusätzlich eine "disconnect"-Nachricht an den Client.
      -- client => Client, der disconnected werden soll
      -- msg => Inhalt der "disconnect"-Nachricht, die an den Client geschickt wird
      procedure disconnectClient (client : in Concrete_Client_Ptr; msg : String);
      -- Benachrichtigt die Kontakte des Clients über seine Statusänderung (nach Online- oder Online-kommen)
      -- client => Client, dessen Kontakte benachrichtigt werden
      -- status => Messagetyp der Nachricht, muss Online oder Offline sein, sonst wird der Aufruf der Funktion ignoriert
      procedure broadcastOnlineStatusToContacts (client : Concrete_Client_Ptr; status : MessageTypeE);
      -- Überprüft, ob eine Kontaktanfrage von dem requesting User zu dem requested User existiert. Achtung: Kontaktanfragen existieren nur
      -- während der Laufzeit des Servers, in der die Anfrage gestellt wird. Mit dem Stoppen des Servers gehen die Anfragen verloren
      -- return => true, wenn die Kontaktanfrage existiert, sonst false
      function checkIfContactRequestExists(requestingUser : UserPtr; requestedUser : UserPtr) return Boolean;
      -- Entfernt eine Kontaktanfrage aus der Liste des Servers
      -- requestingUser => User, der die Anfrage gestellt hat
      -- requestedUser => User, dem die Anfrage gestellt wurde
      procedure removeContactRequest (requestingUser : UserPtr; requestedUser : UserPtr);
      -- Fügt eine Kontaktanfrage zur Liste des Servers hinzu
      -- requestingUser => User, der die Anfrage stellt
      -- requestedUser => User, dem die Anfrage gestellt wird
      procedure addContactRequest(requestingUser: UserPtr; requestedUser: UserPtr);
      -- Gibt eine Liste aller verbundenen User zurück
      function connectedClientsToClientList return userViewOnlineList.List;
      -- Gibt die nächste verfügbare Nummer für einen neuen Chatraum zurück
      -- id => ID, die bisher ungenutzt ist, und einem neuen Chatraum zugewiesen werden kann
      procedure getNextChatRoomID (id : out Natural);
      -- Fügt den client zu der Liste verbundener Clients hinzu
      procedure addClientToConnectedClients(client : Concrete_Client_Ptr);
      -- Gibt den Client zu einem eingeloggten User zurück
      function getClientToConnectedUser ( user : UserPtr) return Concrete_Client_Ptr;
      -- Entfernt den angegebenen Chatraum aus der Chatraum-Liste des Servers
      procedure removeChatRoom (chatRoom : chatRoomPtr);
      -- Entfernt alle Chaträume aus der Chatraum-Liste des Server
      procedure removeAllChatRooms;
      -- Entfernt einen Client aus dem angegebenen Chatraum, sofern beide Teil des Servers sind
      procedure removeClientFromChatroom (client : Concrete_Client_Ptr; chatRoom : chatRoomPtr);
      -- Entfernt einen Client aus dem angegebenen Chatraum, sofern beide Teil des Servers sind.
      -- An die restlichen Teilnehmern in dem Chat wird die Abschiedsnachricht gesendet.
      -- farewell => Abschiedsnachricht
      procedure removeClientFromChatroom (client : Concrete_Client_Ptr; chatRoom : chatRoomPtr; farewell : String);
   private
      Socket : Socket_Type;
      SocketAddress : Sock_Addr_Type;
      Connected_Clients : userToClientMap.Map;
      UserDatabase : User_Database_Ptr := new User_Database;
      chatRoomIDCounter : Natural:= 1;
      chatRooms : chatRoomMap.Map;
      ContactRequests : userToUsersMap.Map;
   end Concrete_Server;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Referenz auf eine Serverinstanz
   type Concrete_Server_Ptr is access all Concrete_Server;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   type Client_Task is limited private;
   type Client_Task_Ptr is access Client_Task;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

private

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Jede Instanz dieses Tasks ist pro Client fuer die eigentliche Kommunikation
   -- zwischen den Clients und die Interpretation der Nachrichten zustaendig.
   task type Client_Task is
      entry Start(newClient : Concrete_Client_Ptr);
   end Client_Task;


   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -------------------------------------------------# Implementierung ServerGUICommunication #-------------------------------------------------------------

   procedure startServer(thisServer :  aliased in out  Concrete_Server; ipAdress: String; port : Natural);
   procedure stopServer(thisServer : aliased in out Concrete_Server);
   function loadDB(thisServer : aliased in out Concrete_Server; DataFile : File_type) return Boolean;
   procedure saveDB(thisServer : aliased in out Concrete_Server; DataFile : File_type);
   procedure sendMessageToUser(thisServer : aliased in out Concrete_Server; username : String; messagestring : String);
   procedure deleteUserFromDatabase(thisServer : aliased in out Concrete_Server; username : String);
   procedure kickUserWithName(thisServer : aliased in out Concrete_Server; username:String);

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Dieser Task lauscht auf einkommende Verbindungen von neuen Clients und
   -- erstellt fuer diese jeweils einen eigenen Socket und Task, in dem anschliessend
   -- parallel auf Nachrichten jeglicher Art von diesen Clients gelauscht wird.
   -- Die eigentliche Verbindungsanfrage (connect) wird ebenfalls erst in den
   -- Client-Tasks vorgenommen. Hier wird lediglich ein Kanal zur Erstkommunikation
   -- aufgebaut und zur Verfuegung gestellt. Es gibt nur eine Instanz von diesem Task.
   task type Main_Server_Task is
      entry Start;
   end;

   type Main_Server_Task_Ptr is access Main_Server_Task;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------
end Concrete_Server_Logic;
