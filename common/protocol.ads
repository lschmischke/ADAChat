with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.String_Split; use GNAT.String_Split;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Streams; use Ada.Streams;
with GNAT.Sockets; use GNAT.Sockets;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- In diesem Paket ist das Kommunikationsprotokoll in Code gegossen. Es stellt Konstanten, Typen und Funktionen zur Verfügung über die unteranderem
-- Nachrichten erstellt, versendet und gelesen werden können.
--
-- Autoren: Daniel Kreck, Leonard Schmischke
-- Letzte Änderung: 29.04.2016
-----------------------------------------------------------------------------------------------------------------------------------------------------------
package Protocol is

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > Konstanten

   -- Trennzeichen für die zur Kommunikation verwendeten Strings, um in diesen inhaltlich getrennte Felder zu definieren
   -- Seperator : constant String := Character'Image(Character'Val(0));
   Seperator : constant String :=":";
   Terminator : constant Character :=';';

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > Typen

   -- Legt die verschiedenen Nachrichtentypen fest, die verschickt werden können
   type MessageTypeE is (Connect, Chat, Refused, Disconnect, Online, Offline, Chatrequest,
                         Userlist, Leavechat, Invalid, Register, addContact, remContact);

   -- Struktur einer Nachricht, Nachrichtentyp, Absender (Name des Users), Empfänger (ID des Chatraums), eigentlicher Inhalt
   type MessageObject is record
      messagetype : MessageTypeE;
      sender : Unbounded_String;
      receiver : Natural;
      content : Unbounded_String;
   end record;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   -- > Funktionen zum Typ MessageObject

   -- Setzt aus dem MessageObject einen protokollkonformen Nachrichtenstring zusammen
   function messageObjectToString(message : in MessageObject) return String;

   -- Zerlegt den Nachrichtenstring am definierten Trennzeichen und baut aus diesem ein neues MessageObject
   function stringToMessageObject(message : in Unbounded_String) return MessageObject;

   -- Erstellt ein neues MessageObject aus den angegeben Parametern
   function createMessage(messagetype : in MessageTypeE; sender : in Unbounded_String; receiver : in Natural; content : in Unbounded_String) return MessageObject;

   -- Gibt das MessageObject auf die Konsole aus
   procedure printMessageToInfoConsole(message : in MessageObject);

   -- Öffnet aus dem angegebenen Socket einen Channel und verschickt über diesen die Stringrepräsentation des MessageObjects
   procedure writeMessageToStream(ClientSocket : in Socket_Type; message : MessageObject);

   -- Liest vom angegebenen Socket eine Nachricht ein und erstellt aus dieser ein neues MessageObject
   function readMessageFromStream (ClientSocket : in Socket_Type) return MessageObject;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

end Protocol;
