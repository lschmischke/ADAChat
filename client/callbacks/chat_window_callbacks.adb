with Gtk.Main;

package body Chat_Window_Callbacks is

   procedure Check_RightClick  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Invite_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure History_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Games_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Smiley_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   function Check_If_Enter  (Object : access Gtkada_Builder_Record'Class) return Boolean is
   begin
      return false;
   end Check_If_Enter;

end Chat_Window_Callbacks;
