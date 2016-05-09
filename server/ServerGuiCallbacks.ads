with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Button; use Gtk.Button;

-- Hier befindet sich die Schnittstellenbeschreibung der Callbackfunktionen der GUI
package ServerGuiCallbacks is
   -- Diese Funktion wird aufgerufen, wenn die GUI �ber das 'X' geschlossen wird
   procedure Quit (Object : access Gtkada_Builder_Record'Class);
   -- Eine Funktion die ben�tigten Referenzen in CAllback Klasse zu setzen. Wird bei Serverstart aufgerufen.
   procedure InitializeGuiReferences(myBuilder: access Gtkada_Builder_Record'Class);
   -- Diese Funktion wird aufgerufen, wenn der "Server starten" Button gedr�ckt wird
   procedure clicked_button_server_start ( Object : access Gtkada_Builder_Record'Class);
   -- Diese Funktion wird aufgerufen, wenn der "Server stoppen" Button ged�rckt wird
   procedure clicked_button_server_stop ( Object : access Gtkada_Builder_Record'Class);
   -- Diese Funktion wird aufgerufen, wenn der "Benutzer kicken" Button gedr�ckt wird
   procedure kickSelectedUser (Object : access Gtkada_Builder_Record'Class);
   -- Diese Funktion wird aufgerufen, wenn der "Chatnachrichten l�schen" Knopf gedr�ckt wird
    procedure clearChat (Object : access Gtkada_Builder_Record'Class);
end ServerGuiCallbacks;
