with Protocol; use Protocol;
with dataTypes; use dataTypes;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Client2Gui_Communication is

   type GUI is interface;

--   procedure ShowChatMessages(This : in GUI; message : Message_Object) is abstract;
   procedure LoginSuccess(This : in GUI) is abstract;

   procedure LoginRefused(This : in GUI; Reason : in Unbounded_String) is abstract;

   procedure InitializeStatus(This : in GUI; Status : in Unbounded_String) is abstract;

   procedure DisconnectReason(This : in GUI; Status : in Unbounded_String) is abstract;

   -- Fügt den User der Online Liste hinzu und entfernt ihn aus der Offline Liste (falls vorhanden)
   procedure AddOnlineUser(This : in GUI; UserName : Unbounded_String) is abstract;

   -- Fügt den User der Offline Liste hinzu und entfernt ihn aus der Online Liste (falls vorhanden)
   procedure AddOfflineUser(This : in GUI; UserName : Unbounded_String) is abstract;

end Client2Gui_Communication;
