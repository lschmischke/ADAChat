with Protocol; use Protocol;
with dataTypes; use dataTypes;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Client2Gui_Communication is

   type GUI is interface;

   -- Fügt den User der Online Liste hinzu und entfernt ihn aus der Offline Liste (falls vorhanden)
   procedure AddOnlineUser(This : in GUI; UserName : Unbounded_String) is abstract;

   -- Fügt den User der Offline Liste hinzu und entfernt ihn aus der Online Liste (falls vorhanden)
   procedure AddOfflineUser(This : in GUI; UserName : Unbounded_String) is abstract;

   procedure ShowChatMessages(This : in GUI; message : MessageObject) is abstract;

end Client2Gui_Communication;
