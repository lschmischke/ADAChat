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
                                  Msg : in Unbounded_String);

   --Diese Prozedur registriert den Client mit entsprechenden Parametern beim Server.
   procedure RegisterAtServer(This : in out Concrete_Client; UserName : in Unbounded_String; Password : in Unbounded_String);

   -----------------------------------------------------------------------------

   --Forder beim Server einen Chatroom an.
   procedure RequestChatroom(This : in out Concrete_Client; UserName : in Unbounded_String; Id_Receiver : in Integer;
                             Participant : in Unbounded_String);

   --Verlaesst einen Chatroom.
   procedure LeaveChatroom(This : in out Concrete_Client; UserName : in Unbounded_String; Id_Receiver : in Integer;
                           Message : in Unbounded_String);

   -----------------------------------------------------------------------------

   --Diese Prozedur sendet eine Nachricht an den ueber Id_Receiver angegebenen Chatraum.
   procedure SendTextMessage(This : in out Concrete_Client; Username : in Unbounded_String;
                         Id_Receiver : in Integer; Msg : in Unbounded_String);

   --Diese Funktion liest Messageobjects vom Server-Stream.
   function ReadFromServer(This : in out Concrete_Client; ServerSocket : in Socket_Type) return Unbounded_String;



   --Diese Funktion verarbeitet MessageObjects.
   function ProcessMessageObject(This : in out Concrete_Client; MsgObject : in MessageObject) return Unbounded_String;

   -----------------------------------------------------------------------------

   procedure RefreshUserlist(This : in out Concrete_Client; User : in Unbounded_String);

end Concrete_Client_Logic;
