with Ada.Text_IO;

with Gtk;                use Gtk;
with Gtk.Main;           use Gtk.Main;
with Glib.Error;         use Glib.Error;
with Gtk.Widget;         use Gtk.Widget;
with Gtk.Button;         use Gtk.Button;
with Gtk.Message_Dialog; use Gtk.Message_Dialog;
with Gtk.Dialog;         use Gtk.Dialog;
with Gtkada.Builder;     use Gtkada.Builder;
with Glib;               use Glib;
with Glib.Error;         use Glib.Error;
with Gtk.Window;         use Gtk.Window;
with Gtk.GEntry;         use Gtk.GEntry;
with GNAT.Sockets;       use GNAT.Sockets;
with Gtk.List_Store;     use Gtk.List_Store;
with Gtk.Tree_Model;     use Gtk.Tree_Model;
with Gtk.Combo_Box_Text; use Gtk.Combo_Box_Text;

with System;

package body Concrete_Client_Ui is

   procedure showMessage is null;
   procedure setConnectionStatus is null;
   procedure updateChatParticipants is null;

   procedure initClientUI(This : in out Concrete_Ui; Client_Instance : ClientPtr) is
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


   procedure Error_Message(message : String) is
      dialog : aliased Gtk_Message_Dialog;
      ret : Gtk_Response_Type;
   begin
      dialog := Gtk_Message_Dialog_New (Parent   => Instance.Login_Window.Window,
                                        Flags    => Destroy_With_Parent,
                                        The_Type => Message_Error,
                                        Buttons  => Buttons_Ok,
                                        Message  => "Error: %s",
                                        Arg5     => message'Address);
      ret := Run(Gtk_Dialog(dialog));
      dialog.Destroy;
   end Error_Message;

   procedure Info_Message(message : String) is
      dialog : aliased Gtk_Message_Dialog;
      ret : Gtk_Response_Type;
   begin
      dialog := Gtk_Message_Dialog_New (Parent   => Instance.Login_Window.Window,
                                        Flags    => Destroy_With_Parent,
                                        The_Type => Message_Info,
                                        Buttons  => Buttons_Ok,
                                        Message  => "%s",
                                        Arg5     => message'Address);
      ret := Run(Gtk_Dialog(dialog));
      dialog.Destroy;
   end Info_Message;

   procedure Register_Action (Object : access Gtkada_Builder_Record'Class) is
      username : Gtk_Entry;
      password : Gtk_Entry;
      serverIP : Gtk_Entry;
      serverport : Gtk_Entry;
   begin
      username := Gtk_Entry(Object.Get_Object("Login_Username"));
      password := Gtk_Entry(Object.Get_Object("Login_Password"));
      serverIP := Gtk_Entry(Object.Get_Object("Settings_IP"));
      serverport := Gtk_Entry(Object.Get_Object("Settings_Port"));

      username.Set_Editable(false);
      password.Set_Editable(false);
      serverIP.Set_Editable(false);
      serverport.Set_Editable(false);

      Instance.Client.InitializeSocket(ServerAdress => To_Unbounded_String(serverIP.Get_Text),
                                       ServerPort   => Port_Type'Value(serverport.Get_Text));
      Instance.Client.RegisterUser    (Username => To_Unbounded_String(username.Get_Text),
                                       Password => To_Unbounded_String(password.Get_Text));
   exception
      when Error : Socket_Error =>
         --Put ("Socket_Error in ConnectToServer: ");
         --Put_Line (Exception_Information (Error));
         Error_Message(message => "Socket_Error in InitializeSocket");
      when Error : others =>
         --Put ("Unexpected exception in ConnectToServer: ");
         --Put_Line (Exception_Information (Error));
         Error_Message("Unexpected exception in InitializeSocket");
   end Register_Action;

   procedure Login_Action (Object : access Gtkada_Builder_Record'Class) is
      username : Gtk_Entry;
      password : Gtk_Entry;
      serverIP : Gtk_Entry;
      serverport : Gtk_Entry;
   begin
      username := Gtk_Entry(Object.Get_Object("Login_Username"));
      password := Gtk_Entry(Object.Get_Object("Login_Password"));
      serverIP := Gtk_Entry(Object.Get_Object("Settings_IP"));
      serverport := Gtk_Entry(Object.Get_Object("Settings_Port"));

      Instance.Client.InitializeSocket (ServerAdress => To_Unbounded_String(serverIP.Get_Text),
                                        ServerPort   => Port_Type'Value(serverport.Get_Text));
      Instance.Client.LoginUser        (Username => To_Unbounded_String(username.Get_Text),
                                        Password => To_Unbounded_String(password.Get_Text));
      Instance.UserName := To_Unbounded_String(username.Get_Text);
      Instance.LoginSuccess;
   exception
      when Error : Socket_Error =>
         --Put ("Socket_Error in ConnectToServer: ");
         --Put_Line (Exception_Information (Error));
         Error_Message(message => "Socket_Error in InitializeSocket");
      when Error : others =>
         --Put ("Unexpected exception in ConnectToServer: ");
         --Put_Line (Exception_Information (Error));
         Error_Message("Unexpected exception in InitializeSocket");
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

   procedure Quit (Object : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Object);
   begin
      Instance.Client.DisconnectUser(Username => Instance.UserName,
                                     Message  => To_Unbounded_String("Bye"));
      Gtk.Main.Main_Quit;

   end Quit;

   -----------------------------------------------------------------------------

   procedure ShowChatMessages(This : in Concrete_Ui; message : MessageObject) is

   begin

      null;
   end ShowChatMessages;

   -----------------------------------------------------------------------------

   procedure LoginSuccess(This : in out Concrete_Ui) is
      username : Gtk_Entry;
      onlineStatus : Gtk_Combo_Box_Text;
   begin
      username := Gtk_Entry(This.Login_Window.Builder.Get_Object("Login_Username"));
      Instance.Login_Window.Window.Hide;
      Instance.Contact_Window.Init(Instance.Client);
      onlineStatus := Gtk_Combo_Box_Text(This.Contact_Window.Builder.Get_Object("Status_Combo"));

      onlineStatus.Set_Active(0);

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
   end LoginSuccess;

   -----------------------------------------------------------------------------

   procedure RefusedMessage(This : in Concrete_Ui; Reason : in Unbounded_String) is
      username : Gtk_Entry;
      password : Gtk_Entry;
      serverIP : Gtk_Entry;
      serverport : Gtk_Entry;
   begin
      username := Gtk_Entry(This.Login_Window.Builder.Get_Object("Login_Username"));
      password := Gtk_Entry(This.Login_Window.Builder.Get_Object("Login_Password"));
      serverIP := Gtk_Entry(This.Login_Window.Builder.Get_Object("Settings_IP"));
      serverport := Gtk_Entry(This.Login_Window.Builder.Get_Object("Settings_Port"));

      username.Set_Editable(true);
      password.Set_Editable(true);
      serverIP.Set_Editable(true);
      serverport.Set_Editable(true);

      Error_Message(To_String(Reason));
   end RefusedMessage;

   -----------------------------------------------------------------------------

   procedure InitializeStatus(This : in Concrete_Ui; Status : in Unbounded_String) is

   begin
      null;
   end InitializeStatus;

   -----------------------------------------------------------------------------

   procedure DisconnectReason(This : in Concrete_Ui; Status : in Unbounded_String) is
      onlineStatus : Gtk_Combo_Box_Text;
   begin
      Info_Message("Disconnected");
      onlineStatus := Gtk_Combo_Box_Text(This.Contact_Window.Builder.Get_Object("Status_Combo"));

      onlineStatus.Set_Active(1);
   end DisconnectReason;

   -----------------------------------------------------------------------------


end Concrete_Client_Ui;
