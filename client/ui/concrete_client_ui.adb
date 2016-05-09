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
with Gtk.Label;          use Gtk.Label;
with Gtk.Frame;          use Gtk.Frame;

with System;

package body Concrete_Client_Ui is

   -----------------------------------------------------------------------------

   procedure initClientUI(This : in out Concrete_Ui; Client_Instance : ClientPtr) is
   begin
      This.Client := Client_Instance;

      This.Login_Window.Init;
   end initClientUI;

   -----------------------------------------------------------------------------

   procedure Error_Message(This : in out Concrete_Ui; message : String) is
      label: Gtk_Label;
   begin
      label := Gtk_Label(This.Login_Window.Builder.Get_Object("Login_Error_Label"));
      label.Set_Text(message);
      if This.Contact_Window /= null then
         This.Contact_Window.Window.Hide;
      end if;
   end Error_Message;

   procedure Info_Message(This : in out Concrete_Ui; message : String) is
      label: Gtk_Label;
   begin
      label := Gtk_Label(This.Login_Window.Builder.Get_Object("Register_Info_Label"));
      label.Set_Text(message);
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

      return;
   exception
      when Error : Socket_Error =>
         username.Set_Editable(true);
         password.Set_Editable(true);
         serverIP.Set_Editable(true);
         serverport.Set_Editable(true);
         Instance.Error_Message(message => "Socket_Error in InitializeSocket");

      when Error : others =>
         username.Set_Editable(true);
         password.Set_Editable(true);
         serverIP.Set_Editable(true);
         serverport.Set_Editable(true);
         Instance.Error_Message(message => "Unexpected exception in InitializeSocket");

   end Register_Action;

   procedure Login_Action (Object : access Gtkada_Builder_Record'Class) is
      username : Gtk_Entry;
      password : Gtk_Entry;
      serverIP : Gtk_Entry;
      serverport : Gtk_Entry;
      onlineStatus : Gtk_Combo_Box_Text;
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
      Contact_Window.Instance := new ContactWindow;
      Instance.Contact_Window := Contact_Window.Instance;
      Instance.Contact_Window.Init;
      Instance.Client.LoginUser        (Username => To_Unbounded_String(username.Get_Text),
                                        Password => To_Unbounded_String(password.Get_Text));
      onlineStatus := Gtk_Combo_Box_Text(Instance.Contact_Window.Builder.Get_Object("Status_Combo"));

      onlineStatus.Set_Active(0);

      return;
   exception
      when Error : Socket_Error =>
         username.Set_Editable(true);
         password.Set_Editable(true);
         serverIP.Set_Editable(true);
         serverport.Set_Editable(true);
         Instance.Error_Message(message => "Socket_Error in InitializeSocket");

      when Error : others =>
         username.Set_Editable(true);
         password.Set_Editable(true);
         serverIP.Set_Editable(true);
         serverport.Set_Editable(true);
         Instance.Error_Message("Unexpected exception in InitializeSocket");

   end Login_Action;

   procedure SetOnlineUser(This : in out Concrete_Ui; Users : Client2Gui_Communication.Userlist.Set) is
      onlineList : Gtk_List_Store;
      newItem : Gtk_Tree_Iter;
      normal : Gint := 400;
   begin
      onlineList := Gtk_List_Store(This.Contact_Window.Builder.Get_Object("onlinecontacts_list"));

      onlineList.Clear;

      for E of Users
      loop
         onlineList.Append(newItem);
         onlineList.Set(newItem, 0, To_String(E));
         onlineList.Set(newItem, 1, normal);
      end loop;

   end SetOnlineUser;

   procedure SetOfflineUser(This : in out Concrete_Ui; Users : Client2Gui_Communication.Userlist.Set) is
      offlineList : Gtk_List_Store;
      newItem : Gtk_Tree_Iter;
   begin
      offlineList := Gtk_List_Store(This.Contact_Window.Builder.Get_Object("offlinecontacts_list"));

      offlineList.Clear;

      for E of Users
      loop
         offlineList.Append(newItem);
         offlineList.Set(newItem, 0, To_String(E));
      end loop;
   end SetOfflineUser;

   -----------------------------------------------------------------------------

   procedure ContactRemove(This : in out Concrete_Ui; Username : in Unbounded_String) is

   begin
      null;

   end ContactRemove;

   -----------------------------------------------------------------------------

   procedure ContactRequest(This : in out Concrete_Ui; Username : in Unbounded_String) is
      requestsList : Gtk_List_Store;
      newItem : Gtk_Tree_Iter;
      requestsFrame : Gtk_Frame;
   begin
      requestsList := Gtk_List_Store(This.Contact_Window.Builder.Get_Object("requests_list"));
      requestsFrame := Gtk_Frame(This.Contact_Window.Builder.Get_Object("treeview4"));
      requestsList.Append(newItem);
      requestsList.Set(newItem, 0, To_String(Username));
      if not requestsFrame.Is_Visible then
         requestsFrame.Set_Visible(True);
         requestsFrame.Show_All;
      end if;
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
      newItem : Gtk_Tree_Iter;
      --length : Natural;
      notMe : Unbounded_String;
   begin

      if not This.Chat_Windows.Contains(Chatraum) then
         Chat_Window_Manager.PrepareNewChatWindow(This.Chat_Windows, This.UserName, Chatraum);
      end if;
      This.Chat_Windows.Element(Chatraum).ChatParticipants.Clear;
      for E of Participants
      loop
         This.Chat_Windows.Element(Chatraum).ChatParticipants.Append(E);
         if E /= This.UserName then
            notMe := E;
         end if;
      end loop;
      This.Chat_Windows.Element(Chatraum).UpdateParticipants;
      if Integer(Participants.Length) = 2 and not Chat_Window_Manager.MyRooms.Contains(notMe) then
         Chat_Window_Manager.MyRooms.Insert(notMe, Chatraum);
      end if;
   end ShowChatParticipants;

   -----------------------------------------------------------------------------

   procedure ShowChatMessages(This : in out Concrete_Ui; message : MessageObject) is
   begin
      --if not This.Chat_Windows.Contains(message.receiver) then
      --   null; -- TODO anlegen
      --end if;
      This.Contact_Window.Highlight(message.sender);
      This.Chat_Windows.Element(message.receiver).EnQueueChatMessage(message);
   end ShowChatMessages;

   -----------------------------------------------------------------------------

   procedure LoginSuccess(This : in out Concrete_Ui) is
      username : Gtk_Entry;
   begin
      username := Gtk_Entry(This.Login_Window.Builder.Get_Object("Login_Username"));
      Instance.UserName := To_Unbounded_String(username.Get_Text);
      Chat_Window_Manager.MyUserName := Instance.UserName;
      This.Login_Window.Window.Hide;
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

   procedure DisconnectReason(This : in out Concrete_Ui; Status : in Unbounded_String) is
      onlineStatus : Gtk_Combo_Box_Text;
   begin
      Instance.Info_Message("Disconnected");
      onlineStatus := Gtk_Combo_Box_Text(This.Contact_Window.Builder.Get_Object("Status_Combo"));

      onlineStatus.Set_Active(1);
   end DisconnectReason;

   -----------------------------------------------------------------------------

   procedure UpdateChatRoomId(This : in out Concrete_Ui; ChatId : Natural; Name : Unbounded_String) is
   begin
      if not Chat_window_Manager.MyRooms.Contains(Name) then
         Chat_window_Manager.MyRooms.Insert(Name, ChatId);
      end if;
   end UpdateChatRoomId;

   -----------------------------------------------------------------------------

end Concrete_Client_Ui;
