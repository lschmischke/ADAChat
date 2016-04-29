with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Client_Window;
with Client2Gui_Communication; use Client2Gui_Communication;
with Gui2Client_Communication; use Gui2Client_Communication;
--limited with Concrete_Client_Logic;

package Login_Window is

   --type Client_Ptr is access all Concrete_Client_Logic.Concrete_Client;
   type LoginWindow is new Client_Window.Window with record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
      Client : ClientPtr;
   end record;
   GladeFile : constant String := "Login_Window.glade";

private

   procedure Init (This : in out LoginWindow; Client_Instance : ClientPtr);

   Instance : LoginWindow;

end Login_Window;
