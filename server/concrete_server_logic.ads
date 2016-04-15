with Server_Logic; use Server_Logic;
with Protocol; use Protocol;
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;
with GNAT.String_Split; use GNAT.String_Split;
with Ada.Characters.Conversions;

-- Dieses Paket spiegelt die serverseitige Funktionalitaet der Chatanwendung wieder.
package Concrete_Server_Logic is

   -- Typ einer Serverinstanz. Diese haelt als Attribute ihren Socket, IP-Adresse
   -- und Port, sowieso eine Verwaltungsliste von allen angemeldeten  Clients.
   type Concrete_Server is private;
   type Concrete_Server_Ptr is access Concrete_Server;

   -- Diese Prozedur leitet die Initialisierung des Servers ein und startet
   -- diesen anschliessend. Dies bedeutet insbesondere, dass von nun an auf
   -- einkommende Verbindungsanfragen gelauscht wird und fuer neue Clients
   -- separate Tasks zur Verfuegung gestellt werden, die es ihnen ermoeglichen
   -- untereinander zu kommunizieren.
   procedure StartServer(This : in out Concrete_Server_Ptr);

private

   -- Jede Instanz dieses Tasks ist pro Client fuer die eigentliche Kommunikation
   -- zwischen den Clients und die Interpretation der Nachrichten zustaendig.
   task type Client_Task is
      entry Start(Socket : Socket_Type; SocketAddress : Sock_Addr_Type);
   end;
   type Client_Task_Ptr is access Client_Task;

   -- Typ einer Clientinstanz. Diese haelt als Attribute ihren Socket, IP-Adresse
   -- und Port, sowieso den Benutzernamen zu dem dieser Client gehoert und
   -- den Client-Task der ihm zugeordnet ist fest.
   type Concrete_Client is record
      Username : Unbounded_String;
      Socket : Socket_Type;
      SocketAddress : Sock_Addr_Type;
      CommunicationTask : Client_Task_Ptr;
   end record;
   type Concrete_Client_Ptr is access Concrete_Client;

   package Client_List is new Doubly_Linked_Lists(Element_Type => Concrete_Client_Ptr);

   -- type Concrete_Server is new Server_Interface with record
   type Concrete_Server is record
     Socket : Socket_Type;
     SocketAddress : Sock_Addr_Type;
     Connected_Clients : Client_List.List;
   end record;

   -- Diese Prozedur nimmt eine zuvor erzeuge Serverinstanz entgegen und erstellt
   -- fuer diese einen Server-Socket, welchem eine IP-Adresse und Portnr.
   -- zugewiesen wird.
   procedure InitializeServer(This : in out Concrete_Server_Ptr);

   procedure dummy3(This : in out Concrete_Server_Ptr);

   -- Dieser Task lauscht auf einkommende Verbindungen von neuen Clients und
   -- erstellt fuer diese jeweils einen eigenen Socket und Task, in dem anschliessend
   -- parallel auf Nachrichten jeglicher Art von diesen Clients gelauscht wird.
   -- Die eigentliche Verbindungsanfrage (connect) wird ebenfalls erst in den
   -- Client-Tasks vorgenommen. Hier wird lediglich ein Kanal zur Erstkommunikation
   -- aufgebaut und zur Verfuegung gestellt. Es gibt nur eine Instanz von diesem Task.
   task Main_Server_Task is
      entry Start;
      -- entry Stop;
   end;
end Concrete_Server_Logic;
