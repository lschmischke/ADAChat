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
package body Concrete_Server_Gui_Logic is

   PortGEntry : Gtk_GEntry;

   InformationsTreeView : Gtk_Tree_View;
   InformationsListStore: Gtk_List_Store;
   InformationsTreeViewIterator: Gtk_Tree_Iter;

   ErrorsTreeView: Gtk_Tree_View;
   ErrorsListStore: Gtk_List_Store;
   ErrorsTreeViewIterator: Gtk_Tree_Iter;

   ChatMessageListStore: Gtk_List_Store;
   ChatMessageListStoreIterator: Gtk_Tree_Iter;
   ChatMessageTreeView: Gtk_Tree_View;

   SecondLevelIterator: Gtk_Tree_Iter;
   --Val: Gint;


    InformationsTextView: Gtk_Text_View;
   ErrorsTextView: Gtk_Text_View;

   OnlineUserTreeStore: Gtk_Tree_Store;
   OnlineUserTreeView: Gtk_Tree_View;
   OnlineUserTreeIter: Gtk_Tree_Iter;

   TestToolButton: Gtk_Menu_Tool_Button;
   TestMenu: Gtk_Menu;


--------------------------------------------------------------------------------------------------------------------------------------------------------

   procedure printErrorMessage(thisGUI :  aliased in Server_Gui; errorMessage : String)
   is
   buffer: Gtk_Text_Buffer;
      mark : Gtk_Text_Mark;
      iter: Gtk_Text_Iter;

   begin
       ErrorsListStore.Append(Iter => ErrorsTreeViewIterator);
      ErrorsListStore.Set(Iter   => ErrorsTreeViewIterator,
                                Column => 0,
                                Value  => errorMessage);

   end printErrorMessage;
--------------------------------------------------------------------------------------------------------------------------------------------------------
   procedure printInfoMessage(thisGUI : aliased in Server_Gui; infoMessage : String) is

   begin
      Put_Line(infoMessage);
      InformationsListStore.Append(Iter => InformationsTreeViewIterator);
      InformationsListStore.Set(Iter   => InformationsTreeViewIterator,
                                Column => 0,
                                Value  => infoMessage);

   end printInfoMessage;
   --------------------------------------------------------------------------------------------------------------------------------------------------------
   procedure printChatMessage(thisGUI : aliased  in Server_Gui; chatMessage : MessageObject) is begin
        ChatMessageListStore.Append(Iter => ChatMessageListStoreIterator);
      ChatMessageListStore.Set(Iter   => ChatMessageListStoreIterator,
                               Column => 0,
                               Value  => To_String(chatMessage.sender) & ": " &To_String(chatMessage.content));

   end printChatMessage;
   --------------------------------------------------------------------------------------------------------------------------------------------------------
   procedure updateNumberOfContacts(thisGUI : aliased in Server_Gui; numberOfContact : Natural) is null;
   --------------------------------------------------------------------------------------------------------------------------------------------------------
   procedure updateOnlineUserOverview(thisGUI : aliased in Server_Gui; viewComponents : userViewOnlineList.List) is
      ContactsIterator : Gtk_Tree_Iter;
      SingleContactIterator: Gtk_Tree_Iter;
      IpAddressIterator: Gtk_Tree_Iter;
      TempIter: Gtk_Tree_Iter;
      TempItem: Gtk_Menu_Item;
             begin

      OnlineUserTreeStore.Clear;

  --    OnlineUserTreeView.
    --  TreeStore.Append(Iter   => SecondLevelIterator,
      --                 Parent => InformationsTreeViewIterator);
      --TreeStore.Set(Iter   => SecondLevelIterator,
        --            Column => 0 ,
          --          Value  => "Test456" );
      For client of viewComponents loop
         OnlineUserTreeIter := Null_Iter;
         ContactsIterator := Null_Iter;
         SingleContactIterator := Null_Iter;

             OnlineUserTreeStore.Append(Iter   => OnlineUserTreeIter,
                                        Parent => Null_Iter );
           OnlineUserTreeStore.Set(Iter   => OnlineUserTreeIter,
                    Column => 0 ,
                    Value  => To_String(client.getUsernameOfClient));

         OnlineUserTreeStore.Append(Iter   => ContactsIterator,
                                    Parent => OnlineUserTreeIter);
         OnlineUserTreeStore.Set(Iter   => ContactsIterator,
                                 Column => 0,
                                 Value  => "Contacts");

         TempItem := Gtk_Menu_Item_New_With_Label(Label =>  To_String(client.getUsernameOfClient));
         TestMenu.Append(Child => TempItem);
         For contact of client.getUser.getContacts loop
            OnlineUserTreeStore.Append(Iter   => SingleContactIterator,
                                       Parent => ContactsIterator);
            OnlineUserTreeStore.Set(Iter   => SingleContactIterator,
                                    Column =>0 ,
                                    Value  => To_String(contact.getUsername) );

            end loop;

      end loop;

   end updateOnlineUserOverview;
   --------------------------------------------------------------------------------------------------------------------------------------------------------
   procedure updateOfflineUserOverview(thisGUI : aliased in Server_Gui; viewComponents : userViewOfflineMap.Map)is null;
   --------------------------------------------------------------------------------------------------------------------------------------------------------
   procedure InitServerGui(myBuilder: Gtkada_Builder) is begin
      Put_Line("Init Gui Components");
      PortGEntry := Gtk_GEntry(myBuilder.Get_Object("config_port"));
      PortGEntry.Set_Text("12321");

      ChatMessageTreeView := Gtk_Tree_View(myBuilder.Get_Object("chatMessagesTreeView"));
      ChatMessageListStore := Gtk_List_Store(myBuilder.Get_Object("chatMessageListStore"));

      InformationsListStore := Gtk_List_Store(myBuilder.Get_Object("liststoreInformations"));
      InformationsTreeView := Gtk_Tree_View(myBuilder.Get_Object("treeviewInformations"));

      ErrorsListStore := Gtk_List_Store(myBuilder.Get_Object("liststoreErrors"));
      ErrorsTreeView := Gtk_Tree_View(myBuilder.Get_Object("treeviewErrors"));
             OnlineUserTreeView := Gtk_Tree_View(myBuilder.Get_Object("treeviewOnlineUser"));
      OnlineUserTreeStore := Gtk_Tree_Store(myBuilder.Get_Object("treestoreOnlineUser"));
     -- KickUserListStore := Gtk_List_Store(myBuilder.Get_Object("liststoreKickUser"));
      -- KickUserComboBox := Gtk_List_Store(myBuilder.Get_Object("comboboxKickUser"));
     TestMenu := Gtk_Menu(myBuilder.Get_Object("kickMenu"));

      Put_Line("Initialization complete!");
   End InitServerGui;
end Concrete_Server_Gui_Logic;
