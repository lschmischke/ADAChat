with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Client_Window;
with Concrete_Client_Logic;

package Login_Window is

   type LoginWindow is new Client_Window.Window with record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
      Client : Concrete_Client_Logic.Concrete_Client;
   end record;
   GladeFile : constant String := "Login_Window.glade";

private

   procedure Init (This : in out LoginWindow; Client_Instance : Concrete_Client_Logic.Concrete_Client);

   Instance : LoginWindow;

end Login_Window;
