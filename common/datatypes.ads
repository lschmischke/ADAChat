with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;
with GNAT.SHA512;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dieses Paket b�ndelt Typen um Benutzer des Chats abzuspeichern.
--
-- Autoren: Daniel Kreck, Leonard Schmischke
-- Letzte �nderung: 29.04.2016
-----------------------------------------------------------------------------------------------------------------------------------------------------------
package dataTypes is

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > �ffentliche Typen

   -- In diesem Datentyp wird ein Benutzer abgelegt. Er enth�lt seinen Namen, Passwort und seine Kontaktliste
   type User is tagged private;
   type UserPtr is access User;

   package UserList is new Doubly_Linked_Lists(Element_Type => UserPtr);

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > Funktionen zum Typ UserPtr

   -- Gibt den Namen des Benutzers zur�ck
   function getUsername(this : in UserPtr) return Unbounded_String;

   -- Setzt den Namen des Benutzers
   procedure setUsername(this : in out UserPtr; name : in Unbounded_String);

   -- Verschl�sselt das Passwort eines Benutzers mit SHA512
   function encodePassword(password : in Unbounded_String) return Unbounded_String;

   -- Gibt das Passwort eines Benutzer zur�ck
   function getPassword(this : in UserPtr) return Unbounded_String;

   -- Setzt das Passwort eines Benutzers
   function setPassword(this : in out UserPtr; password : in Unbounded_String) return Boolean;

   -- Gibt die Kontaktliste eines Benutzers zur�ck
   function getContacts (this : in UserPtr) return UserList.List;

   -- Setzt die Kontaktliste eines Benutzers
   procedure setContacts (this : in out UserPtr; contacts : in UserList.List);

   -- F�gt einen einen Benutzer zur Kontaktliste eines anderen Benutzers hinzu
   function addContact (this : in out UserPtr; contactToAdd : UserPtr) return Boolean;

   -- L�scht einen Benutzer von der Kontaktliste eines anderen Benutzers
   function removeContact (this : in out UserPtr; contactToRemove : UserPtr) return boolean;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

private

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > Private Typen

   type User is tagged
      record
         username : Unbounded_String;
         password : Unbounded_String;
         contacts : UserList.List;
      end record;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

end dataTypes;
