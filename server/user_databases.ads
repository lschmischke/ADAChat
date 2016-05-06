with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with Ada.Strings.Unbounded.Equal_Case_Insensitive;
with Ada.Containers.Hashed_Maps;  use Ada.Containers;
with Ada.Text_IO; use Ada.Text_IO;
with Protocol;
with GNAT.String_Split; use GNAT.String_Split;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;
with ada.containers.Indefinite_Hashed_Maps;
with Ada.Strings.hash;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.IO_Exceptions;
with DataTypes; use DataTypes;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dieses Paket bündelt Typen um Benutzer des Chats zu verwalten. Es unterhält unter anderem Funktionen um User zu registrieren und die
-- Benutzerdatenbank zu speichern oder zu laden.
--
-- Autoren: Daniel Kreck, Leonard Schmischke
-- Letzte Änderung: 29.04.2016
-----------------------------------------------------------------------------------------------------------------------------------------------------------
package User_Databases is

   --TODO
   -- deleteUser

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   package User_Maps is new Hashed_Maps
     (Key_Type => Unbounded_String,
      Element_Type => UserPtr,
      Hash => Ada.Strings.Unbounded.Hash_Case_Insensitive,
      Equivalent_Keys => "=");
   use User_Maps;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   package contactNamesList is new Doubly_Linked_Lists(Element_Type => Unbounded_String);

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Typ einer Benutzerdatenbank. Diese speichert alle registrierten Benutzer und ihre Informationen und ermöglicht es, weitere Benutzer
   -- anzulegen und Benutzer zu löschen. Der Inhalt kann auf einem Speichermedium festgehalten werden, sodass die Daten auch noch verfügbar sind,
   -- wenn ein Server beendet wird.
   protected type User_Database is
      -- Legt einen neuen Benutzer mit den übergebenen Daten an.
      -- username => Benutzername des Benutzers
      -- password => Passwort des Benutzers
      -- success => gibt an, ob die Registrierung erfolgreich war. Sie kann fehlschlagen, wenn der gewählte Benutzernamen bereits verwendet wird
      procedure registerUser(username : in Unbounded_String; password : in Unbounded_String; success : out Boolean);
      -- Gibt eine Referenz auf den Benutzer mit dem übergebenen Benutzernamen zurück.
      -- return => null, wenn kein passender Benutzer gefunden, sonst Referenz auf den Benutzer
      function getUser(username : in Unbounded_String) return UserPtr;
      -- Speichert die Datenbank in einem Textfile. Der Name des Textfiles ist Attribut der Datenbank.
      procedure saveUserDatabase;
      -- Lädt den Inhalt der Datenbank aus einem Textfile. Der Name des Textfiles ist Attribut der Datenbank.
      procedure loadUserDatabase;
   private
      users : User_Maps.Map; -- # username -> userDataSet
      databaseFileName: Unbounded_String := To_Unbounded_String("ADAChatDatabase.txt");
   end User_Database;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Referenztyp einer Benutzerdatenbank
   type User_Database_Ptr is access User_Database;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

private

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   package userToContactNamesMap is new Indefinite_Hashed_Maps
     (Key_Type => Unbounded_String,
      Element_Type => contactNamesList.List,
      Hash => Ada.Strings.Unbounded.Hash_Case_Insensitive,
      Equivalent_Keys => Ada.strings.Unbounded.Equal_Case_Insensitive,
      "=" => contactNamesList."=");
   use userToContactNamesMap;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Erstellt aus einem User eine eindeutige String-Repräsentation, die persistent gespeichert werden kann
   function userToUnboundedString(this : in out UserPtr) return Unbounded_String;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Erstellt aus einem String ein User, dessen Kontakte noch nicht gesetzt sind. ALlerdings werden die Namen der Kontakte in contactNames mitgeliefert.
   -- inputLine => String, aus dem der User konstruiert wird
   -- contactNames => Liste mit den Namen der Kontakte des Users
   -- newUser => erstellter User, ohne seine Kontakte
   procedure StringToLonelyUser(inputLine : in String; contactNames : out contactNamesList.List; newUser : out UserPtr);

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------


end User_Databases;
