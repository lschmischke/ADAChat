with Gtk.Builder; use Gtk.Builder;
with Client2Gui_Communication; use Client2Gui_Communication;
with Gui2Client_Communication; use Gui2Client_Communication;

package Client_Window is

   type Window is interface;

   -- Must be called before Window can be used
   procedure Init(This : in out Window) is abstract;

end Client_Window;
