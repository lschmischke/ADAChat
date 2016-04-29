with Gtk.Builder; use Gtk.Builder;
with Concrete_Client_Logic;

package Client_Window is

   type Window is interface;

   -- Must be called before Window can be used
   procedure Init(This : in out Window; Client_Instance : Concrete_Client_Logic.Concrete_Client) is abstract;

end Client_Window;
