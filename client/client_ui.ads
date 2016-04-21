with Gtkada.Builder;   use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;

package Client_Ui is
   Builder : Gtkada_Builder;
   Main_Window   : Gtk_Window;
   Contact_Window   : Gtk_Window;
   procedure showMessage;
   procedure setConnectionStatus;
   procedure updateChatParticipants;
   procedure initClientUI;
end Client_Ui;
