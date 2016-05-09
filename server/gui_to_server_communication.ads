with Ada.Text_IO; use Ada.Text_IO;

package GUI_to_Server_Communication is

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Interfacetyp eines Server, der von einer GUI aus gesteuert wird
   type Server is limited interface;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   --Referenztyp auf eine Implementierung des Server-Interfaces
   type ServerPtr is access all Server'Class;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Startet den Server unter der übergebenen IP-Adresse und dem übergebenen Port
   procedure startServer(thisServer : aliased in out  Server;port : Natural) is abstract;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Stopt den Server
   procedure stopServer(thisServer : aliased in out Server) is abstract;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Veranlasst den Server, seine Datenbank einzulesen
   function loadDB(thisServer : aliased in out Server; DataFile : File_type) return Boolean is abstract;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Veranlasst den Server, seine Datenbank abzuspeichern
   procedure saveDB(thisServer : aliased in out Server; DataFile : File_type) is abstract;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Veranlasst den Server, eine Chat-Nachricht an einen Benutzer mit einem bestimmten Benutzernamen, zu senden.
   -- Der adressierte Benutzer muss exisitieren und online sein, damit die Nachricht übertragen werden kann.
   -- username => Benutzername des Benutzers, an den die Nachricht versendet werden soll.
   -- messageString => Inhalt der Nachricht
   procedure sendMessageToUser(thisServer : aliased in out  Server; username : String; messagestring : String) is abstract;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   --TODO genutzt?
   procedure deleteUserFromDatabase(thisServer : aliased in out Server; username : String) is abstract;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Veranlasst den Server, die Verbindung zu einem Benutzer mit dem übergebenen Benutzernamen zu trennen
   procedure kickUserWithName(thisServer : aliased in  out Server; username:String) is abstract;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

end GUI_to_Server_Communication;
