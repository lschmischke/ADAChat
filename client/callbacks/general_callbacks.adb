with Gtk.Main;
package body General_Callbacks is

   procedure Quit (Object : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Object);
   begin
      Gtk.Main.Main_Quit;

   end Quit;


end General_Callbacks;
