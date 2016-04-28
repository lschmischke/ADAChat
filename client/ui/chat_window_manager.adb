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
with General_Callbacks; use General_Callbacks;
with Main_Window_Callbacks; use Main_Window_Callbacks;
with Contact_Window_Callbacks; use Contact_Window_Callbacks;
with Chat_Window_Callbacks; use Chat_Window_Callbacks;

package body Chat_Window_Manager is

   package Key_Press_Callbacks is new Gtk.Handlers.Return_Callback (Gtk_Entry_Record, Boolean);

   procedure test is
      Chat_Window : Gtk_Window;
      Builder : Gtkada_Builder;
      ret : GUint;
      Error : aliased GError;
   begin
      Gtk_New (Builder);
      ret := Builder.Add_From_File ("Chat_Window.glade", Error'Access);

      if Error /= null then
         Ada.Text_IO.Put_Line(Get_Message(Error));
         Error_Free(Error);
         return;
      end if;

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Check_RightClick",
         Handler => Chat_Window_Callbacks.Check_RightClick'Access);

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Invite_Action",
         Handler => Chat_Window_Callbacks.Invite_Action'Access);

      Register_Handler
        (Builder => Builder,
         Handler_Name => "History_Action",
         Handler => Chat_Window_Callbacks.History_Action'Access);

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Games_Action",
         Handler => Chat_Window_Callbacks.Games_Action'Access);

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Smiley_Action",
         Handler => Chat_Window_Callbacks.Smiley_Action'Access);

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Handle_Enter",
         Handler => Chat_Window_Callbacks.Handle_Enter'Access);

      Do_Connect(Builder);

      Chat_Window := Gtk_Window(Builder.Get_Object ("chat_window_client"));

      Chat_Window.Show_All;
   end test;

end Chat_Window_Manager;
