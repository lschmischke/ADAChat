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
      UserName : Unbounded_String; -- Set after Login
      Login_Window   : LoginWindow;
      Contact_Window   : WindowPtr;
      Chat_Windows : ChatWindows.List;
      Client : ClientPtr;
   end record;

   type UiPtr is access all Concrete_Ui'Class;

   -----------------------------------------------------------------------------

   Instance : UiPtr;

   -----------------------------------------------------------------------------

   -- general callbacks
   procedure Quit (Object : access Gtkada_Builder_Record'Class);

   -- login window callbacks
   procedure Register_Action (Object : access Gtkada_Builder_Record'Class);
   procedure Login_Action (Object : access Gtkada_Builder_Record'Class);

   -----------------------------------------------------------------------------

private

   -----------------------------------------------------------------------------

   -- Must be called before using Concrete_Ui
   procedure initClientUI(This : in out Concrete_Ui; Client_Instance : ClientPtr);

   -----------------------------------------------------------------------------

   procedure ShowChatParticipants(This : in out Concrete_Ui; Chatraum : in Natural; Participants : in Client2Gui_Communication.Userlist.List);

   -----------------------------------------------------------------------------

   procedure ShowChatMessages(This : in out Concrete_Ui; message : in MessageObject);

   -----------------------------------------------------------------------------

   --#Implementierung des Client2Gui_Communication interfaces
   procedure LoginSuccess(This : in out Concrete_Ui);

   -----------------------------------------------------------------------------

   procedure RefusedMessage(This : in out Concrete_Ui; Reason : in Unbounded_String);

   -----------------------------------------------------------------------------

   procedure InitializeStatus(This : in Concrete_Ui; Status : in Unbounded_String);

   -----------------------------------------------------------------------------

   procedure DisconnectReason(This : in out Concrete_Ui; Status : in Unbounded_String);

   -----------------------------------------------------------------------------

   -- Fügt den User der Online Liste hinzu und entfernt ihn aus der Offline Liste (falls vorhanden)
   procedure SetOnlineUser(This : in out Concrete_Ui; Users : in Client2Gui_Communication.Userlist.List);

   -----------------------------------------------------------------------------

   -- Fügt den User der Offline Liste hinzu und entfernt ihn aus der Online Liste (falls vorhanden)
   procedure SetOfflineUser(This : in out Concrete_Ui; Users : in Client2Gui_Communication.Userlist.List);

   -----------------------------------------------------------------------------

   procedure ContactRequest(This : in out Concrete_Ui; Username : in Unbounded_String);

   -----------------------------------------------------------------------------

   procedure ContactRemove(This : in out Concrete_Ui; Username : in Unbounded_String);

   -----------------------------------------------------------------------------

   procedure Error_Message(This : in out Concrete_Ui; message : String);

   -----------------------------------------------------------------------------

   procedure Info_Message(This : in out Concrete_Ui; message : String);

   -----------------------------------------------------------------------------

end Concrete_Client_Ui;
