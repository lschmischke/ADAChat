with Gtk.Main; use Gtk.Main;
with Gtk.Button; use Gtk.Button;
with Glib;           use Glib;
with Glib.Object;    use Glib.Object;

with Ada.Text_IO; use Ada.Text_IO;
with Gtk.GEntry; use Gtk.GEntry;
with Gtk.Status_Bar; use Gtk.Status_Bar;
with Gtk.Tree_View;            use Gtk.Tree_View;
with Glib.Values; use Glib.Values;
with Gtk.Cell_Renderer_Text;   use Gtk.Cell_Renderer_Text;
with Gtk.Frame; use Gtk.Frame;
with Gtk.Cell_Renderer_Toggle; use Gtk.Cell_Renderer_Toggle;
with Gtk.Text_View;

use Gtk; with Gtk;
with Gtk.Enums; use Gtk.Enums;
with Gtk.List_Store; use Gtk.List_Store;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Tree_Model; use Gtk.Tree_Model;
with Gtk.Tree_Store; use Gtk.Tree_Store;
with Gtk.Tree_View_Column; use Gtk.Tree_View_Column;
with Gtk.Cell_Renderer_Text; use Gtk.Cell_Renderer_Text;
with Gtk.Tree_Selection; use Gtk.Tree_Selection;
with Gtk.Scrolled_Window; use Gtk.Scrolled_Window;
with Gtk.Menu; use Gtk.Menu;
with Gtk.Spin_Button; use Gtk.Spin_Button;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with dataTypes; use dataTypes;

with Gtk.Text_View; use Gtk.Text_View;
with Gtk.Combo_Box; use Gtk.Combo_Box;

with Gtk.Menu_Tool_Button; use Gtk.Menu_Tool_Button;
--------------------------------

with Gtk.Text_Mark; use Gtk.Text_Mark;
with Gtk.Text_Buffer; use Gtk.Text_Buffer;
with Gtk.Text_Iter; use Gtk.Text_Iter;

with Gtk.Menu_Item; use Gtk.Menu_Item;
with GNAT.Sockets; use GNAT.Sockets;

with GNAT;use GNAT;

with Ada.Calendar; use Ada.Calendar;
with GNAT.Calendar.Time_IO;

with Gtk.Label; use Gtk.Label;
with Ada.Characters.Latin_1;
with Ada.Containers; use ada.Containers;
package body Concrete_Server_Gui_Logic is

   -- Variablen, die später die Referenzen auf die einzelnen Elemente der GUI halten
   portGEntry : Gtk_GEntry;
   informationsTreeView : Gtk_Tree_View;
   informationsListStore: Gtk_List_Store;
   informationsTreeViewIterator: Gtk_Tree_Iter;
   errorsTreeView: Gtk_Tree_View;
   errorsListStore: Gtk_List_Store;
   errorsTreeViewIterator: Gtk_Tree_Iter;
   chatMessageListStore: Gtk_List_Store;
   chatMessageListStoreIterator: Gtk_Tree_Iter;
   chatMessageTreeView: Gtk_Tree_View;
   secondLevelIterator: Gtk_Tree_Iter;
   onlineUserTreeStore: Gtk_Tree_Store;
   onlineUserTreeView: Gtk_Tree_View;
   onlineUserTreeIter: Gtk_Tree_Iter;
   kickUserListStore : Gtk_List_Store;
   kickUserComboBox :Gtk_Combo_Box;
   chatroomTreeView : Gtk_Tree_View;
   chatroomTreeStore :Gtk_Tree_Store;
   labelStats: Gtk_Label;



   --------------------------------------------------------------------------------------------------------------------------------------------------------

   procedure printErrorMessage(thisGUI :  aliased in Server_Gui; errorMessage : String)
   is
      iter: Gtk_Text_Iter;
      Now : Time := Clock;
   begin
      -- Iterator bei Listtore einfügen
      errorsListStore.Insert(Iter => errorsTreeViewIterator,
                             Position => 0);
      -- GNAT.Calendar.Time_Io.Image (Now, "%H:%M:%S") erstellt einen Timestamp im Format HH:MM:SS
      -- Wert des Iterators setzen
      errorsListStore.Set(Iter   => errorsTreeViewIterator,
                          Column => 0,
                          Value  => "(" & GNAT.Calendar.Time_Io.Image (Now, "%H:%M:%S") &") " &errorMessage);
   end printErrorMessage;
   --------------------------------------------------------------------------------------------------------------------------------------------------------
   procedure printInfoMessage(thisGUI : aliased in Server_Gui; infoMessage : String) is
      Now : Time := Clock;
   begin
      -- Iterator bei Listtore einfügen
      informationsListStore.Insert(Iter => informationsTreeViewIterator ,
                                   Position => 0);
      -- GNAT.Calendar.Time_Io.Image (Now, "%H:%M:%S") erstellt einen Timestamp im Format HH:MM:SS
      -- Wert des Iterators setzen
      informationsListStore.Set(Iter   => informationsTreeViewIterator,
                                Column => 0,
                                Value  =>"(" & GNAT.Calendar.Time_Io.Image (Now, "%H:%M:%S") &") " & infoMessage);

   end printInfoMessage;
   --------------------------------------------------------------------------------------------------------------------------------------------------------
   procedure printChatMessage(thisGUI : aliased  in Server_Gui; chatMessage : MessageObject) is
      Now : Time := Clock;
   begin
       -- Iterator bei Listtore einfügen
      chatMessageListStore.Append(Iter => chatMessageListStoreIterator);
      -- GNAT.Calendar.Time_Io.Image (Now, "%H:%M:%S") erstellt einen Timestamp im Format HH:MM:SS
      -- Wert des Iterators setzen
      -- Hier sind vor allem die Felder 'Sender', 'Receiver' und 'Content' des MessageObjets wichtig
      chatMessageListStore.Set(Iter   => chatMessageListStoreIterator,
                               Column => 0,
                               Value  =>"(" & GNAT.Calendar.Time_Io.Image (Now, "%H:%M:%S") &") " & To_String(chatMessage.sender) & " -> " & Natural'Image(chatMessage.receiver) &": "  &To_String(chatMessage.content));

   end printChatMessage;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   procedure updateOnlineUserOverview(thisGUI : aliased in Server_Gui; viewComponents : userViewOnlineList.List) is
      ContactsIterator : Gtk_Tree_Iter;
      SingleContactIterator: Gtk_Tree_Iter;
      IpAddressIterator: Gtk_Tree_Iter;
      TempIter: Gtk_Tree_Iter;
      ChatroomIterator: Gtk_Tree_Iter;
      SingleChatroomIterator: Gtk_Tree_Iter;
   begin
      -- Zu Beginn die alten Daten löschen um doppeltes beschreiben zu verhindern
      onlineUserTreeStore.Clear;
      kickUserListStore.Clear;
      -- Hier wird in einer foreach Schleife über die verbundnen Clients iteriert
      For client of viewComponents loop
            onlineUserTreeIter := Null_Iter;
            ContactsIterator := Null_Iter;
            SingleContactIterator := Null_Iter;

         -- Auf der obersten Ebene wird der Benutzername eingefügt
         -- Die oberste Ebene erkennt man an Parent => NUll_Iter
            onlineUserTreeStore.Append(Iter   => onlineUserTreeIter,
                                       Parent => Null_Iter );
            onlineUserTreeStore.Set(Iter   => onlineUserTreeIter,
                                    Column => 0 ,
                                    Value  => To_String(client.getUsernameOfClient));

         -- Unter dem Namen des Benutzers wird die IP Adresse eingefügt.
         -- Parent => Client
            onlineUserTreeStore.Append(Iter   => IpAddressIterator,
                                       Parent => onlineUserTreeIter);
            onlineUserTreeStore.Set(Iter   => IpAddressIterator,
                                    Column => 0,
                                    Value  => "IP-Adresse: " & Gnat.Sockets.Image(client.getSocketAddress) );

         -- Hier wird der Liststore befüllt, der später zur Auswahl des zu kickenden Users dient
            kickUserListStore.Append(Iter => TempIter);
            kickUserListStore.Set(Iter   => TempIter,
                                  Column => 0,
                                  Value  => To_String(client.getUsernameOfClient));

         -- Hier wird ein Oberelement eingefügt, unter das später die einzelnen Kontakte
         -- angehängt werden
            onlineUserTreeStore.Append(Iter   => ContactsIterator,
                                       Parent => onlineUserTreeIter);
            onlineUserTreeStore.Set(Iter   => ContactsIterator,
                                    Column => 0,
                                    Value  => "Kontakte");

         -- Es wird über die Kontakte des Users iteriert und diese eingefügt
            For contact of client.getUser.getContacts loop
               onlineUserTreeStore.Append(Iter   => SingleContactIterator,
                                          Parent => ContactsIterator);
               onlineUserTreeStore.Set(Iter   => SingleContactIterator,
                                       Column =>0 ,
                                       Value  => To_String(contact.getUsername) );

            end loop;

         -- Überelement um die Chaträume, in denen sich der User befindet anzuhängen
            onlineUserTreeStore.Append(Iter   => ChatroomIterator,
                                       Parent => onlineUserTreeIter);
            onlineUserTreeStore.Set(Iter   => ChatroomIterator,
                                    Column => 0,
                                    Value  => "Chatrooms");

         -- Über die Chaträume iterieren und diese anhängen
            For chatroom of client.getChatroomList loop
               onlineUserTreeStore.Append(Iter   => SingleChatroomIterator,
                                          Parent => ChatroomIterator);
               onlineUserTreeStore.Set(Iter   => SingleChatroomIterator,
                                       Column =>0 ,
                                       Value  => Natural'Image(chatroom.getChatRoomID) );

            end loop;

      end loop;
      -- Statistik aktualisieren. Dafür wird das Label in der Toolbar aktualisiert.
       labelStats.Set_Label(Str =>"Users online: " & Count_Type'Image(viewComponents.Length) & Ada.Characters.Latin_1.LF &"Server is running" );

   end updateOnlineUserOverview;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   procedure InitServerGui(myBuilder: Gtkada_Builder) is begin

      -- In dieser Funktion werden die Referenzen anhand ihrer Bezeichnungen abgeholt und gesetzt.
      portGEntry := Gtk_GEntry(myBuilder.Get_Object("config_port"));
      portGEntry.Set_Text("12321");

      chatMessageTreeView := Gtk_Tree_View(myBuilder.Get_Object("chatMessagesTreeView"));
      chatMessageListStore := Gtk_List_Store(myBuilder.Get_Object("chatMessageListStore"));

      informationsListStore := Gtk_List_Store(myBuilder.Get_Object("liststoreInformations"));
      informationsTreeView := Gtk_Tree_View(myBuilder.Get_Object("treeviewInformations"));

      errorsListStore := Gtk_List_Store(myBuilder.Get_Object("liststoreErrors"));
      errorsTreeView := Gtk_Tree_View(myBuilder.Get_Object("treeviewErrors"));
      onlineUserTreeView := Gtk_Tree_View(myBuilder.Get_Object("treeviewOnlineUser"));
      onlineUserTreeStore := Gtk_Tree_Store(myBuilder.Get_Object("treestoreOnlineUser"));
      kickUserListStore := Gtk_List_Store(myBuilder.Get_Object("liststoreKickUser"));
      kickUserComboBox := Gtk_Combo_Box(myBuilder.Get_Object("comboboxKickUser"));

      chatroomTreeStore := Gtk_Tree_Store(myBuilder.Get_Object("treestoreChatrooms"));
      chatroomTreeView := Gtk_Tree_View(myBuilder.Get_Object("treeviewChatrooms"));

      labelStats := Gtk_Label(myBuilder.Get_Object("labelStats"));


   End InitServerGui;

   procedure updateChatroomOverview(thisGUI : aliased in Server_Gui; viewComponents : chatRoomMap.Map) is
      ChatroomIter: Gtk_Tree_Iter;
      UserIter: Gtk_Tree_Iter;
   begin
      -- Chatraumansicht zurücksetzen
      chatroomTreeStore.Clear;
      -- ÜBer die Chaträume iterieren und die als oberes Element einfügen.
      for room of viewComponents loop
         chatroomTreeStore.Append(Iter   => ChatroomIter,
                                  Parent => Null_Iter);
         chatroomTreeStore.Set(Iter   => ChatroomIter,
                               Column => 0,
                               Value  => Natural'Image(room.getchatroomid));
         -- Darunter werden die Clients, die sich in dem jeweiligen Chatroom aufhalten eingefügt.
         for user of room.getclientlist loop
            chatroomTreeStore.Append(Iter   => UserIter,
                                     Parent => ChatroomIter );
            chatroomTreeStore.Set(Iter   => UserIter,
                                  Column => 0 ,
                                  Value  => To_String(user.getUsernameOfClient) );
         end loop;
      end loop;
   end updateChatroomOverview;
end Concrete_Server_Gui_Logic;

