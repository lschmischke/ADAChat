with Protocol; use Protocol;
with dataTypes; use dataTypes;
with Ada.Containers.Hashed_Sets;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Client2Gui_Communication is

   type GUI is interface;
   type GUIPtr is access all GUI'Class;

   package Userlist is new Ada.Containers.Hashed_Sets(Element_Type        => Unbounded_String,
                                                      Hash                => Ada.Strings.Unbounded.Hash_Case_Insensitive,
                                                      Equivalent_Elements => "=",
                                                      "="                 => Ada.Strings.Unbounded."=");

   procedure ShowChatMessages(This : in GUI; message : in MessageObject) is abstract;

   procedure LoginSuccess(This : in GUI) is abstract;

   procedure RefusedMessage(This : in GUI; Reason : in Unbounded_String) is abstract;

   procedure InitializeStatus(This : in GUI; Status : in Unbounded_String) is abstract;

   procedure DisconnectReason(This : in GUI; Status : in Unbounded_String) is abstract;

   -- Fügt den User der Online Liste hinzu und entfernt ihn aus der Offline Liste (falls vorhanden)
   procedure SetOnlineUser(This : in GUI; Users : in Client2Gui_Communication.Userlist.Set) is abstract;

   -- Fügt den User der Offline Liste hinzu und entfernt ihn aus der Online Liste (falls vorhanden)
   procedure SetOfflineUser(This : in GUI; Users : in Client2Gui_Communication.Userlist.Set) is abstract;

end Client2Gui_Communication;
