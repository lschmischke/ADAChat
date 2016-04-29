with Gtkada.Builder;   use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
limited with Concrete_Client_Logic;
with Client2Gui_Communication; use Client2Gui_Communication;
with Protocol; use Protocol;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Client_Window;
with Login_Window; use Login_Window;
with Contact_Window; use Contact_Window;
--with Chat_Window_Manager; use Chat_Window_Manager;

package Concrete_Client_Ui is

   type Concrete_Ui is new Client2Gui_Communication.GUI with private;

   -- Must be called before using Concrete_Ui
   procedure initClientUI(This : in out Concrete_Ui; Client_Instance : Client_Window.Client_Ptr);

   procedure showMessage;
   procedure setConnectionStatus;
   procedure updateChatParticipants;

   -- general callbacks
   procedure Quit (Object : access Gtkada_Builder_Record'Class);

   -- login window callbacks
   procedure Register_Action (Object : access Gtkada_Builder_Record'Class);
   procedure Login_Action (Object : access Gtkada_Builder_Record'Class);

private

   type Concrete_Ui is new Client2Gui_Communication.GUI with record
      Login_Window   : LoginWindow;
      Contact_Window   : ContactWindow;
--      Chat_Windows : ChatWindows;
      Client : Client_Window.Client_Ptr;
   end record;

   --#Implementierung des Client2Gui_Communication interfaces
   procedure AddOnlineUser(This : in Concrete_Ui; UserName : Unbounded_String);
   procedure AddOfflineUser(This : in Concrete_Ui; UserName : Unbounded_String);
   procedure ShowChatMessages(This : in Concrete_Ui; message : MessageObject);
   --

   Instance : aliased Concrete_Ui;
end Concrete_Client_Ui;
