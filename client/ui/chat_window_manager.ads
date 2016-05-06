with Gtkada.Builder;   use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Concrete_Client_Logic;
with Client_Window;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Containers; use Ada.Containers;

package Chat_Window_Manager is

   GladeFile : constant String := "client/Chat_Window.glade";
   type ChatWindow is new Client_Window.Window with private;
   type ChatWindow_Ptr is access ChatWindow;
   function Hash (R : Natural) return Hash_Type;
   --package ChatWindows is new Ada.Containers.Doubly_Linked_Lists(Element_Type => ChatWindow_Ptr);
   package ChatWindows is new Ada.Containers.Indefinite_Hashed_Maps(Key_Type        => Natural,
                                                                    Element_Type    => ChatWindow_Ptr,
                                                                    Hash            => Hash,
                                                                    Equivalent_Keys => "=",
                                                                    "="             => "=");
   type MapPtr is access all ChatWindows.Map'Class;

   package ChatUsers is new Ada.Containers.Indefinite_Hashed_Maps(Key_Type        => Unbounded_String,
                                                                  Element_Type    => Natural,
                                                                  Hash            => Ada.Strings.Unbounded.Hash_Case_Insensitive,
                                                                  Equivalent_Keys => "=",
                                                                  "="             => "=");

   procedure OpenNewChatWindow(This : in out MapPtr; MyName: Unbounded_String; ChatName : Unbounded_String);

   function ChatWindowOpen(This : in out MapPtr; ChatName : String) return Boolean;

   MyUsers : ChatUsers.Map;

   MyWindows : MapPtr;

   MyUserName : Unbounded_String;

private
   type ChatWindow is new Client_Window.Window with record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
      ChatID : Natural;
   end record;


   procedure Init(This : in out ChatWindow);


   procedure Check_RightClick  (Object : access Gtkada_Builder_Record'Class);
   procedure Invite_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure History_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Games_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Smiley_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Handle_Enter  (Object : access Gtkada_Builder_Record'Class);

end Chat_Window_Manager;
