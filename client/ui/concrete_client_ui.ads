with Client2Gui_Communication; use Client2Gui_Communication;
with Gui2Client_Communication; use Gui2Client_Communication;
with Protocol; use Protocol;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Concrete_Client_Logic; use Concrete_Client_Logic;
--with Chat_Window_Manager; use Chat_Window_Manager;

package Concrete_Client_Ui is

   type Concrete_Ui is new Client2Gui_Communication.GUI with private;

   -- Must be called before using Concrete_Ui
   procedure initClientUI(This : in out Concrete_Ui; Client_Instance : Concrete_Client_Logic.Concrete_Client);

   procedure showMessage;
   procedure setConnectionStatus;
   procedure updateChatParticipants;

   -- general callbacks
  -- procedure Quit (Object : access Gtkada_Builder_Record'Class);

   -- login window
--   procedure Register_Action (Object : access Gtkada_Builder_Record'Class);
 --  procedure Login_Action (Object : access Gtkada_Builder_Record'Class);

private

   type Concrete_Ui is new Client2Gui_Communication.GUI with record
  --    Login_Window   : LoginWindow;
   --   Contact_Window   : ContactWindow;
--      Chat_Windows : ChatWindows;
      Client : ClientPtr;

   end record;

   procedure ShowChatMessages(This : in Concrete_Ui; message : in MessageObject);

   --#Implementierung des Client2Gui_Communication interfaces
   procedure LoginSuccess(This : in Concrete_Ui);

   procedure RefusedMessage(This : in Concrete_Ui; Reason : in Unbounded_String);

   procedure InitializeStatus(This : in Concrete_Ui; Status : in Unbounded_String);

   procedure DisconnectReason(This : in Concrete_Ui; Status : in Unbounded_String);

   -- Fügt den User der Online Liste hinzu und entfernt ihn aus der Offline Liste (falls vorhanden)
   procedure SetOnlineUser(This : in Concrete_Ui; Users : in Client2Gui_Communication.Userlist.Set);

   -- Fügt den User der Offline Liste hinzu und entfernt ihn aus der Online Liste (falls vorhanden)
   procedure SetOfflineUser(This : in Concrete_Ui; Users : in Client2Gui_Communication.Userlist.Set);
   --

   Instance : Concrete_Ui;
end Concrete_Client_Ui;
