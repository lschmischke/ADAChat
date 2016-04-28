with Gtkada.Builder; use Gtkada.Builder;
with Gtk;
with Gtk.GEntry;
with Gtk.Handlers;
with Glib;
with Glib.Values;

package Chat_Window_Callbacks is

   procedure Check_RightClick  (Object : access Gtkada_Builder_Record'Class);
   procedure Invite_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure History_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Games_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Smiley_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Handle_Enter  (Object : access Gtkada_Builder_Record'Class);

end Chat_Window_Callbacks;
