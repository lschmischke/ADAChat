--Interface Client zu Gui Kommunikation

--Includes
with Protocol; use Protocol;
with dataTypes; use dataTypes;
with Ada.Containers.Hashed_Sets;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with Ada.Containers.Hashed_Sets;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

limited with Gui2Client_Communication;

package Client2Gui_Communication is

   type GUI is interface;
   type GUIPtr is access all GUI'Class;

   --Typdefinition zur Userlist
<<<<<<< HEAD
   --package Userlist is new Ada.Containers.Doubly_Linked_Lists(Element_Type        => Unbounded_String);
   package Userlist is new Ada.Containers.Hashed_Sets(Element_Type        => Unbounded_String,
                                                      Hash                => Ada.Strings.Unbounded.Hash_Case_Insensitive,
                                                      Equivalent_Elements => "=",
=======
   package Userlist is new Ada.Containers.Hashed_Sets(Element_Type        => Unbounded_String,
                                                     Hash                => Ada.Strings.Unbounded.Hash_Case_Insensitive,
                                                     Equivalent_Elements => "=",
>>>>>>> origin/feature/Client_Logic
                                                      "="                 => Ada.Strings.Unbounded."=");

   -- Registriert bzw. referenziert den Client bei der GUI.
   -- Client_Instance => Referenz der Client-Logik
   procedure initClientUI(This : in out GUI; Client_Instance : Gui2Client_Communication.ClientPtr) is abstract;

   -- Zeigt die empfangene Chatnachricht.
   -- message => Nachricht
   procedure ShowChatMessages(This : in out GUI; message : in MessageObject) is abstract;

   -- Teilt der GUI mit, dass ein erfolgreicher Login stattgefunden hat.
   procedure LoginSuccess(This : in out GUI) is abstract;

   -- Teilt der GUI mit, dass eine Refused-Message empfangen wurde.
   -- Reason => Grund der Nachricht
   procedure RefusedMessage(This : in out GUI; Reason : in Unbounded_String) is abstract;

   -- Teilt der GUI mit, dass die Verbindung zum Server beendet wurde.
   -- Status => Grund des Disconnects
   procedure DisconnectReason(This : in out GUI; Status : in Unbounded_String) is abstract;

   -- Zeigt die aktuellen Chat-Teilnehmer eines Raumes.
   -- Chatraum => ID des Chatraums
   -- Participants => Liste der Teilnehmer im Chatraum
   procedure ShowChatParticipants(This : in out GUI; Chatraum : in Natural; Participants : in Client2Gui_Communication.Userlist.Set) is abstract;

   -- Fuegt den angegebenen User der Offline Liste hinzu.
   -- Users => Liste der Online User
   procedure SetOnlineUser(This : in out GUI; Users : in Client2Gui_Communication.Userlist.Set) is abstract;

   -- Fuegt den angegebenen User der Online Liste hinzu.
   -- Users => Liste des Offline User
   procedure SetOfflineUser(This : in out GUI; Users : in Client2Gui_Communication.Userlist.Set) is abstract;

   -- Stellt eine Kontaktanfrage an einen User.
   -- Username => Name des anzufragenden Users
   procedure ContactRequest(This : in out GUI; Username : in Unbounded_String) is abstract;

   -- Entfernt den angegebenen User aus der Kontaktliste.
   -- Username => Name des zu entfernenden Users
   procedure ContactRemove(This : in out GUI; Username : in Unbounded_String) is abstract;


   -- Uebermittelt der GUI von dem geforderten Chatrequest die Id
   -- ChatId => Id des Chatraums
   -- Name => Name des angeforderten Chatpartners
   procedure UpdateChatRoomId(ChatId => MsgObject.Receiver, Name => MsgObject.Content) is abstract;

end Client2Gui_Communication;
