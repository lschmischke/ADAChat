with Gtk.Builder; use Gtk.Builder;
limited with Concrete_Client_Logic;

package Client_Window is

   type Client_Ptr is access all Concrete_Client_Logic.Concrete_Client;
   type Window is interface;

   -- Must be called before Window can be used
   procedure Init(This : in out Window; Client_Instance : Client_Ptr) is abstract;

end Client_Window;
