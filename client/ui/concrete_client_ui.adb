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

      This.Login_Window.Init;

      --  Start the Gtk+ main loop
      Gtk.Main.Main;
      Unref(This.Login_Window.Builder);
      Unref(This.Contact_Window.Builder);
   end initClientUI;


   procedure Error_Message(This : in out Concrete_Ui; message : String) is
      dialog : aliased Gtk_Message_Dialog;
      ret : Gtk_Response_Type;
   begin
      dialog := Gtk_Message_Dialog_New (Parent   => This.Login_Window.Window,
                                        Flags    => Destroy_With_Parent,
                                        The_Type => Message_Error,
                                        Buttons  => Buttons_Ok,
                                        Message  => "Error: %s",
                                        Arg5     => message'Address);
      ret := Run(Gtk_Dialog(dialog));
      dialog.Destroy;
   end Error_Message;

   procedure Info_Message(This : in out Concrete_Ui; message : String) is
      dialog : aliased Gtk_Message_Dialog;
      ret : Gtk_Response_Type;
   begin
      dialog := Gtk_Message_Dialog_New (Parent   => This.Login_Window.Window,
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
         Instance.Error_Message(message => "Socket_Error in InitializeSocket");
         username.Set_Editable(true);
         password.Set_Editable(true);
         serverIP.Set_Editable(true);
         serverport.Set_Editable(true);

      when Error : others =>
         Instance.Error_Message(message => "Unexpected exception in InitializeSocket");
         username.Set_Editable(true);
         password.Set_Editable(true);
         serverIP.Set_Editable(true);
         serverport.Set_Editable(true);

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


      username.Set_Editable(false);
      password.Set_Editable(false);
      serverIP.Set_Editable(false);
      serverport.Set_Editable(false);

      Instance.Client.InitializeSocket (ServerAdress => To_Unbounded_String(serverIP.Get_Text),
                                        ServerPort   => Port_Type'Value(serverport.Get_Text));
      Instance.Client.LoginUser        (Username => To_Unbounded_String(username.Get_Text),
                                        Password => To_Unbounded_String(password.Get_Text));
      Instance.UserName := To_Unbounded_String(username.Get_Text);
      --Instance.LoginSuccess;
   exception
      when Error : Socket_Error =>
         Instance.Error_Message(message => "Socket_Error in InitializeSocket");
         username.Set_Editable(true);
         password.Set_Editable(true);
         serverIP.Set_Editable(true);
         serverport.Set_Editable(true);

      when Error : others =>
         Instance.Error_Message("Unexpected exception in InitializeSocket");
         username.Set_Editable(true);
         password.Set_Editable(true);
         serverIP.Set_Editable(true);
         serverport.Set_Editable(true);

   end Login_Action;

   procedure SetOnlineUser(This : in out Concrete_Ui; Users : Client2Gui_Communication.Userlist.Set) is
      onlineList : Gtk_List_Store;
      newItem : Gtk_Tree_Iter;
   begin
      onlineList := Gtk_List_Store(This.Contact_Window.Builder.Get_Object("onlinecontacts_list"));

      for E in Users.Iterate
      loop
         onlineList.Append(newItem);
         onlineList.Set(newItem, 0, To_String(Client2Gui_Communication.Userlist.Element(E)));
      end loop;

   end SetOnlineUser;

   procedure SetOfflineUser(This : in out Concrete_Ui; Users : Client2Gui_Communication.Userlist.Set) is
      offlineList : Gtk_List_Store;
      newItem : Gtk_Tree_Iter;
   begin
      offlineList := Gtk_List_Store(This.Contact_Window.Builder.Get_Object("offlinecontacts_list"));

      --for E in Users.Iterate
      --loop
      --   offlineList.Append(newItem);
      --   offlineList.Set(newItem, 0, To_String(Client2Gui_Communication.Userlist.Element(E)));
      --end loop;
   end SetOfflineUser;

   -----------------------------------------------------------------------------

   procedure ContactRemove(This : in out Concrete_Ui; Username : in Unbounded_String) is

   begin
      null;

   end ContactRemove;

   -----------------------------------------------------------------------------

   procedure ContactRequest(This : in out Concrete_Ui; Username : in Unbounded_String) is

   begin
      null;

   end ContactRequest;

   -----------------------------------------------------------------------------

   procedure Quit (Object : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Object);
   begin
      Instance.Client.DisconnectUser(Username => Instance.UserName,
                                     Message  => To_Unbounded_String("Bye"));
      Gtk.Main.Main_Quit;

   end Quit;

   -----------------------------------------------------------------------------

   procedure ShowChatParticipants(This : in out Concrete_Ui; Chatraum : in Natural; Participants : in Client2Gui_Communication.Userlist.Set) is

   begin
      null;

   end ShowChatParticipants;

   -----------------------------------------------------------------------------

   procedure ShowChatMessages(This : in out Concrete_Ui; message : MessageObject) is

   begin

      null;

   end ShowChatMessages;

   -----------------------------------------------------------------------------

   procedure LoginSuccess(This : in out Concrete_Ui) is
      username : Gtk_Entry;
      onlineStatus : Gtk_Combo_Box_Text;
   begin
      username := Gtk_Entry(This.Login_Window.Builder.Get_Object("Login_Username"));
      This.Login_Window.Window.Hide;
      This.Contact_Window.Init;
      onlineStatus := Gtk_Combo_Box_Text(This.Contact_Window.Builder.Get_Object("Status_Combo"));

      onlineStatus.Set_Active(0);
   end LoginSuccess;

   -----------------------------------------------------------------------------

   procedure RefusedMessage(This : in out Concrete_Ui; Reason : in Unbounded_String) is
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

      This.Error_Message(To_String(Reason));

   end RefusedMessage;

   -----------------------------------------------------------------------------

   procedure InitializeStatus(This : in Concrete_Ui; Status : in Unbounded_String) is

   begin
      null;
   end InitializeStatus;

   -----------------------------------------------------------------------------

   procedure DisconnectReason(This : in out Concrete_Ui; Status : in Unbounded_String) is
      onlineStatus : Gtk_Combo_Box_Text;
   begin
      Instance.Info_Message("Disconnected");
      onlineStatus := Gtk_Combo_Box_Text(This.Contact_Window.Builder.Get_Object("Status_Combo"));

      onlineStatus.Set_Active(1);
   end DisconnectReason;

   -----------------------------------------------------------------------------


end Concrete_Client_Ui;
