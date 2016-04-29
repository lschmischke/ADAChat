with Ada.Text_IO; use Ada.Text_IO;

with Glib; use Glib;
with Glib.Error; use Glib.Error;

with Gtkada.Builder; use Gtkada.Builder;

with Concrete_Client_Ui;

with Contact_Window; use Contact_Window;

with Gtk.Main;
with Gtk.GEntry; use Gtk.GEntry;
with Gtk.List_Store; use Gtk.List_Store;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Tree_Model; use Gtk.Tree_Model;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.Sockets; use GNAT.Sockets;
with Protocol; use Protocol;

package body Login_Window is

   procedure Init (This : in out LoginWindow; Client_Instance : ClientPtr) is
      ret : GUint;
      Error : aliased GError;
      newBuilder : Gtkada_Builder;
   begin
      This.Client := Client_Instance;
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
         Handler => Concrete_Client_Ui.Quit'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Register_Action",
         Handler => Concrete_Client_Ui.Register_Action'Access);

      Register_Handler
        (Builder => This.Builder,
         Handler_Name => "Login_Action",
         Handler => Concrete_Client_Ui.Login_Action'Access);

      Do_Connect(This.Builder);

      This.Window := Gtk_Window(This.Builder.Get_Object ("login_window_client"));
      This.Window.Show_All;
      Instance := This;
   end Init;

end Login_Window;
