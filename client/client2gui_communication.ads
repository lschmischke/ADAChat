with Protocol; use Protocol;
with dataTypes; use dataTypes;
with Ada.Containers.Hashed_Sets;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

limited with Gui2Client_Communication;

package Client2Gui_Communication is

   type GUI is interface;
   type GUIPtr is access all GUI'Class;


   package Userlist is new Ada.Containers.Hashed_Sets(Element_Type        => Unbounded_String,
                                                      Hash                => Ada.Strings.Unbounded.Hash_Case_Insensitive,
                                                      Equivalent_Elements => "=",
                                                      "="                 => Ada.Strings.Unbounded."=");

   procedure initClientUI(This : in out GUI; Client_Instance : Gui2Client_Communication.ClientPtr) is abstract;

   procedure ShowChatMessages(This : in out GUI; message : in MessageObject) is abstract;

   procedure LoginSuccess(This : in out GUI) is abstract;

   procedure RefusedMessage(This : in out GUI; Reason : in Unbounded_String) is abstract;

   procedure DisconnectReason(This : in out GUI; Status : in Unbounded_String) is abstract;

   procedure ShowChatParticipants(This : in out GUI; Chatraum : in Natural; Participants : in Client2Gui_Communication.Userlist.Set) is abstract;

   -- Fügt den User der Online Liste hinzu und entfernt ihn aus der Offline Liste (falls vorhanden)
   procedure SetOnlineUser(This : in out GUI; Users : in Client2Gui_Communication.Userlist.Set) is abstract;

   -- Fügt den User der Offline Liste hinzu und entfernt ihn aus der Online Liste (falls vorhanden)
   procedure SetOfflineUser(This : in out GUI; Users : in Client2Gui_Communication.Userlist.Set) is abstract;

   procedure ContactRequest(This : in out GUI; Username : in Unbounded_String) is abstract;

   procedure ContactRemove(This : in out GUI; Username : in Unbounded_String) is abstract;

end Client2Gui_Communication;
