with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Button; use Gtk.Button;

package ServerGuiCallbacks is

   procedure Quit (Object : access Gtkada_Builder_Record'Class);
   procedure InitializeGuiReferences(myBuilder: access Gtkada_Builder_Record'Class);

procedure rowHandler ( Object : access Gtkada_Builder_Record'Class);
   procedure clicked_button_about ( Object : access Gtkada_Builder_Record'Class);
   procedure clicked_button_server_start ( Object : access Gtkada_Builder_Record'Class);
   procedure clicked_button_server_stop ( Object : access Gtkada_Builder_Record'Class);
   procedure kickSelectedUser (Object : access Gtkada_Builder_Record'Class);
end ServerGuiCallbacks;
