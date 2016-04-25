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
with General_Callbacks; use General_Callbacks;
with Main_Window_Callbacks; use Main_Window_Callbacks;
with Contact_Window_Callbacks; use Contact_Window_Callbacks;
with Chat_Window_Callbacks; use Chat_Window_Callbacks;

package body Client_Ui is

   procedure showMessage is null;
   procedure setConnectionStatus is null;
   procedure updateChatParticipants is null;

   procedure initClientUI(Client_Instance : Concrete_Client_Logic.Concrete_Client) is
      ret : GUint;
      Error : aliased GError;

   begin
      Client := Client_Instance;
      --  Initialize GtkAda.
      Gtk.Main.Init;

      Gtk_New (Builder);
      ret := Builder.Add_From_File ("Client_GUI.glade", Error'Access);

      if Error /= null then
         Ada.Text_IO.Put_Line(Get_Message(Error));
         Error_Free(Error);
         return;
      end if;

      --Main_Window_Callbacks.Init;

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Main_Quit",
         Handler => General_Callbacks.Quit'Access);

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Register_Action",
         Handler => Main_Window_Callbacks.Register_Action'Access);

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Login_Action",
         Handler => Main_Window_Callbacks.Login_Action'Access);

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Search_Action",
         Handler => Contact_Window_Callbacks.Search_Action'Access);

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Update_Status",
         Handler => Contact_Window_Callbacks.Update_Status'Access);

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Add_Action",
         Handler => Contact_Window_Callbacks.Add_Action'Access);

      Register_Handler
        (Builder => Builder,
         Handler_Name => "Contact_Action",
         Handler => Contact_Window_Callbacks.Contact_Action'Access);

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

      Do_Connect(Builder);

      Main_Window := Gtk_Window(Builder.Get_Object ("main_window_client"));
      Contact_Window := Gtk_Window(Builder.Get_Object ("contact_window_client"));

      Main_Window.Show_All;


      --  Start the Gtk+ main loop
      Gtk.Main.Main;
      Unref(Builder);
   end initClientUI;

end Client_Ui;
