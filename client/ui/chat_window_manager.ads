with Gtkada.Builder;   use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Concrete_Client_Logic; use Concrete_Client_Logic;
with Client_Window;
with Ada.Containers.Doubly_Linked_Lists;

package Chat_Window_Manager is

   GladeFile : constant String := "client/Chat_Window.glade";
   type ChatWindow is new Client_Window.Window with private;
   type ChatWindow_Ptr is access ChatWindow;
   package ChatWindows is new Ada.Containers.Doubly_Linked_Lists(Element_Type => ChatWindow_Ptr);

   procedure test(This : in out ChatWindow; ChatName : String);
private
   type ChatWindow is new Client_Window.Window with record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
   end record;


   procedure Init(This : in out ChatWindow);

   procedure Check_RightClick  (Object : access Gtkada_Builder_Record'Class);
   procedure Invite_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure History_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Games_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Smiley_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Handle_Enter  (Object : access Gtkada_Builder_Record'Class);

end Chat_Window_Manager;
