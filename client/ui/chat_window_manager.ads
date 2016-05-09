with Ada.Characters.Latin_1;     use Ada.Characters.Latin_1;

with Gtkada.Builder;   use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Gtk.List_Store;   use Gtk.List_Store;
with Concrete_Client_Logic;
with Client_Window;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Containers; use Ada.Containers;
with Protocol; use Protocol;
with Gtk.Text_View;      use Gtk.Text_View;
with Gtk.Text_Iter;      use Gtk.Text_Iter;
with Gtk.Tree_Model;     use Gtk.Tree_Model;


package Chat_Window_Manager is

   GladeFile : constant String := "client/Chat_Window.glade";

   function Hash (R : Natural) return Hash_Type;

   package PrivateChatRooms is new Ada.Containers.Indefinite_Hashed_Maps(Key_Type        => Unbounded_String,
                                                                         Element_Type    => Natural,
                                                                         Hash            => Ada.Strings.Unbounded.Hash_Case_Insensitive,
                                                                         Equivalent_Keys => "=",
                                                                         "="             => "=");

   package ChatMessages is new Ada.Containers.Doubly_Linked_Lists(Element_Type => MessageObject);

   package GroupChatRooms is new Ada.Containers.Doubly_Linked_Lists(Element_Type => Natural);

   package Participants is new Ada.Containers.Doubly_Linked_Lists(Element_Type => Unbounded_String);

   type ChatWindow is new Client_Window.Window with record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
      ChatID : Natural;
      ChatName : Unbounded_String;
      ChatParticipants : Participants.List;
      Messages : ChatMessages.List;
      WindowOpen : Boolean := False;
   end record;

   type ChatWindow_Ptr is access ChatWindow;

   procedure UpdateParticipants (This : in out ChatWindow);

   package ChatWindows is new Ada.Containers.Indefinite_Hashed_Maps(Key_Type        => Natural,
                                                                    Element_Type    => ChatWindow_Ptr,
                                                                    Hash            => Hash,
                                                                    Equivalent_Keys => "=",
                                                                    "="             => "=");
   type MapPtr is access all ChatWindows.Map'Class;

   procedure OpenNewChatWindow(This : in out MapPtr; MyName: Unbounded_String; ChatName : Unbounded_String);
   procedure PrepareNewChatWindow(This : in out MapPtr; MyName: Unbounded_String; ChatID : Natural);

   procedure EnQueueChatMessage(This : in out ChatWindow; message : MessageObject);
   function DeQueueChatMessage (This : in out ChatWindow) return MessageObject;

   MyRooms : PrivateChatRooms.Map;

   MyWindows : MapPtr := new ChatWindows.Map;

   MyUserName : Unbounded_String;

private



   procedure Init(This : in out ChatWindow);
   procedure printChatMessage(This : in out ChatWindow; message : MessageObject);


   procedure Check_RightClick  (Object : access Gtkada_Builder_Record'Class);
   procedure Invite_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Handle_Enter  (Object : access Gtkada_Builder_Record'Class);

end Chat_Window_Manager;
