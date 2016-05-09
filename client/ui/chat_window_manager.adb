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

package body Chat_Window_Manager is

   task body ChatQueueReader is
      myWindow : ChatWindow_Ptr;
   begin
      accept Start (argWindow : in ChatWindow_Ptr) do
         myWindow := argWindow;
      end Start;
      begin
         while myWindow.Window /= null
         loop
            if not myWindow.Messages.Is_Empty then
               myWindow.printChatMessage(myWindow.DeQueueChatMessage);
            end if;
            delay 2.0;
         end loop;
      end;
   end ChatQueueReader;


   procedure OpenNewChatWindow(This : in out MapPtr; MyName: Unbounded_String; ChatName : Unbounded_String) is
      newWindow : ChatWindow_Ptr := new ChatWindow;
      newTask : ChatQueueReader_Ptr := new ChatQueueReader;
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
      newTask.Start(newWindow);
   end OpenNewChatWindow;

   procedure PrepareNewChatWindow(This : in out MapPtr; MyName: Unbounded_String; ChatID : Natural) is
      newWindow : ChatWindow_Ptr := new ChatWindow;
   begin
      newWindow.ChatID := ChatID;
      This.Insert(newWindow.ChatID, newWindow);
   end PrepareNewChatWindow;

   function ChatWindowOpen(ChatName : String) return Boolean is
   begin
      if MyRooms.Contains(To_Unbounded_String(ChatName)) then
         if MyWindows.Contains(MyRooms.Element(To_Unbounded_String(ChatName))) then
            if MyWindows.Element(MyRooms.Element(To_Unbounded_String(ChatName))).Window /= null then
               return true;
            end if;
         end if;
      end if;
      return false;
   end ChatWindowOpen;

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
         Handler_Name => "History_Action",
         Handler => History_Action'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Games_Action",
         Handler => Games_Action'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Smiley_Action",
         Handler => Smiley_Action'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Handle_Enter",
         Handler => Handle_Enter'Access);

      Do_Connect(This.Builder);

      This.Window := Gtk_Window(This.Builder.Get_Object ("chat_window_client"));
      This.UpdateParticipants;
      This.Window.Show_All;

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
         end loop;
      end if;
   end UpdateParticipants;


   procedure Check_RightClick  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Invite_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure History_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Games_Action  (Object : access Gtkada_Builder_Record'Class) is null;

   procedure Smiley_Action  (Object : access Gtkada_Builder_Record'Class) is
   begin
      null;
   end Smiley_Action;

   procedure Handle_Enter  (Object : access Gtkada_Builder_Record'Class) is
      message : Gtk_Entry;
      window : Gtk_Window;
   begin
      message := Gtk_Entry(Object.Get_Object("New_Message"));
      window := Gtk_Window(Object.Get_Object("chat_window_client"));
      Concrete_Client_Logic.Instance.SendMessageToChat(Receiver => MyRooms.Element(To_Unbounded_String(window.Get_Title)),
                                                       Username => MyUserName,
                                                       Message  => To_Unbounded_String(message.Get_Text));
      message.Set_Text("");
   end Handle_Enter;

   -----------------------------------------------------------------------------

   function Hash (R : Natural) return Hash_Type is
   begin
      return Hash_Type (R);
   end Hash;

   procedure EnQueueChatMessage(This : in out ChatWindow; message : MessageObject) is
   begin
      This.Messages.Prepend(message);
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
      messages.Get_Buffer.Insert(end_iter, ": ");
      messages.Get_Buffer.Insert(end_iter, To_String(message.content) & Ada.Characters.Latin_1.LF);
   end printChatMessage;

end Chat_Window_Manager;
