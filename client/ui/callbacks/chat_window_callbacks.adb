with Ada.Text_IO; use Ada.Text_IO;

with Gtk.Main;
with Gtk.GEntry; use Gtk.GEntry;

package body Chat_Window_Callbacks is

   procedure Check_RightClick  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Invite_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure History_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Games_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Smiley_Action  (Object : access Gtkada_Builder_Record'Class) is
   begin
      null;
   end Smiley_Action;

   procedure Handle_Enter  (Object : access Gtkada_Builder_Record'Class) is
      message : Gtk_Entry;
   begin
      message := Gtk_Entry(Object.Get_Object("New_Message"));
      Put_Line(message.Get_Text);
      message.Set_Text("");
   end Handle_Enter;

end Chat_Window_Callbacks;
