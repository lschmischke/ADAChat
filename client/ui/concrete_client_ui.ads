with Gtkada.Builder;   use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Client2Gui_Communication; use Client2Gui_Communication;
with Gui2Client_Communication; use Gui2Client_Communication;
with Protocol; use Protocol;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Login_Window; use Login_Window;
with Contact_Window; use Contact_Window;
with Concrete_Client_Logic; use Concrete_Client_Logic;
with Chat_Window_Manager; use Chat_Window_Manager;

package Concrete_Client_Ui is

   -----------------------------------------------------------------------------

   type Concrete_Ui is new Client2Gui_Communication.GUI with record
      UserName : Unbounded_String; -- Gesetzt nach dem Login
      Login_Window   : LoginWindow;
      Contact_Window   : WindowPtr;
      Chat_Windows : Chat_Window_Manager.MapPtr := Chat_Window_Manager.MyWindows;
      Client : ClientPtr;
   end record;

   type UiPtr is access all Concrete_Ui'Class;

   -----------------------------------------------------------------------------

   Instance : UiPtr;

   -----------------------------------------------------------------------------

   -- Callback für das Schließen des Login oder Kontakt Fensters
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Quit (Object : access Gtkada_Builder_Record'Class);

   -- Callback für den Button zum Registrieren
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Register_Action (Object : access Gtkada_Builder_Record'Class);
   
   -- Callback für den Button zum Einloggen
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Login_Action (Object : access Gtkada_Builder_Record'Class);

   -----------------------------------------------------------------------------

private

   -----------------------------------------------------------------------------

   -- Muss ausgeführt werden, bevor Concrete_Ui verwendet werden kann
   -- This => Objekt, das initialisiert werden soll
   -- Client_Instance => Zugehörige Client Logik
   procedure initClientUI(This : in out Concrete_Ui; Client_Instance : ClientPtr);

   -----------------------------------------------------------------------------

   -- Aktualisiert die Teilnehmer eines Chatraums
   -- This => Objekt der Client Ui Instanz
   -- Chatraum => ID des Chatraums, dessen Teilnehmer aktualisiert werden
   -- Participants => Neue Teilnehmer Liste
   procedure ShowChatParticipants(This : in out Concrete_Ui; Chatraum : in Natural; Participants : in Client2Gui_Communication.Userlist.Set);

   -----------------------------------------------------------------------------

   -- Zeigt eine eingegangene Nachricht
   -- This => Objekt der Client Ui Instanz
   -- message => Empfangene Nachricht
   procedure ShowChatMessages(This : in out Concrete_Ui; message : in MessageObject);
   
   -----------------------------------------------------------------------------

   -- Zeigt einen Fehlertext (rot) auf dem Login Fenster an
   -- This => Objekt der Client Ui Instanz
   -- message => Fehlermeldung
   procedure Error_Message(This : in out Concrete_Ui; message : String);

   -----------------------------------------------------------------------------

   -- Zeigt einen Infotext (blau) auf dem Login Fenster an
   -- This => Objekt der Client Ui Instanz
   -- message => Infomeldung
   procedure Info_Message(This : in out Concrete_Ui; message : String);

   -----------------------------------------------------------------------------
   -----------Implementierung des Client2Gui_Communication interfaces-----------
   -----------------------------------------------------------------------------
   procedure LoginSuccess(This : in out Concrete_Ui);
   procedure RefusedMessage(This : in out Concrete_Ui; Reason : in Unbounded_String);
   procedure DisconnectReason(This : in out Concrete_Ui; Status : in Unbounded_String);
   procedure SetOnlineUser(This : in out Concrete_Ui; Users : in Client2Gui_Communication.Userlist.Set);
   procedure SetOfflineUser(This : in out Concrete_Ui; Users : in Client2Gui_Communication.Userlist.Set);
   procedure ContactRequest(This : in out Concrete_Ui; Username : in Unbounded_String);
   procedure ContactRemove(This : in out Concrete_Ui; Username : in Unbounded_String);
   procedure UpdateChatRoomId(This : in out Concrete_Ui; ChatId : in  Natural; Name : in Unbounded_String);
   -----------------------------------------------------------------------------
   
end Concrete_Client_Ui;
