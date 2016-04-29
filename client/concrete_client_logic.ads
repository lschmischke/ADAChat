with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.IO_Exceptions;
with Ada.Exceptions; use Ada.Exceptions;
with Protocol; use Protocol;
with Datatypes; use Datatypes;
with Ada.Containers; use Ada.Containers;
with Ada.Containers.Hashed_Sets;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with Ada.Containers.Indefinite_Hashed_Maps;
with GNAT.String_Split; use GNAT.String_Split;
with Gui2Client_Communication; use Gui2Client_Communication;
with Client2Gui_Communication; use Client2Gui_Communication;

limited with Concrete_Client_Ui;

package Concrete_Client_Logic is

   type Concrete_Client_Ui_Ptr is access all Concrete_Client_Ui.Concrete_Ui;

   type Concrete_Client is new Gui2Client_Communication.Client with private;

   package Userlist is new Ada.Containers.Hashed_Sets(Element_Type        => Unbounded_String,
                                                      Hash                => Ada.Strings.Unbounded.Hash_Case_Insensitive,
                                                      Equivalent_Elements => "=",
                                                      "="                 => Ada.Strings.Unbounded."=");

   function Hash (R : Natural) return Hash_Type;

   package ChatRoomIds is new Ada.Containers.Hashed_Sets(Element_Type        => Natural,
                                                         Hash                => Hash,
                                                         Equivalent_Elements => "=");

   package ChatRoomUsers is new Ada.Containers.Indefinite_Hashed_Maps(Key_Type        => Natural,
                                                                      Element_Type    => Userlist.Set,
                                                                      Hash            => Hash,
                                                                      Equivalent_Keys => "=",
                                                                      "="             => Userlist."=");

   procedure RegisterGUI(This : Concrete_Client; GUI : access Concrete_Client_Ui_Ptr);


   private

   type Concrete_Client is new Gui2Client_Communication.Client with record
      Socket : Socket_Type;
      ServerRoomId : Integer;
      UsersOnline : Userlist.Set;
      UsersOffline : Userlist.Set;
      ChatRoomIdSet : ChatRoomIds.Set;
      ChatRoomParticipants : ChatRoomUsers.Map;
      GUI : Concrete_Client_Ui_Ptr;

   end record;

   --#ServerID fuer register und connect
   ServerID : constant Integer := 0;

   --Stellt eine Socketverbindung zum Server her und meldet den Client
   --nach Chat-Protokoll am Server an.
   procedure ConnectToServer(This : in out Concrete_Client; UserName : in Unbounded_String; Password : in Unbounded_String);

   --Diese Prozedur meldet den Client beim Server nach Chat-Protokoll ab und schliesst dessen Socket.
   procedure DisconnectFromServer(This : in out Concrete_Client; UserName : in Unbounded_String;
                                  Msg : in Unbounded_String);

   --Diese Prozedur registriert den Client mit entsprechenden Parametern beim Server.
   procedure RegisterAtServer(This : in out Concrete_Client; UserName : in Unbounded_String; Password : in Unbounded_String);

   -----------------------------------------------------------------------------

   --Fordere beim Server einen Chatroom an.
   procedure RequestChatroom(This : in out Concrete_Client; UserName : in Unbounded_String; Id_Receiver : in Integer;
                             Participant : in Unbounded_String);

   --Verlaesst einen Chatroom.
   procedure LeaveChatroom(This : in out Concrete_Client; UserName : in Unbounded_String; Id_Receiver : in Integer;
                           Message : in Unbounded_String);

   -----------------------------------------------------------------------------

   --Diese Prozedur sendet eine Nachricht an den ueber Id_Receiver angegebenen Chatraum.
   procedure SendTextMessage(This : in out Concrete_Client; Username : in Unbounded_String;
                             Id_Receiver : in Integer; Msg : in Unbounded_String);

   --Diese Prozedur sendet ein MessageOBject an die uebergebene Id.
   procedure SendMessageObject(This : in out Concrete_Client; Username : in Unbounded_String;
                               Id_Receiver : in Integer; MsgObject : in MessageObject);

   --Diese Funktion liest Messageobjects vom Server-Stream.
   function ReadFromServer(This : in out Concrete_Client; ServerSocket : in Socket_Type) return Unbounded_String;

   --Diese Funktion verarbeitet MessageObjects.
   function ProcessMessageObject(This : in out Concrete_Client; MsgObject : in MessageObject) return Unbounded_String;

   -----------------------------------------------------------------------------

   procedure RefreshUserlist(This : in out Concrete_Client; User : in Unbounded_String);

   function searchFriendList(This : in out Concrete_Client; User : in Unbounded_String) return Boolean;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   --#Implementierung des Gui2Client_Communication interfaces

   procedure InitializeSocket(This : in out Concrete_Client; ServerAdress : in Unbounded_String;
                              ServerPort : in Port_Type);

   procedure LoginUser (This : in out Concrete_Client; Username : in Unbounded_String; Password : in Unbounded_String;
                        ServerAdress : in Unbounded_String);

   procedure DisconnectUser(This : in out Concrete_Client; Username : in Unbounded_String; Message : in Unbounded_String);

   procedure RegisterUser(This : in out Concrete_Client; Username : in Unbounded_String; Password : in Unbounded_String);

   procedure InviteToGroupChat(This : in out Concrete_Client; Username : in Unbounded_String; Receiver : in Integer;
                               Participant : in Unbounded_String);

   procedure SendMessageToChat(This : in out Concrete_Client; Receiver: in Integer; Username : in Unbounded_String;
                               Message : in Unbounded_String);
   -----------------------------------------------------------------------------

end Concrete_Client_Logic;
