with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Button; use Gtk.Button;

-- Hier befindet sich die Schnittstellenbeschreibung der Callbackfunktionen der GUI
package ServerGuiCallbacks is
   -- Diese Funktion wird aufgerufen, wenn die GUI über das 'X' geschlossen wird
   procedure Quit (Object : access Gtkada_Builder_Record'Class);
   -- Eine Funktion die benötigten Referenzen in CAllback Klasse zu setzen. Wird bei Serverstart aufgerufen.
   procedure InitializeGuiReferences(myBuilder: access Gtkada_Builder_Record'Class);
   -- Diese Funktion wird aufgerufen, wenn der "Server starten" Button gedrückt wird
   procedure clicked_button_server_start ( Object : access Gtkada_Builder_Record'Class);
   -- Diese Funktion wird aufgerufen, wenn der "Server stoppen" Button gedürckt wird
   procedure clicked_button_server_stop ( Object : access Gtkada_Builder_Record'Class);
   -- Diese Funktion wird aufgerufen, wenn der "Benutzer kicken" Button gedrückt wird
   procedure kickSelectedUser (Object : access Gtkada_Builder_Record'Class);
   -- Diese Funktion wird aufgerufen, wenn der "Chatnachrichten löschen" Knopf gedrückt wird
    procedure clearChat (Object : access Gtkada_Builder_Record'Class);
end ServerGuiCallbacks;
