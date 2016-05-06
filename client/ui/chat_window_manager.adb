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

   package Key_Press_Callbacks is new Gtk.Handlers.Return_Callback (Gtk_Entry_Record, Boolean);

   procedure OpenNewChatWindow(This : in out ChatWindows.List; ChatName : String) is
      newWindow : ChatWindow_Ptr := new ChatWindow;
   begin
      newWindow.Init;
      newWindow.Window.Set_Title(ChatName);
      This.Append(newWindow);
   end OpenNewChatWindow;

   function ChatWindowOpen(This : in out ChatWindows.List; ChatName : String) return Boolean is
   begin
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

      This.Window.Show_All;
   end Init;


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
   begin
      message := Gtk_Entry(Object.Get_Object("New_Message"));
      Ada.Text_IO.Put_Line(message.Get_Text);
      message.Set_Text("");
   end Handle_Enter;


end Chat_Window_Manager;
