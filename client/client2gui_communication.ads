with Protocol; use Protocol;
with dataTypes; use dataTypes;
<<<<<<< HEAD
=======
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
>>>>>>> origin/feature/Client_GUI

package Client2Gui_Communication is

   type GUI is interface;

   -- Fügt den User der Online Liste hinzu und entfernt ihn aus der Offline Liste (falls vorhanden)
   procedure AddOnlineUser(This : in GUI; UserName : Unbounded_String) is abstract;
<<<<<<< HEAD

   -- Fügt den User der Offline Liste hinzu und entfernt ihn aus der Online Liste (falls vorhanden)
   procedure UpdateOfflineUsers(This : in GUI; UserName : Unbounded_String) is abstract;

   procedure ShowChatMessages(This : in GUI; message : Message_Object) is abstract;

   procedure LoginSuccess(This : in GUI) is abstract;

   procedure LoginRefused(This : in GUI; Reason : in Unbounded_String) is abstract;

   procedure InitializeStatus(This : in GUI; Status : in Unbounded_String) is abstract;

   procedure DisconnectReason(This : in GUI; Status : in Unbounded_String is abstract);
=======

   -- Fügt den User der Offline Liste hinzu und entfernt ihn aus der Online Liste (falls vorhanden)
   procedure AddOfflineUser(This : in GUI; UserName : Unbounded_String) is abstract;

   procedure ShowChatMessages(This : in GUI; message : MessageObject) is abstract;
>>>>>>> origin/feature/Client_GUI

end Client2Gui_Communication;
