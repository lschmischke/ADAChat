with Ada.Text_IO; use Ada.Text_IO;

with Gtk.Main;
with Gtk.GEntry; use Gtk.GEntry;
with Gtk.List_Store; use Gtk.List_Store;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Tree_Model; use Gtk.Tree_Model;
with Glib.String; use Glib.String;
with Client_Ui; use Client_Ui;

package body Main_Window_Callbacks is

   procedure Register_Action (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Login_Action (Object : access Gtkada_Builder_Record'Class) is
      username : Gtk_Entry;
      password : Gtk_Entry;
      serverIP : Gtk_Entry;
      serverport : Gtk_Entry;

      onlineList : Gtk_List_Store;
      offlineList : Gtk_List_Store;

      temp : Gtk_Tree_Iter;
   begin
      username := Gtk_Entry(Object.Get_Object("Login_Username"));
      password := Gtk_Entry(Object.Get_Object("Login_Password"));
      serverIP := Gtk_Entry(Object.Get_Object("Settings_IP"));
      serverport := Gtk_Entry(Object.Get_Object("Settings_Port"));

      Put_Line("Hello, I'm the Login Button.");
      Put_Line("I do nothing.");
      Put("I would try to connect to ");
      Put(serverIP.Get_Text);
      Put(" on Port ");
      Put(serverport.Get_Text);
      Put(" with the username ");
      Put(username.Get_Text);
      Put(" and the password ");
      Put(password.Get_Text);
      Put(".");
      New_Line;
      Put_Line("But I don't know how yet.");
      Main_Window.Hide;
      Contact_Window.Show_All;
      Put_Line("I would also load up your contact list.");

      onlineList := Gtk_List_Store(Object.Get_Object("onlinecontacts_list"));
      offlineList := Gtk_List_Store(Object.Get_Object("offlinecontacts_list"));

      --temp := Assign(temp, "Mein meega Test");
      offlineList.Append(temp);
      offlineList.Set(temp, 0, "Mein meega Test");
      offlineList.Append(temp);
      offlineList.Set(temp, 0, "Was anders");
   end Login_Action;

end Main_Window_Callbacks;
