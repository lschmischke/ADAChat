with Ada.Characters.Latin_1;     use Ada.Characters.Latin_1;

with Gtkada.Builder;   use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Gtk.List_Store;   use Gtk.List_Store;
with Concrete_Client_Logic;
with Client_Window;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Containers; use Ada.Containers;
with Protocol; use Protocol;
with Gtk.Text_View;      use Gtk.Text_View;
with Gtk.Text_Iter;      use Gtk.Text_Iter;
with Gtk.Tree_Model;     use Gtk.Tree_Model;


package Chat_Window_Manager is

   --#GladeFile aus der das Fenster generiert wird
   GladeFile : constant String := "client/Chat_Window.glade";

   function Hash (R : Natural) return Hash_Type;

   package PrivateChatRooms is new Ada.Containers.Indefinite_Hashed_Maps(Key_Type        => Unbounded_String,
                                                                         Element_Type    => Natural,
                                                                         Hash            => Ada.Strings.Unbounded.Hash_Case_Insensitive,
                                                                         Equivalent_Keys => "=",
                                                                         "="             => "=");

   package ChatMessages is new Ada.Containers.Doubly_Linked_Lists(Element_Type => MessageObject);

   package GroupChatRooms is new Ada.Containers.Doubly_Linked_Lists(Element_Type => Natural);

   package Participants is new Ada.Containers.Doubly_Linked_Lists(Element_Type => Unbounded_String);

   type ChatWindow is new Client_Window.Window with record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
      ChatID : Natural;
      ChatName : Unbounded_String;
      ChatParticipants : Participants.List;
      Messages : ChatMessages.List;
      WindowOpen : Boolean := False;
   end record;

   type ChatWindow_Ptr is access ChatWindow;

   -- Aktualisiert die angezeigte Liste der Teilnehmer in dem Chat
   -- This => Fenster, in dem die Liste aktualisiert werden soll
   procedure UpdateParticipants (This : in out ChatWindow);

   package ChatWindows is new Ada.Containers.Indefinite_Hashed_Maps(Key_Type        => Natural,
                                                                    Element_Type    => ChatWindow_Ptr,
                                                                    Hash            => Hash,
                                                                    Equivalent_Keys => "=",
                                                                    "="             => "=");
   type MapPtr is access all ChatWindows.Map'Class;

   -- Öffnet ein Chat Fenster für einen Kontakt, sendet einen Chatrequest, falls noch kein Chatraum mit dem Nutzer besteht
   -- This => Map, in der das neue Fenster abgelegt werden soll
   -- MyName => Name des eingeloggten Nutzers
   -- ChatName => Name des Kontakts, mit dem gechattet werden soll
   procedure OpenNewChatWindow(This : in out MapPtr; MyName: Unbounded_String; ChatName : Unbounded_String);
   
   -- Öffnet ein Chat Fenster für eine Gruppe
   -- This => Map, in der das neue Fenster abgelegt werden soll
   -- MyName => Name des eingeloggten Nutzers
   -- ChatName => Name des Chatraums
   -- ChatID => ID des Chatraums
   procedure OpenNewGroupChatWindow(This : in out MapPtr; MyName: Unbounded_String; ChatName : Unbounded_String; ChatID : Natural);
   
   -- Fügt ein neues Chat Fenster für eine eingehende Chatrequest hinzu, ohne es zu öffnen
   -- This => Map, in der das neue Fenster abgelegt werden soll
   -- MyName => Name des eingeloggten Nutzers
   -- ChatID => ID des Chatraums
   procedure PrepareNewChatWindow(This : in out MapPtr; MyName: Unbounded_String; ChatID : Natural);

   -- Fenster geschlossen: Schreibt eingehende Chatnachrichten in eine Liste
   -- Fenster offen: Schreibt eingehende Chatnachrichten direkt auf das Fenster
   -- This => Fenster, das die Nachricht empfangen soll
   -- message => Empfangene Nachricht
   procedure EnQueueChatMessage(This : in out ChatWindow; message : MessageObject);
   
   -- Liest Chatnachrichten aus der Liste und löscht es
   -- This => Fenster, das die Liste enthält
   -- Returns Älteste Nachricht in der Liste
   function DeQueueChatMessage (This : in out ChatWindow) return MessageObject;

   MyRooms : PrivateChatRooms.Map;

   MyWindows : MapPtr := new ChatWindows.Map;

   MyUserName : Unbounded_String;

private

   -- Muss ausgeführt werden, bevor Window verwendet werden kann
   -- This => Fenster, das initialisiert werden soll
   procedure Init(This : in out ChatWindow);
   
   -- Schreibt eingehende Chatnachrichten auf das Fenster
   -- This => Fenster, das die Nachricht anzeigen soll
   -- message => Anzuzeigende Nachricht
   procedure printChatMessage(This : in out ChatWindow; message : MessageObject);

   -- Callback für das Rechtsklicken eines Elements in der Teilnehmer Liste (nicht implementiert)
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
      procedure Check_RightClick  (Object : access Gtkada_Builder_Record'Class);
	  
   -- Callback für den Invite Button im Chatfenster
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Invite_Action  (Object : access Gtkada_Builder_Record'Class);
   
   -- Callback für das Drücken von Enter in der eingegebenen Nachricht (soll Absenden auslösen)
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Handle_Enter  (Object : access Gtkada_Builder_Record'Class);
   
   -- Callback für das Schließen eines Chatfensters (soll im ChatWindow Objekt eintragen, dass es geschlossen wurde)
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Chat_Window_Close (Object : access Gtkada_Builder_Record'Class);

end Chat_Window_Manager;
