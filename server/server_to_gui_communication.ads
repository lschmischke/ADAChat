with Protocol; use Protocol;
with ada.containers.Indefinite_Hashed_Maps;
with Ada.Containers.Hashed_Maps;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;
limited with Concrete_Server_Logic;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.Strings.Unbounded.Hash_Case_Insensitive;

package Server_To_GUI_Communication is
   type GUI is interface;

   type ClientPtr is access Concrete_Server_Logic.Concrete_Client;

   package userViewOnlineList is new Doubly_Linked_Lists(Element_Type => ClientPtr);
   package userViewOfflineMap is new Hashed_Maps(Key_Type        => Unbounded_String,
						     Element_Type    => Unbounded_String,
						     Hash            => ada.Strings.Unbounded.Hash_Case_Insensitive,
                                                     Equivalent_Keys => "=");

   procedure printErrorMessage(thisGUI : aliased in GUI; errorMessage : String) is abstract;
   procedure printInfoMessage(thisGUI : aliased in GUI; infoMessage : String) is abstract;
   procedure printChatMessage(thisGUI : aliased in GUI; chatMessage : MessageObject) is abstract;
   procedure updateNumberOfContacts(thisGUI : aliased in GUI; numberOfContact : Natural) is abstract;
   procedure updateOnlineUserOverview(thisGUI : aliased in GUI; viewComponents : userViewOnlineList.List) is abstract;
   procedure updateOfflineUserOverview(thisGUI : aliased in GUI; viewComponents : userViewOfflineMap.Map) is abstract;

end Server_To_GUI_Communication;
