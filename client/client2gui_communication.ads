with Protocol; use Protocol;
with dataTypes; use dataTypes;

package Client2Gui_Communication is

   type GUI is interface;

   -- F�gt den User der Online Liste hinzu und entfernt ihn aus der Offline Liste (falls vorhanden)
   procedure AddOnlineUser(This : in GUI; UserName : Unbounded_String) is abstract;

   -- F�gt den User der Offline Liste hinzu und entfernt ihn aus der Online Liste (falls vorhanden)
   procedure UpdateOfflineUsers(This : in GUI; UserName : Unbounded_String) is abstract;

   procedure ShowChatMessages(This : in GUI; message : Message_Object) is abstract;

end Client2Gui_Communication;
