with Ada.Text_IO; use Ada.Text_IO;

with Glib; use Glib;
with Glib.Error; use Glib.Error;

with Gtkada.Builder; use Gtkada.Builder;

with Concrete_Client_Ui;

with System;
with Glib;
with Gtk.Main;
with Gtk.List_Store; use Gtk.List_Store;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Tree_Model; use Gtk.Tree_Model;
with Gtk.Tree_Selection; use Gtk.Tree_Selection;
with Gtk.Message_Dialog; use Gtk.Message_Dialog;
with Gtk.Dialog; use Gtk.Dialog;
with Gtk; use Gtk;
with Concrete_Client_Ui; use Concrete_Client_Ui;
with Chat_Window_Manager; use Chat_Window_Manager;


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
      normal : Gint := 400;
   begin
      selection := Gtk_Tree_Selection(Object.Get_Object("Selected_Online_Contact"));
      selection.Get_Selected(selectedModel, selectedIter);
      onlineList := Gtk_List_Store(Object.Get_Object("onlinecontacts_list"));
      if not ChatWindowOpen(onlineList.Get_String(selectedIter, 0)) then
         OpenNewChatWindow(Concrete_Client_Ui.Instance.Chat_Windows, Concrete_Client_Ui.Instance.UserName, To_Unbounded_String(onlineList.Get_String(selectedIter, 0)));
         onlineList.Set(selectedIter, 1, normal);
      end if;
   end Online_Contact_Action;

   procedure Request_Action (Object : access Gtkada_Builder_Record'Class) is
      selection : Gtk_Tree_Selection;
      selectedIter : Gtk_Tree_Iter;
      selectedModel : Gtk_Tree_Model;
      requestsList : Gtk_List_Store;
      dialog : aliased Gtk_Message_Dialog;
      ret : Gtk_Response_Type;
   begin
      selection := Gtk_Tree_Selection(Object.Get_Object("Selected_Contact_Request"));
      selection.Get_Selected(selectedModel, selectedIter);
      requestsList := Gtk_List_Store(Instance.Builder.Get_Object("requests_list"));
      dialog := Gtk_Message_Dialog_New (Parent   => Instance.Window,
                                        Flags    => Destroy_With_Parent,
                                        The_Type => Message_Question,
                                        Buttons  => Buttons_Yes_No,
                                        Message  => "Do you want to accept %s as a contact?",
                                        Arg5     => requestsList.Get_String(selectedIter, 0)'Address);
      ret := Run(Gtk_Dialog(dialog));
      if ret = Gtk_Response_Yes then
         Ada.Text_IO.Put_Line("TODO: Say Server I accept");
      else if ret = Gtk_Response_No then
         Ada.Text_IO.Put_Line("TODO: Say Server I decline");
      end if;
      end if;
      dialog.Destroy;
   end Request_Action;

   procedure Groupchat_Action (Object : access Gtkada_Builder_Record'Class) is null;

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

end Contact_Window;
