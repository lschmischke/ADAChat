--Interface Gui zu Client Kommunikation.

--Includes
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Protocol; use Protocol;
with GNAT.Sockets; use GNAT.Sockets;

limited with Client2Gui_Communication;

package Gui2Client_Communication is

   type Client is interface;
   type ClientPtr is access all Client'Class;

   -- Registriert bzw. referenziert die GUI beim Client.
   -- Ptr => Pointer zur GUI
   procedure initializeGUI(this : in out Client; ptr : in Client2Gui_Communication.GUIPtr) is abstract;

   -- Erzeugt eine Socketverbindung zum angegebenen Server.
   -- ServerAdress => Server Addresse(IP)
   -- ServerPort => Server Port
   procedure initializeSocket(this : in out Client; serverAdress : in Unbounded_String;
                              serverPort : in Port_Type) is abstract;

   -- Loggt einen User auf dem Server ein.
   -- pre => Socketverbindung zum Server & entsprechender User muss registriert sein
   -- Username => Name des Users
   -- Password => Passwort des Users
   procedure loginUser (this : in out Client; username : in Unbounded_String; password : in Unbounded_String) is abstract;

   -- Beendet die Verbindung zum Server.
   -- Username => Name des Users
   -- Message => Abschiedsnachricht
   procedure disconnectUser(this : in out Client; username : in Unbounded_String; message : in Unbounded_String) is abstract;

   -- Registriert einen User beim Server.
   -- pre => Es muss eine Socketverbindung zum Server bestehen
   -- Username => Name des Users
   -- Password => Passwort des Users
   procedure registerUser(this : in out Client; username : in Unbounded_String; password : in Unbounded_String) is abstract;

   -- Sendet einem User eine Einladung zu einem Gruppenchat.
   -- Receiver => ID zum Server-Chat
   -- Participant => Name des Users, der eingeladen werden soll
   procedure inviteToGroupChat(this : in out Client; username : in Unbounded_String; receiver : in Integer;
                               participant : in Unbounded_String) is abstract;

   -- Sendet eine Message zum angegebenen Chat.
   -- Receiver => ID zum Chat zu welchem die Nachricht gesendet werden soll
   -- Username => Name des sendenden Clients
   -- Message => Nachricht die gesendet werden soll
   procedure sendMessageToChat(this : in out Client; receiver: in Integer; username : in Unbounded_String;
                               message : in Unbounded_String) is abstract;

   -- Sendet einen Chatrequest an den Server, um einen Chat zu er�ffnen.
   -- Username => Name des sendenden Clients
   -- Message => Name des Participant
   procedure requestChat(this : in out Client; username : in Unbounded_String;
                               participant : in Unbounded_String) is abstract;

end Gui2Client_Communication;
