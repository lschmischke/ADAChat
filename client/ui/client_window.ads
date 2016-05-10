--Interface für Fenster auf Client Seite

with Gtk.Builder; use Gtk.Builder;
with Client2Gui_Communication; use Client2Gui_Communication;
with Gui2Client_Communication; use Gui2Client_Communication;

package Client_Window is

   type Window is interface;

   -- Muss ausgeführt werden, bevor Window verwendet werden kann
   -- This => Fenster, das initialisiert werden soll
   procedure Init(This : in out Window) is abstract;

end Client_Window;
