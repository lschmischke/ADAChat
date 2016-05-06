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
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with Ada.Containers.Hashed_Sets;
with Ada.Containers.Indefinite_Hashed_Maps;
with GNAT.String_Split; use GNAT.String_Split;
with Gui2Client_Communication; use Gui2Client_Communication;
with Client2Gui_Communication; use Client2Gui_Communication;

package Concrete_Client_Logic is

   type Concrete_Client is new Gui2Client_Communication.Client with private;

   type ConcretePtr is access all Concrete_Client'Class;

   function Hash (R : Natural) return Hash_Type;

  package ChatRoomIds is new Ada.Containers.Hashed_Sets(Element_Type        => Natural,
                                                        Hash                => Hash,
                                                        Equivalent_Elements => "=");

   package ChatRoomUsers is new Ada.Containers.Indefinite_Hashed_Maps(Key_Type        => Natural,
                                                                      Element_Type    => Client2Gui_Communication.Userlist.Set,
                                                                      Hash            => Hash,
                                                                      Equivalent_Keys => "=",
                                                                      "="             => Client2Gui_Communication.Userlist."=");

   Instance : ConcretePtr;

private

   type Concrete_Client is new Gui2Client_Communication.Client with record
      Socket : Socket_Type;
      ServerRoomId : Integer;
      UsersOnline : Client2Gui_Communication.Userlist.Set;
      UsersOffline : Client2Gui_Communication.Userlist.Set;
      ChatRoomIdSet : ChatRoomIds.Set;
      ChatRoomParticipants : ChatRoomUsers.Map;
      GUI : GUIPtr;
   end record;

   --#ServerID fuer register und connect
   ServerID : constant Integer := 0;

   -- Sendet dem Server ein Connect-MessageObject und verbindet den Client gemäß dem Chat-Protokoll mit dem Server.
   -- UserName => Name des Users
   -- Password => Passwort des Users
   procedure ConnectToServer(This : in out Concrete_Client; UserName : in Unbounded_String; Password : in Unbounded_String);

   -- Sendet dem Server ein Disconnect-MessageObject und meldet den Client gemäß des Chat-Protokolls beim Server ab.
   -- Username => Username des Clienten
   -- Msg => Abschiedsnachricht
   procedure DisconnectFromServer(This : in out Concrete_Client; UserName : in Unbounded_String;
                                  Msg : in Unbounded_String);

   -- Sendet dem Server ein Register-MessageObject und registriert den Client gemäß dem Chat-Protokoll.
   -- Username => Name des Users
   -- Password => Passwort des Users
   procedure RegisterAtServer(This : in out Concrete_Client; Username : in Unbounded_String; Password : in Unbounded_String);


   -- Sendet dem Server ein Chatrequest-MessageObject mit Chatanforderung an den geforderten User.
   -- Username => Name des Users
   -- Id_Receiver => ID des Server-Chatraums
   -- Participant => User an den Chatrequest gesendet werden soll
   procedure RequestChatroom(This : in out Concrete_Client; UserName : in Unbounded_String; Id_Receiver : in Integer;
                             Participant : in Unbounded_String);

   -- Sendet dem Server ein Leavechat-MessageObject von dem der Raum verlassen werden soll.
   -- UserName => Name des Users
   -- Id_Receiver => Id des zu verlassenden Raumes
   -- Message => Abschiedsnachricht
   procedure LeaveChatroom(This : in out Concrete_Client; UserName : in Unbounded_String; Id_Receiver : in Integer;
                           Message : in Unbounded_String);

   -- Sendet eine Nachricht an den angegebenen Chatraum.
   -- Usernamr => Name des Users
   -- Id_Receiver => Id des Chatraums
   -- Msg => Nachricht
   procedure SendTextMessage(This : in out Concrete_Client; Username : in Unbounded_String;
                             Id_Receiver : in Integer; Msg : in Unbounded_String);

   -- Sendet ein MessageOBject an die uebergebene Id.
   -- Username => Name des Users
   -- Id_Receiver => Id des Chatraums
   -- MsgObject => zu versendendes MessageObject
   procedure SendMessageObject(This : in out Concrete_Client; Username : in Unbounded_String;
                               Id_Receiver : in Integer; MsgObject : in MessageObject);

   -- Liest Messageobjects vom Server-Stream.
   -- ServerSocket => Socketstream von dem gelesen werden soll
   procedure ReadFromServer(This : in out Concrete_Client; ServerSocket : in Socket_Type);

   -- Verarbeitet MessageObjects und kommuniziert mit der GUI.
   -- MsgObject => MessageObject welches verarbeitet werden soll
   procedure ProcessMessageObject(This : in out Concrete_Client; MsgObject : in MessageObject);

   -- Aktualisiert die Userlist.
   -- User => User dessen Status aktualisiert werden soll
   procedure RefreshUserlist(This : in out Concrete_Client; User : in Unbounded_String);

   -- Durchsucht die Kontaktliste nach einem User.
   -- User => User nach dem gesucht werden soll
   -- return => true, wenn User gefunden bzw. false wenn nicht
   function searchFriendList(This : in out Concrete_Client; User : in Unbounded_String) return Boolean;

   -----------------------------------------------------------------------------
   -----------Implementierung des Gui2Client_Communication interfaces-----------
   -----------------------------------------------------------------------------

   procedure InitializeGUI(This : in out Concrete_Client; Ptr : in GUIPtr);

   procedure InitializeSocket(This : in out Concrete_Client; ServerAdress : in Unbounded_String;
                              ServerPort : in Port_Type);

   procedure LoginUser (This : in out Concrete_Client; Username : in Unbounded_String; Password : in Unbounded_String);

   procedure DisconnectUser(This : in out Concrete_Client; Username : in Unbounded_String; Message : in Unbounded_String);

   procedure RegisterUser(This : in out Concrete_Client; Username : in Unbounded_String; Password : in Unbounded_String);

   procedure InviteToGroupChat(This : in out Concrete_Client; Username : in Unbounded_String; Receiver : in Integer;
                               Participant : in Unbounded_String);

   procedure SendMessageToChat(This : in out Concrete_Client; Receiver: in Integer; Username : in Unbounded_String;
                               Message : in Unbounded_String);

   procedure RequestChat(This : in out Concrete_Client; Username : in Unbounded_String;
                               Participant : in Unbounded_String);
   -----------------------------------------------------------------------------

   task Server_Listener_Task is
      entry Start;
   end Server_Listener_Task;

end Concrete_Client_Logic;
