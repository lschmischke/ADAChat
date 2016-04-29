with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Button; use Gtk.Button;

package ServerGuiCallbacks is

   procedure Quit (Object : access Gtkada_Builder_Record'Class);
   procedure InitializeGuiReferences(Builder: access Gtkada_Builder_Record'Class);

procedure rowHandler ( Object : access Gtkada_Builder_Record'Class);
   procedure clicked_button_about ( Object : access Gtkada_Builder_Record'Class);
end ServerGuiCallbacks;
