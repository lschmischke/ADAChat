with Server_To_GUI_Communication; use Server_To_GUI_Communication;
with Protocol; use Protocol;
with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Main; use Gtk.Main;
with Concrete_Server_Logic;
with dataTypes; use dataTypes;

--Dieses Paket stellt Funktionalitäten bereit, die es dem Server erlauben die Server GUI zu manipulieren.
package Concrete_Server_Gui_Logic is
   package STG renames Server_To_GUI_Communication;

   type Server_Gui is new STG.GUI with null Record;
   procedure InitServerGui(myBuilder: Gtkada_Builder);
private

   -- Mit Hilfe dieser Funktion kann der Server eine Fehlernachricht auf der GUI ausgeben
   procedure printErrorMessage(thisGUI : aliased  in Server_Gui; errorMessage : String);
   -- Mit Hilfe dieser Funktion kann der Server eine Information auf der GUI ausgeben
   procedure printInfoMessage(thisGUI : aliased in Server_Gui; infoMessage : String);
   -- Mit dieser Funktion ist es möglich eine Chatnachricht auf der Oberfläche des Servers darzustellen
   procedure printChatMessage(thisGUI : aliased in Server_Gui; chatMessage : MessageObject);
   -- Diese Funktion wird genutzt um der Server GUI die aktualisierte Benutzerliste mitzuteilen, damit
   -- sich die GUI aktualisieren kann
   procedure updateOnlineUserOverview(thisGUI : aliased  in Server_Gui; viewComponents : userViewOnlineList.List);
   -- Mit dieser Funktion wird der Server GUI die aktualisierte Liste der Chaträume übergeben
   procedure updateChatroomOverview(thisGUI : aliased in Server_Gui; viewComponents : chatRoomMap.Map);

end Concrete_Server_Gui_Logic;
