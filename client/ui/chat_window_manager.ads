with Gtkada.Builder;   use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Concrete_Client_Logic; use Concrete_Client_Logic;

package Chat_Window_Manager is

   GladeFile : constant String := "Chat_Window.glade";
   type ChatWindow is tagged record with private;
   type ChatWindow_Ptr is access ChatWindow;
   type ChatWindows is new Unbounded_Array;

   private
   type ChatWindow is record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
   end record;

   procedure test;

   procedure Check_RightClick  (Object : access Gtkada_Builder_Record'Class);
   procedure Invite_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure History_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Games_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Smiley_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Handle_Enter  (Object : access Gtkada_Builder_Record'Class);

end Chat_Window_Manager;
