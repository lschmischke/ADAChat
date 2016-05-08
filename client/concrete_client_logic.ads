--Spezifikation der Client-Logic

--Includes
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.IO_Exceptions;
with Ada.Exceptions; use Ada.Exceptions;
with Protocol; use Protocol;
with Datatypes; use Datatypes;
with Ada.Containers; use Ada.Containers;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Containers.Hashed_Sets;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with Ada.Containers.Indefinite_Doubly_Linked_Lists;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Containers.Hashed_Maps;
with GNAT.String_Split; use GNAT.String_Split;
with Gui2Client_Communication; use Gui2Client_Communication;
with Client2Gui_Communication; use Client2Gui_Communication;

package Concrete_Client_Logic is

   type Concrete_Client is new Gui2Client_Communication.Client with private;

   type ConcretePtr is access all Concrete_Client'Class;

   function hash (R : Natural) return Hash_Type;

   --package ChatRoomIds is new Ada.Containers.Doubly_Linked_Lists(Element_Type        => Natural);
   package ChatRoomIds is new Ada.Containers.Hashed_Sets(Element_Type        => Natural,
                                                         Hash                => Hash,
                                                         Equivalent_Elements => "=");

   --package ChatRoomUsers is new Ada.Containers.Indefinite_Doubly_Linked_Lists(Element_Type    => Client2Gui_Communication.Userlist.List,
   --                                                                           "="             => Client2Gui_Communication.Userlist."=");

   package ChatRoomUsers is new Ada.Containers.Indefinite_Hashed_Maps(Key_Type        => Natural,
                                                                      Element_Type    => Client2Gui_Communication.Userlist.Set,
                                                                      Hash            => Hash,
                                                                      Equivalent_Keys => "=",
                                                                      "="             => Client2Gui_Communication.Userlist."=");

   instance : ConcretePtr;

private

   type Concrete_Client is new Gui2Client_Communication.Client with record
      socket : Socket_Type;
      serverRoomId : Integer;
      usersOnline : Client2Gui_Communication.Userlist.Set;
      usersOffline : Client2Gui_Communication.Userlist.Set;
      chatRoomIdSet : ChatRoomIds.Set;
      chatRoomParticipants : ChatRoomUsers.Map;
      gui : GUIPtr;
   end record;

   --#ServerID fuer register und connect
   serverID : constant Integer := 0;

   -- Sendet dem Server ein Connect-MessageObject und verbindet den Client gemäß dem Chat-Protokoll mit dem Server.
   -- UserName => Name des Users
   -- Password => Passwort des Users
   procedure connectToServer(this : in out Concrete_Client; userName : in Unbounded_String; password : in Unbounded_String);

   -- Sendet dem Server ein Disconnect-MessageObject und meldet den Client gemäß des Chat-Protokolls beim Server ab.
   -- Username => Username des Clienten
   -- Msg => Abschiedsnachricht
   procedure disconnectFromServer(this : in out Concrete_Client; userName : in Unbounded_String;
                                  msg : in Unbounded_String);

   -- Sendet dem Server ein Register-MessageObject und registriert den Client gemäß dem Chat-Protokoll.
   -- Username => Name des Users
   -- Password => Passwort des Users
   procedure registerAtServer(this : in out Concrete_Client; username : in Unbounded_String; password : in Unbounded_String);


   -- Sendet dem Server ein Chatrequest-MessageObject mit Chatanforderung an den geforderten User.
   -- Username => Name des Users
   -- Id_Receiver => ID des Server-Chatraums
   -- Participant => User an den Chatrequest gesendet werden soll
   procedure requestChatroom(this : in out Concrete_Client; userName : in Unbounded_String; id_Receiver : in Integer;
                             participant : in Unbounded_String);

   -- Sendet dem Server ein Leavechat-MessageObject von dem der Raum verlassen werden soll.
   -- UserName => Name des Users
   -- Id_Receiver => Id des zu verlassenden Raumes
   -- Message => Abschiedsnachricht
   procedure leaveChatroom(this : in out Concrete_Client; userName : in Unbounded_String; id_Receiver : in Integer;
                           message : in Unbounded_String);

   -- Sendet eine Nachricht an den angegebenen Chatraum.
   -- Usernamr => Name des Users
   -- Id_Receiver => Id des Chatraums
   -- Msg => Nachricht
   procedure sendTextMessage(this : in out Concrete_Client; username : in Unbounded_String;
                             id_Receiver : in Integer; msg : in Unbounded_String);

   -- Sendet ein MessageOBject an die uebergebene Id.
   -- Username => Name des Users
   -- Id_Receiver => Id des Chatraums
   -- MsgObject => zu versendendes MessageObject
   procedure sendMessageObject(this : in out Concrete_Client; username : in Unbounded_String;
                               id_Receiver : in Integer; msgObject : in MessageObject);

   -- Liest Messageobjects vom Server-Stream.
   -- ServerSocket => Socketstream von dem gelesen werden soll
   procedure readFromServer(this : in out Concrete_Client; serverSocket : in Socket_Type);

   -- Verarbeitet MessageObjects und kommuniziert mit der GUI.
   -- MsgObject => MessageObject welches verarbeitet werden soll
   procedure processMessageObject(this : in out Concrete_Client; msgObject : in MessageObject);

   -----------------------------------------------------------------------------
   -----------Implementierung des Gui2Client_Communication interfaces-----------
   -----------------------------------------------------------------------------

   procedure initializeGUI(this : in out Concrete_Client; Ptr : in GUIPtr);

   procedure initializeSocket(this : in out Concrete_Client; ServerAdress : in Unbounded_String;
                              ServerPort : in Port_Type);

   procedure loginUser (this : in out Concrete_Client; username : in Unbounded_String; password : in Unbounded_String);

   procedure disconnectUser(this : in out Concrete_Client; username : in Unbounded_String; message : in Unbounded_String);

   procedure registerUser(this : in out Concrete_Client; username : in Unbounded_String; password : in Unbounded_String);

   procedure inviteToGroupChat(this : in out Concrete_Client; username : in Unbounded_String; receiver : in Integer;
                               participant : in Unbounded_String);

   procedure sendMessageToChat(this : in out Concrete_Client; receiver: in Integer; username : in Unbounded_String;
                               message : in Unbounded_String);

   procedure requestChat(this : in out Concrete_Client; username : in Unbounded_String;
                               participant : in Unbounded_String);
   -----------------------------------------------------------------------------

   task Server_Listener_Task is
      entry Start;
   end Server_Listener_Task;

end Concrete_Client_Logic;
