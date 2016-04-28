with Ada.Text_IO; use Ada.Text_IO;

with System;
with Glib;
with Gtk.Main;
with Gtk.List_Store; use Gtk.List_Store;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Tree_Model; use Gtk.Tree_Model;
with Gtk.Tree_Selection; use Gtk.Tree_Selection;
with Client_Ui; use Client_Ui;

package body Contact_Window_Callbacks is

   procedure Search_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Update_Status  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Add_Action  (Object : access Gtkada_Builder_Record'Class) is
   begin
      Put_Line("I'm the Add Menuitem. I would add a friend for you, if I knew how.");
   end Add_Action;

   procedure Offline_Contact_Action  (Object : access Gtkada_Builder_Record'Class) is
      selection : Gtk_Tree_Selection;
      selectedIter : Gtk_Tree_Iter;
      selectedModel : Gtk_Tree_Model;
      offlineList : Gtk_List_Store;
   begin
      selection := Gtk_Tree_Selection(Object.Get_Object("Selected_Offline_Contact"));
      selection.Get_Selected(selectedModel, selectedIter);
      offlineList := Gtk_List_Store(Object.Get_Object("offlinecontacts_list"));
      Put_Line(offlineList.Get_String(selectedIter, 0));
   end Offline_Contact_Action;

   procedure Online_Contact_Action  (Object : access Gtkada_Builder_Record'Class) is
      selection : Gtk_Tree_Selection;
      selectedIter : Gtk_Tree_Iter;
      selectedModel : Gtk_Tree_Model;
      onlineList : Gtk_List_Store;
   begin
      selection := Gtk_Tree_Selection(Object.Get_Object("Selected_Online_Contact"));
      selection.Get_Selected(selectedModel, selectedIter);
      onlineList := Gtk_List_Store(Object.Get_Object("onlinecontacts_list"));
      Put_Line(onlineList.Get_String(selectedIter, 0));
   end Online_Contact_Action;

end Contact_Window_Callbacks;
