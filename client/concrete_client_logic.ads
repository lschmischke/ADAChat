with Client_Logic; use Client_Logic;
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.IO_Exceptions;
with Protocol; use Protocol;


package Concrete_Client_Logic is

   type Concrete_Client is new Client_Interface with record
      Socket : Socket_Type;
   end record;


   --Stellt eine Socketverbindung zum Server her und meldet den Client
   --nach Chat-Protokoll am Server an.
   procedure ConnectToServer(This : in out Concrete_Client; UserName : in Unbounded_String; Password : in Unbounded_String;
                             ServerAdress : in Unbounded_String;
                             ServerPort : in Port_Type);

   --Diese Prozedur meldet den Client beim Server nach Chat-Protokoll ab und schliesst dessen Socket.
   procedure DisconnectFromServer(This : in out Concrete_Client; UserName : in Unbounded_String;
                                  Id_Receiver : in Integer; Msg : in Unbounded_String);

   --Diese Prozedur sendet eine Nachricht an den ueber Id_Receiver angegebenen Chatraum.
   procedure SendMessage(This : in out Concrete_Client; Username : in Unbounded_String;
                         Id_Receiver : in Integer; Msg : in Unbounded_String);

   --Diese Prozedur liest Messageobjects vom Server-Stream und verarbeitet diese.
   procedure ReadFromServer(This : in out Concrete_Client; ServerSocket : in Socket_Type);

   --Diese Prozedur verarbeitet MessageObjects entsprechend ihres Types.
   procedure ProcessMessageObject(This : in out Concrete_Client; MsgObject : in MessageObject);

end Concrete_Client_Logic;
