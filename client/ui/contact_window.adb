with Ada.Text_IO; use Ada.Text_IO;

with Glib.Error; use Glib.Error;

with Gtkada.Builder; use Gtkada.Builder;

with Concrete_Client_Ui;

with System;
with Glib;
with Gtk.Main;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Tree_Model; use Gtk.Tree_Model;
with Gtk.Tree_Selection; use Gtk.Tree_Selection;
with Gtk.Message_Dialog; use Gtk.Message_Dialog;
with Gtk.Dialog; use Gtk.Dialog;
with Gtk; use Gtk;
with Concrete_Client_Ui; use Concrete_Client_Ui;
with Chat_Window_Manager; use Chat_Window_Manager;
with Gtk.Frame; use Gtk.Frame;

package body Contact_Window is

   procedure Init(This : in out ContactWindow) is
      ret : GUint;
      Error : aliased GError;
      newBuilder : Gtkada_Builder;
   begin
      Gtk_New (newBuilder);
      This.Builder := newBuilder;
      ret := This.Builder.Add_From_File (GladeFile, Error'Access);

      if Error /= null then
         Ada.Text_IO.Put_Line(Get_Message(Error));
         Error_Free(Error);
         return;
      end if;

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Main_Quit",
         Handler => Quit'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Search_Action",
         Handler => Search_Action'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Update_Status",
         Handler => Update_Status'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Add_Action",
         Handler => Add_Action'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Online_Contact_Action",
         Handler => Online_Contact_Action'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Offline_Contact_Action",
         Handler => Offline_Contact_Action'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Request_Action",
         Handler => Request_Action'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Groupchat_Action",
         Handler => Groupchat_Action'Access);

      Do_Connect(This.Builder);

      This.onlineList := Gtk_List_Store(This.Builder.Get_Object("onlinecontacts_list"));
      This.Window := Gtk_Window(This.Builder.Get_Object ("contact_window_client"));
      This.Window.Show_All;
   end Init;


   procedure Search_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Update_Status  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Add_Action  (Object : access Gtkada_Builder_Record'Class) is
   begin
      Put_Line("I'm the Add Menuitem. I would add a friend for you, if I knew how.");
   end Add_Action;

   procedure Offline_Contact_Action  (Object : access Gtkada_Builder_Record'Class) is
      --selection : Gtk_Tree_Selection;
      --selectedIter : Gtk_Tree_Iter;
      --selectedModel : Gtk_Tree_Model;
      --offlineList : Gtk_List_Store;
      dialog : aliased Gtk_Message_Dialog;
      ret : Gtk_Response_Type;
      empty : String := "";
   begin
      dialog := Gtk_Message_Dialog_New (Parent   => Instance.Window,
                                        Flags    => Destroy_With_Parent,
                                        The_Type => Message_Error,
                                        Buttons  => Buttons_Ok,
                                        Message  => "Offline messages aren't supported by the client yet",
                                        Arg5     => empty'Address);
      ret := Run(Gtk_Dialog(dialog));
      dialog.Destroy;

      --selection := Gtk_Tree_Selection(Object.Get_Object("Selected_Offline_Contact"));
      --selection.Get_Selected(selectedModel, selectedIter);
      --offlineList := Gtk_List_Store(Object.Get_Object("offlinecontacts_list"));
      --if ChatWindowOpen(offlineList.Get_String(selectedIter, 0)) = False then
      --   OpenNewChatWindow(Concrete_Client_Ui.Instance.Chat_Windows, Concrete_Client_Ui.Instance.UserName, To_Unbounded_String(offlineList.Get_String(selectedIter, 0)));
      --end if;
   end Offline_Contact_Action;

   procedure Online_Contact_Action  (Object : access Gtkada_Builder_Record'Class) is
      selection : Gtk_Tree_Selection;
      selectedIter : Gtk_Tree_Iter;
      selectedModel : Gtk_Tree_Model;
      onlineList : Gtk_List_Store;
      clickedName : Unbounded_String;
      normal : Gint := 400;
   begin
      selection := Gtk_Tree_Selection(Object.Get_Object("Selected_Online_Contact"));
      selection.Get_Selected(selectedModel, selectedIter);
      onlineList := Gtk_List_Store(Object.Get_Object("onlinecontacts_list"));
      clickedName := To_Unbounded_String(onlineList.Get_String(selectedIter, 0));
      if not Chat_Window_Manager.MyRooms.Contains(clickedName) then
         OpenNewChatWindow(Concrete_Client_Ui.Instance.Chat_Windows, Concrete_Client_Ui.Instance.UserName, clickedName);
         onlineList.Set(selectedIter, 1, normal);
      else
         if not MyWindows.Element(Chat_Window_Manager.MyRooms.Element(clickedName)).WindowOpen then
            OpenNewChatWindow(Concrete_Client_Ui.Instance.Chat_Windows, Concrete_Client_Ui.Instance.UserName, clickedName);
            onlineList.Set(selectedIter, 1, normal);
         end if;
      end if;
   end Online_Contact_Action;

   procedure Request_Action (Object : access Gtkada_Builder_Record'Class) is
      selection : Gtk_Tree_Selection;
      selectedIter : Gtk_Tree_Iter;
      selectedModel : Gtk_Tree_Model;
      requestsList : Gtk_List_Store;
      requestsFrame : Gtk_Frame;
      dialog : aliased Gtk_Message_Dialog;
      ret : Gtk_Response_Type;
      empty : String :="";
   begin
      selection := Gtk_Tree_Selection(Object.Get_Object("Selected_Contact_Request"));
      selection.Get_Selected(selectedModel, selectedIter);
      requestsList := Gtk_List_Store(Instance.Builder.Get_Object("requests_list"));
      requestsFrame := Gtk_Frame(Instance.Builder.Get_Object("contact_requests_frame"));
      dialog := Gtk_Message_Dialog_New (Parent   => Instance.Window,
                                        Flags    => Destroy_With_Parent,
                                        The_Type => Message_Question,
                                        Buttons  => Buttons_Yes_No,
                                        Message  => "Do you want to accept " & requestsList.Get_String(selectedIter, 0) & " as a contact?",
                                        Arg5     => empty'Address);
      ret := Run(Gtk_Dialog(dialog));
      if ret = Gtk_Response_Yes then
         Ada.Text_IO.Put_Line("TODO: Say Server I accept");
      else if ret = Gtk_Response_No then
         Ada.Text_IO.Put_Line("TODO: Say Server I decline");
      end if;
      end if;
      dialog.Destroy;
      requestsList.Remove(selectedIter);
      if Integer(requestsList.N_Children) <= 0 then
         requestsFrame.Set_Visible(False);
      end if;
   end Request_Action;

   procedure Groupchat_Action (Object : access Gtkada_Builder_Record'Class) is
      selection : Gtk_Tree_Selection;
      selectedIter : Gtk_Tree_Iter;
      selectedModel : Gtk_Tree_Model;
      groupchatList : Gtk_List_Store;
      clickedID : Gint;
      normal : Gint := 400;
   begin
      selection := Gtk_Tree_Selection(Object.Get_Object("treeview-selection3"));
      selection.Get_Selected(selectedModel, selectedIter);
      groupchatList := Gtk_List_Store(Object.Get_Object("groupchats_list"));
      clickedID := groupchatList.Get_Int(selectedIter, 1);
      if not MyWindows.Element(Natural(clickedID)).WindowOpen then
            OpenNewGroupChatWindow(Concrete_Client_Ui.Instance.Chat_Windows, Concrete_Client_Ui.Instance.UserName, To_Unbounded_String(groupchatList.Get_String(selectedIter, 0)), Natural(groupchatList.Get_Int(selectedIter, 1)));
            groupchatList.Set(selectedIter, 2, normal);
         end if;
   end Groupchat_Action;

   procedure Highlight(This : in out ContactWindow; sender : Unbounded_String) is
      onlineList : Gtk_List_Store;
      currentIter : Gtk_Tree_Iter;
      bold : Gint := 700;
   begin
      onlineList := Gtk_List_Store(This.Builder.Get_Object("onlinecontacts_list"));
      currentIter := onlineList.Get_Iter_First;
      while onlineList.Iter_Is_Valid(currentIter)
      loop
         if onlineList.Get_String(currentIter, 0) = sender then
            onlineList.Set(currentIter, 1, bold);
            return;
         end if;
         onlineList.Next(currentIter);
      end loop;
   end Highlight;

   procedure Highlight_Group(This : in out ContactWindow; receiver : Gint) is
      groupchatList : Gtk_List_Store;
      currentIter : Gtk_Tree_Iter;
      bold : Gint := 700;
   begin
      groupchatList := Gtk_List_Store(This.Builder.Get_Object("groupchats_list"));
      currentIter := groupchatList.Get_Iter_First;
      while groupchatList.Iter_Is_Valid(currentIter)
      loop
         if groupchatList.Get_Int(currentIter, 1) = receiver then
            groupchatList.Set(currentIter, 2, bold);
            return;
         end if;
         groupchatList.Next(currentIter);
      end loop;
   end Highlight_Group;

end Contact_Window;
