with Gtkada.Builder;   use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Concrete_Client_Logic; use Concrete_Client_Logic;

package Client_Ui is
   Builder : Gtkada_Builder;
   Main_Window   : Gtk_Window;
   Contact_Window   : Gtk_Window;
   Client : Concrete_Client_Logic.Concrete_Client;
   procedure showMessage;
   procedure setConnectionStatus;
   procedure updateChatParticipants;
   procedure initClientUI(Client_Instance : Concrete_Client_Logic.Concrete_Client);
end Client_Ui;
