with Client2Gui_Communication; use Client2Gui_Communication;
with Protocol; use Protocol;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
--with Chat_Window_Manager; use Chat_Window_Manager;

limited with Concrete_Client_Logic;

package Concrete_Client_Ui is

   type Concrete_Client_Logic_Ptr is access all Concrete_Client_Logic.Concrete_Client;

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
      Client : Concrete_Client_Logic_Ptr;

   end record;

   --#Implementierung des Client2Gui_Communication interfaces
   procedure LoginSuccess(This : in Concrete_Ui);

   procedure LoginRefused(This : in Concrete_Ui; Reason : in Unbounded_String);

   procedure InitializeStatus(This : in Concrete_Ui; Status : in Unbounded_String);

   procedure DisconnectReason(This : in Concrete_Ui; Status : in Unbounded_String);

   -- Fügt den User der Online Liste hinzu und entfernt ihn aus der Offline Liste (falls vorhanden)
   procedure AddOnlineUser(This : in Concrete_Ui; UserName : Unbounded_String);

   -- Fügt den User der Offline Liste hinzu und entfernt ihn aus der Online Liste (falls vorhanden)
   procedure AddOfflineUser(This : in Concrete_Ui; UserName : Unbounded_String);
   --

   Instance : Concrete_Ui;
end Concrete_Client_Ui;
