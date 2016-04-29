with Server_To_GUI_Communication; use Server_To_GUI_Communication;
with Concrete_Server_Logic;
with Protocol; use Protocol;
with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Main; use Gtk.Main;
package Concrete_Server_Gui_Logic is
   package STG renames Server_To_GUI_Communication;

   type Server_Gui is new STG.GUI with null Record;
   procedure InitServerGui(myBuilder: Gtkada_Builder);
private

   procedure printErrorMessage(thisGUI : aliased  in Server_Gui; errorMessage : String);
   procedure printInfoMessage(thisGUI : aliased in Server_Gui; infoMessage : String);
   procedure printChatMessage(thisGUI : aliased in Server_Gui; chatMessage : MessageObject);
   procedure updateNumberOfContacts(thisGUI : aliased in Server_Gui; numberOfContact : Natural);
   procedure updateOnlineUserOverview(thisGUI : aliased  in Server_Gui; viewComponents : userViewOnlineList.List);
   procedure updateOfflineUserOverview(thisGUI : aliased in Server_Gui; viewComponents : userViewOfflineMap.Map);

end Concrete_Server_Gui_Logic;
