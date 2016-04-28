with Ada.Text_IO; use Ada.Text_IO;

with Gtk.Main;
with Gtk.GEntry; use Gtk.GEntry;
with Gtk.List_Store; use Gtk.List_Store;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Tree_Model; use Gtk.Tree_Model;
with Client_Ui; use Client_Ui;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.Sockets; use GNAT.Sockets;
with Protocol; use Protocol;
with Chat_Window_Manager;

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

      Msg : MessageObject;
   begin
      username := Gtk_Entry(Object.Get_Object("Login_Username"));
      password := Gtk_Entry(Object.Get_Object("Login_Password"));
      serverIP := Gtk_Entry(Object.Get_Object("Settings_IP"));
      serverport := Gtk_Entry(Object.Get_Object("Settings_Port"));

      Client_Ui.Client.LoginUser(To_Unbounded_String(username.Get_Text), To_Unbounded_String(password.Get_Text));
      --                                 To_Unbounded_String(serverIP.Get_Text), Port_Type'Value(serverport.Get_Text));

      --Msg := readMessageFromStream(ClientSocket => Client.Socket);
      --printMessageToInfoConsole(msg);
      --if Msg.messagetype = Connect then
      --  if Msg.content = "ok" then
          Main_Window.Hide;
          Contact_Window.Show_All;

          onlineList := Gtk_List_Store(Object.Get_Object("onlinecontacts_list"));
          offlineList := Gtk_List_Store(Object.Get_Object("offlinecontacts_list"));

      --    Chat_Window_Manager.test;
          --temp := Assign(temp, "Mein meega Test");
          --offlineList.Append(temp);
          --offlineList.Set(temp, 0, "Mein meega Test");
          --offlineList.Append(temp);
          --offlineList.Set(temp, 0, "Was anders");
   --      else
            null; -- TODO Fehler, Benutzername Passwort falsch
   --      end if;
   --   else
         null; -- TODO Fehler, ggf. REFUSED abfragen, sonst Kommunikationsfehler
   --   end if;
   end Login_Action;

end Main_Window_Callbacks;
