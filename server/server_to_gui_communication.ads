with Protocol; use Protocol;
with Concrete_Server_Logic; use Concrete_Server_Logic;

package Server_To_GUI_Communication is
   type GUI is interface;

   procedure printErrorMessage(thisGUI : aliased in GUI; errorMessage : MessageObject) is abstract;
   procedure printInfoMessage(thisGUI : aliased in GUI; infoMessage : MessageObject) is abstract;
   procedure printChatMessage(thisGUI : aliased in GUI; chatMessage : MessageObject) is abstract;
   procedure updateNumberOfContacts(thisGUI : aliased in GUI; numberOfContact : Natural) is abstract;
   procedure updateOnlineUserOverview(thisGUI : aliased in GUI, viewComponents : userViewOnlineList) is abstract;
   procedure updateOfflineUserOverview(thisGUI : aliased in GUI, viewComponents : userViewOfflineMap) is abstract;

end Server_To_GUI_Communication;
