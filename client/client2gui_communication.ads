--Interface Client zu Gui Kommunikation

--Includes
with Protocol; use Protocol;
with dataTypes; use dataTypes;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with Ada.Containers.Hashed_Sets;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

limited with Gui2Client_Communication;

package Client2Gui_Communication is

   type GUI is interface;
   type GUIPtr is access all GUI'Class;

   --Typdefinition zur Userlist
   package Userlist is new Ada.Containers.Hashed_Sets(Element_Type        => Unbounded_String,
                                                     Hash                => Ada.Strings.Unbounded.Hash_Case_Insensitive,
                                                     Equivalent_Elements => "=",
                                                      "="                 => Ada.Strings.Unbounded."=");

   -- Registriert bzw. referenziert den Client bei der GUI.
   -- Client_Instance => Referenz der Client-Logik
   procedure initClientUI(this : in out GUI; client_instance : Gui2Client_Communication.ClientPtr) is abstract;

   -- Zeigt die empfangene Chatnachricht.
   -- Message => Nachricht
   procedure showChatMessages(This : in out GUI; message : in MessageObject) is abstract;

   -- Teilt der GUI mit, dass ein erfolgreicher Login stattgefunden hat.
   procedure loginSuccess(This : in out GUI) is abstract;

   -- Teilt der GUI mit, dass eine Refused-Message empfangen wurde.
   -- Reason => Grund der Nachricht
   procedure refusedMessage(this : in out GUI; reason : in Unbounded_String) is abstract;

   -- Teilt der GUI mit, dass die Verbindung zum Server beendet wurde.
   -- Status => Grund des Disconnects
   procedure disconnectReason(this : in out GUI; status : in Unbounded_String) is abstract;

   -- Zeigt die aktuellen Chat-Teilnehmer eines Raumes.
   -- Chatraum => ID des Chatraums
   -- Participants => Liste der Teilnehmer im Chatraum
   procedure showChatParticipants(this : in out GUI; chatraum : in Natural; participants : in Client2Gui_Communication.Userlist.Set) is abstract;

   -- Fuegt den angegebenen User der Offline Liste hinzu.
   -- Users => Liste der Online User
   procedure setOnlineUser(this : in out GUI; users : in Client2Gui_Communication.Userlist.Set) is abstract;

   -- Fuegt den angegebenen User der Online Liste hinzu.
   -- Users => Liste des Offline User
   procedure setOfflineUser(this : in out GUI; users : in Client2Gui_Communication.Userlist.Set) is abstract;

   -- Stellt eine Kontaktanfrage an einen User.
   -- Username => Name des anzufragenden Users
   procedure contactRequest(this : in out GUI; username : in Unbounded_String) is abstract;

   -- Entfernt den angegebenen User aus der Kontaktliste.
   -- Username => Name des zu entfernenden Users
   procedure contactRemove(this : in out GUI; username : in Unbounded_String) is abstract;

   -- Uebermittelt der GUI von dem geforderten Chatrequest die Id
   -- ChatId => Id des Chatraums
   -- Name => Name des angeforderten Chatpartners
   procedure updateChatRoomId(this : in out GUI; chatId : in  Natural; name : in Unbounded_String) is abstract;

end Client2Gui_Communication;
