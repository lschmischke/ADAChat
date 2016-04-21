with Ada.Text_IO; use Ada.Text_IO;

with Gtk.Main;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Tree_Selection; use Gtk.Tree_Selection;
with Client_Ui; use Client_Ui;

package body Contact_Window_Callbacks is

   procedure Search_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Update_Status  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Add_Action  (Object : access Gtkada_Builder_Record'Class) is
   begin
      Put_Line("I'm the Add Menuitem. I would add a friend for you, if I knew how.");
   end Add_Action;

   procedure Contact_Action  (Object : access Gtkada_Builder_Record'Class) is
   begin
      Put_Line("Cüs");
   end Contact_Action;

end Contact_Window_Callbacks;
