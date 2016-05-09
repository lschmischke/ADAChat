with Ada.Text_IO;

with Gtk;              use Gtk;
with Gtk.Main;         use Gtk.Main;
with Gtk.Handlers;     use Gtk.Handlers;
with Gtk.GEntry;       use Gtk.GEntry;
with Glib.Error;       use Glib.Error;
with Gtk.Widget;       use Gtk.Widget;
with Gtk.Button;       use Gtk.Button;
with Gtkada.Builder;   use Gtkada.Builder;
with Glib;             use Glib;
with Glib.Error;       use Glib.Error;
with Gtk.Window;       use Gtk.Window;
with Gtk.Message_Dialog; use Gtk.Message_Dialog;
with Gtk.Dialog;       use Gtk.Dialog;
with Gtk.Tree_View;    use Gtk.Tree_View;
with Gtk.Tree_Selection; use Gtk.Tree_Selection;

with Contact_Window;

package body Chat_Window_Manager is

   procedure OpenNewChatWindow(This : in out MapPtr; MyName: Unbounded_String; ChatName : Unbounded_String) is
      newWindow : ChatWindow_Ptr := new ChatWindow;
   begin
      if not MyRooms.Contains(ChatName) then
         Concrete_Client_Logic.Instance.RequestChat(MyName, ChatName);
      end if;
      while not MyRooms.Contains(ChatName)
      loop
         null;
      end loop;
      if This.Contains(MyRooms.Element(ChatName)) then
         newWindow := This.Element(MyRooms.Element(ChatName));
      else
         newWindow.ChatID := MyRooms.Element(ChatName);
         This.Insert(newWindow.ChatID, newWindow);
      end if;
      newWindow.Init;
      newWindow.Window.Set_Title(To_String(ChatName));
      while not newWindow.Messages.Is_Empty
      loop
         newWindow.printChatMessage(newWindow.DeQueueChatMessage);
      end loop;
   end OpenNewChatWindow;

   procedure OpenNewGroupChatWindow(This : in out MapPtr; MyName: Unbounded_String; ChatName : Unbounded_String; ChatID : Natural) is
      newWindow : ChatWindow_Ptr := new ChatWindow;
   begin
      if This.Contains(ChatID) then
         newWindow := This.Element(ChatID);
      else
         newWindow.ChatID := ChatID;
         This.Insert(newWindow.ChatID, newWindow);
      end if;
      newWindow.Init;
      newWindow.Window.Set_Title(To_String(ChatName));
      while not newWindow.Messages.Is_Empty
      loop
         newWindow.printChatMessage(newWindow.DeQueueChatMessage);
      end loop;
   end OpenNewGroupChatWindow;

   procedure PrepareNewChatWindow(This : in out MapPtr; MyName: Unbounded_String; ChatID : Natural) is
      newWindow : ChatWindow_Ptr := new ChatWindow;
   begin
      newWindow.ChatID := ChatID;
      This.Insert(newWindow.ChatID, newWindow);
   end PrepareNewChatWindow;

   procedure Init (This : in out ChatWindow) is
      ret : GUint;
      Error : aliased GError;
   begin
      Gtk_New (This.Builder);
      ret := This.Builder.Add_From_File (GladeFile, Error'Access);

      if Error /= null then
         Ada.Text_IO.Put_Line(Get_Message(Error));
         Error_Free(Error);
         return;
      end if;

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Check_RightClick",
         Handler => Check_RightClick'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Invite_Action",
         Handler => Invite_Action'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Handle_Enter",
         Handler => Handle_Enter'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Chat_Window_Close",
         Handler => Chat_Window_Close'Access);

      Do_Connect(This.Builder);

      This.Window := Gtk_Window(This.Builder.Get_Object ("chat_window_client"));
      This.UpdateParticipants;
      This.Window.Show_All;
      This.WindowOpen := True;
   end Init;

   procedure UpdateParticipants (This : in out ChatWindow) is
      tempParticipant : Gtk_Tree_Iter;
      liststore : Gtk_List_Store;
   begin
      if This.Builder /= null then
         liststore := Gtk_List_Store(This.Builder.Get_Object("Participants"));
         liststore.Clear;
         for E of This.ChatParticipants
         loop
            liststore.Append(tempParticipant);
            liststore.Set(tempParticipant, 0, To_String(E));
            liststore.Set(tempParticipant, 1, Gint(This.ChatID));
         end loop;
      end if;
   end UpdateParticipants;


   procedure Check_RightClick  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Invite_Action  (Object : access Gtkada_Builder_Record'Class) is
      selection : Gtk_Tree_Selection;
      selectedIter : Gtk_Tree_Iter;
      selectedModel : Gtk_Tree_Model;
      cWindow : ChatWindow_Ptr;
      liststore : Gtk_List_Store;
      invitable : Gtk_List_Store;
      onlineList : Gtk_List_Store;
      dialog : aliased Gtk_Dialog;
      ret : Gtk_Response_Type;
      empty : String :="";
      selected : Unbounded_String;
      newItem : Gtk_Tree_Iter;
      currentIter : Gtk_Tree_Iter;
   begin
      liststore := Gtk_List_Store(Object.Get_Object("Participants"));
      cWindow := MyWindows.Element(Natural(liststore.Get_Int(liststore.Get_Iter_First, 1)));
      dialog := Gtk_Dialog(Object.Get_Object("dialog1"));
      invitable := Gtk_List_Store(Object.Get_Object("invitable_list"));
      onlineList := Contact_Window.Instance.onlineList;
      currentIter := onlineList.Get_Iter_First;
      while onlineList.Iter_Is_Valid(currentIter)
      loop
         invitable.Append(newItem);
         invitable.Set(newItem, 0, onlineList.Get_String(currentIter, 0));

         onlineList.Next(currentIter);
      end loop;
      ret := Run(dialog);
      if ret = Gtk_Response_OK then
         selection := Gtk_Tree_Selection(Object.Get_Object("treeview-selection"));
         selection.Get_Selected(selectedModel, selectedIter);
         selected := To_Unbounded_String(invitable.Get_String(selectedIter, 0));
         if selected /= "" then
            Concrete_Client_Logic.instance.inviteToGroupChat(MyUserName, cWindow.ChatID, selected);
         end if;
      end if;
      dialog.Hide;

   end Invite_Action;

   procedure Handle_Enter  (Object : access Gtkada_Builder_Record'Class) is
      message : Gtk_Entry;
      liststore : Gtk_List_Store;
   begin
      message := Gtk_Entry(Object.Get_Object("New_Message"));
      liststore := Gtk_List_Store(Object.Get_Object("Participants"));
      Concrete_Client_Logic.Instance.SendMessageToChat(Receiver => Natural(liststore.Get_Int(liststore.Get_Iter_First, 1)),
                                                       Username => MyUserName,
                                                       Message  => To_Unbounded_String(message.Get_Text));
      message.Set_Text("");
   end Handle_Enter;

   procedure Chat_Window_Close (Object : access Gtkada_Builder_Record'Class) is
      liststore : Gtk_List_Store;
   begin
      liststore := Gtk_List_Store(Object.Get_Object("Participants"));
      MyWindows.Element(Natural(liststore.Get_Int(liststore.Get_Iter_First, 1))).WindowOpen := False;
   end Chat_Window_Close;
   -----------------------------------------------------------------------------

   function Hash (R : Natural) return Hash_Type is
   begin
      return Hash_Type (R);
   end Hash;

   procedure EnQueueChatMessage(This : in out ChatWindow; message : MessageObject) is
   begin
      if This.WindowOpen then
         This.printChatMessage(message);
      else
         This.Messages.Prepend(message);
      end if;
   end EnQueueChatMessage;

   function DeQueueChatMessage (This : in out ChatWindow) return MessageObject is
      returnElement : MessageObject;
   begin
      returnElement := This.Messages.Last_Element;
      This.Messages.Delete_Last;
      return returnElement;
   end DeQueueChatMessage;

   procedure printChatMessage(This : in out ChatWindow; message : MessageObject) is
      messages : Gtk_Text_View;
      end_iter : Gtk_Text_Iter;
   begin
      messages := Gtk_Text_View(This.Builder.Get_Object("Messages"));
      messages.Get_Buffer.Get_End_Iter(end_iter);
      messages.Get_Buffer.Insert(end_iter, To_String(message.sender));
      messages.Get_Buffer.Get_End_Iter(end_iter);
      messages.Get_Buffer.Insert(end_iter, ": ");
      messages.Get_Buffer.Get_End_Iter(end_iter);
      messages.Get_Buffer.Insert(end_iter, To_String(message.content) & Ada.Characters.Latin_1.LF);
   end printChatMessage;

end Chat_Window_Manager;
