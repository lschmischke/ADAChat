with Ada.Text_IO;

with Gtk;              use Gtk;
with Gtk.Main;         use Gtk.Main;
with Glib.Error;       use Glib.Error;
with Gtk.Widget;       use Gtk.Widget;
with Gtk.Button;       use Gtk.Button;
with Gtkada.Builder;   use Gtkada.Builder;
with Glib;             use Glib;
with Glib.Error;       use Glib.Error;
with Gtk.Window;       use Gtk.Window;
with Gtk.GEntry;       use Gtk.GEntry;
with GNAT.Sockets;     use GNAT.Sockets;
with Gtk.List_Store;   use Gtk.List_Store;
with Gtk.Tree_Model;   use Gtk.Tree_Model;

with System;

package body Concrete_Client_Ui is

   procedure showMessage is null;
   procedure setConnectionStatus is null;
   procedure updateChatParticipants is null;

   procedure initClientUI(This : in out Concrete_Ui; Client_Instance : Client_Window.Client_Ptr) is
      ret : GUint;
      Error : aliased GError;
   begin
      --  Initialize GtkAda.
      Gtk.Main.Init;

      This.Client := Client_Instance;

      This.Login_Window.Init(This.Client);

      Instance := This;
      --  Start the Gtk+ main loop
      Gtk.Main.Main;
      Unref(This.Login_Window.Builder);
      Unref(This.Contact_Window.Builder);
   end initClientUI;


   procedure Register_Action (Object : access Gtkada_Builder_Record'Class) is
      username : Gtk_Entry;
      password : Gtk_Entry;
      serverIP : Gtk_Entry;
      serverport : Gtk_Entry;
      answer : MessageObject;
   begin
      username := Gtk_Entry(Object.Get_Object("Login_Username"));
      password := Gtk_Entry(Object.Get_Object("Login_Password"));
      serverIP := Gtk_Entry(Object.Get_Object("Settings_IP"));
      serverport := Gtk_Entry(Object.Get_Object("Settings_Port"));
                         -- Funktioniert nicht
      Instance.Client.RegisterUser(Username => To_Unbounded_String(username.Get_Text),
                                   Password => To_Unbounded_String(password.Get_Text),
                                   ServerAdress => To_Unbounded_String(serverIP.Get_Text),
                                   ServerPort => Port_Type'Value(serverport.Get_Text),
                                   AnswerFromServer => answer);


   end Register_Action;

   procedure Login_Action (Object : access Gtkada_Builder_Record'Class) is
      username : Gtk_Entry;
      password : Gtk_Entry;
      serverIP : Gtk_Entry;
      serverport : Gtk_Entry;

      --      onlineList : Gtk_List_Store;
      --      offlineList : Gtk_List_Store;

      --      temp : Gtk_Tree_Iter;

      answer : MessageObject;
   begin
      username := Gtk_Entry(Object.Get_Object("Login_Username"));
      password := Gtk_Entry(Object.Get_Object("Login_Password"));
      serverIP := Gtk_Entry(Object.Get_Object("Settings_IP"));
      serverport := Gtk_Entry(Object.Get_Object("Settings_Port"));

                   -- Funktioniert nicht
      Instance.Client.LoginUser(Username => To_Unbounded_String(username.Get_Text),
                                Password => To_Unbounded_String(password.Get_Text),
                                ServerAdress => To_Unbounded_String(serverIP.Get_Text),
                                ServerPort => Port_Type'Value(serverport.Get_Text),
                                AnswerFromServer => answer);

      if answer.messagetype = Connect then
         if answer.content = "ok" then
            Instance.Login_Window.Window.Hide;
            Instance.Contact_Window.Init(Instance.Client);

            --onlineList := Gtk_List_Store(Object.Get_Object("onlinecontacts_list"));
            --offlineList := Gtk_List_Store(Object.Get_Object("offlinecontacts_list"));

            --    Chat_Window_Manager.test;
            --temp := Assign(temp, "Mein meega Test");
            --offlineList.Append(temp);
            --offlineList.Set(temp, 0, "Mein meega Test");
            --offlineList.Append(temp);
            --offlineList.Set(temp, 0, "Was anders");
            Instance.AddOnlineUser(To_Unbounded_String("Thomas"));
            Instance.AddOnlineUser(To_Unbounded_String("Ewald"));
            Instance.AddOfflineUser(To_Unbounded_String("Daniel"));
            Instance.AddOfflineUser(To_Unbounded_String("Sebastian"));
            Instance.AddOfflineUser(To_Unbounded_String("Leonard"));

            Instance.AddOnlineUser(To_Unbounded_String("Daniel"));
            Instance.AddOnlineUser(To_Unbounded_String("Leonard"));
            Instance.AddOnlineUser(To_Unbounded_String("Sebastian"));

         else

            null; -- TODO Fehler, Benutzername Passwort falsch
         end if;
      else
         null; -- TODO Fehler, ggf. REFUSED abfragen, sonst Kommunikationsfehler
      end if;
   end Login_Action;

   procedure AddOnlineUser(This : in Concrete_Ui; UserName : Unbounded_String) is
      offlineList : Gtk_List_Store;
      onlineList : Gtk_List_Store;
      temp : Gtk_Tree_Iter;
   begin
      offlineList := Gtk_List_Store(This.Contact_Window.Builder.Get_Object("offlinecontacts_list"));
      onlineList := Gtk_List_Store(This.Contact_Window.Builder.Get_Object("onlinecontacts_list"));

      onlineList.Append(temp);
      onlineList.Set(temp, 0, To_String(UserName));

      temp := offlineList.Get_Iter (onlineList.Get_Path (temp));
      offlineList.Remove(temp);
   end AddOnlineUser;

   procedure AddOfflineUser(This : in Concrete_Ui; UserName : Unbounded_String) is
      offlineList : Gtk_List_Store;
      onlineList : Gtk_List_Store;
      temp : Gtk_Tree_Iter;
   begin
      offlineList := Gtk_List_Store(This.Contact_Window.Builder.Get_Object("offlinecontacts_list"));
      onlineList := Gtk_List_Store(This.Contact_Window.Builder.Get_Object("onlinecontacts_list"));

      offlineList.Append(temp);
      offlineList.Set(temp, 0, To_String(UserName));
   end AddOfflineUser;

   procedure ShowChatMessages(This : in Concrete_Ui; message : in MessageObject) is

   begin
      null;
   end ShowChatMessages;


   procedure Quit (Object : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Object);
   begin
      --Instance.Client.DisconnectUser(
      Gtk.Main.Main_Quit;

   end Quit;

   -----------------------------------------------------------------------------

   procedure ShowChatMessages(This : in GUI; message : MessageObject) is

   begin

      null;
   end ShowChatMessages;

   -----------------------------------------------------------------------------

   procedure LoginSuccess(This : in GUI) is

   begin
      null;
   end LoginSuccess;

   -----------------------------------------------------------------------------

   procedure RefusedMessage(This : in GUI; Reason : in Unbounded_String) is

   begin
      null;
   end RefusedMessage;

   -----------------------------------------------------------------------------

   procedure InitializeStatus(This : in GUI; Status : in Unbounded_String) is

   begin
      null;
   end InitializeStatus;

   -----------------------------------------------------------------------------

   procedure DisconnectReason(This : in GUI; Status : in Unbounded_String) is

   begin
      null;
   end DisconnectReason;

   -----------------------------------------------------------------------------
   -- Fügt den User der Online Liste hinzu und entfernt ihn aus der Offline Liste (falls vorhanden)
   procedure AddOnlineUser(This : in GUI; UserName : Unbounded_String) is

   begin
      null;
   end AddOnlineUser;

   -----------------------------------------------------------------------------

   -- Fügt den User der Offline Liste hinzu und entfernt ihn aus der Online Liste (falls vorhanden)
   procedure AddOfflineUser(This : in GUI; UserName : Unbounded_String) is

   begin
      null;
   end AddOfflineUser;

   -----------------------------------------------------------------------------
end Concrete_Client_Ui;
