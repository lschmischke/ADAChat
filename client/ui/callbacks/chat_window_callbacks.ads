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

   function Check_If_Enter  (Object : access Gtk.GEntry.Gtk_Entry_Record'Class;
                             Params : Glib.Values.GValues) return Boolean;

end Chat_Window_Callbacks;
