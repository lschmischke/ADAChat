with Protocol; use Protocol;
with Protocol; use Protocol;
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;
with GNAT.String_Split; use GNAT.String_Split;
with Ada.Characters.Conversions;
with User_Databases; use User_Databases;
with dataTypes; use dataTypes;
with ada.containers.Indefinite_Hashed_Maps;
with Ada.Containers.Hashed_Maps;
with Ada.Strings.Unbounded.Hash;
with Gtk.Builder; use Gtk.Builder;
with GUI_to_Server_Communication;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with dataTypes;

package Server_To_GUI_Communication is
   type GUI is interface;
   type GUIPtr is access all GUI'Class;


   package userViewOfflineMap is new Hashed_Maps(Key_Type        => Unbounded_String,
						     Element_Type    => Unbounded_String,
						     Hash            => Ada.Strings.Unbounded.Hash_Case_Insensitive,
                                                 Equivalent_Keys => "=");

   procedure printErrorMessage(thisGUI : aliased in GUI; errorMessage : String) is abstract;
   procedure printInfoMessage(thisGUI : aliased in GUI; infoMessage : String) is abstract;
   procedure printChatMessage(thisGUI : aliased in GUI; chatMessage : MessageObject) is abstract;
   procedure updateNumberOfContacts(thisGUI : aliased in GUI; numberOfContact : Natural) is abstract;
   procedure updateOnlineUserOverview(thisGUI : aliased in GUI; viewComponents : userViewOnlineList.List) is abstract;
   procedure updateOfflineUserOverview(thisGUI : aliased in GUI; viewComponents : userViewOfflineMap.Map) is abstract;
end Server_To_GUI_Communication;
