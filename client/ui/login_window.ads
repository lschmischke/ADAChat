with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Client_Window;
with Client2Gui_Communication; use Client2Gui_Communication;
with Gui2Client_Communication; use Gui2Client_Communication;
--limited with Concrete_Client_Logic;

package Login_Window is

   type LoginWindow is new Client_Window.Window with record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
   end record;
   
   --#GladeFile aus der das Fenster generiert wird
   GladeFile : constant String := "client/Login_Window.glade";

private

   -- Muss ausgeführt werden, bevor Window verwendet werden kann
   -- This => Fenster, das initialisiert werden soll
   procedure Init (This : in out LoginWindow);

   Instance : LoginWindow;

end Login_Window;
