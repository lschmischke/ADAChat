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
package body Concrete_Server_Gui_Logic is

   PortGEntry : Gtk_GEntry;
   InformationsTreeView : Gtk_Tree_View;
   InformationsTreeStore: Gtk_Tree_Store;
   InformationsTreeViewIterator: Gtk_Tree_Iter;
   SecondLevelIterator: Gtk_Tree_Iter;
   Val: Gint;



   procedure printErrorMessage(thisGUI :  aliased in Server_Gui; errorMessage : MessageObject) is null;
   procedure printInfoMessage(thisGUI : aliased in Server_Gui; infoMessage : MessageObject) is null;
   procedure printChatMessage(thisGUI : aliased  in Server_Gui; chatMessage : MessageObject) is null;
   procedure updateNumberOfContacts(thisGUI : aliased in Server_Gui; numberOfContact : Natural) is null;
   procedure updateOnlineUserOverview(thisGUI : aliased in Server_Gui; viewComponents : userViewOnlineList.List) is null;
   procedure updateOfflineUserOverview(thisGUI : aliased in Server_Gui; viewComponents : userViewOfflineMap.Map)is null;

   procedure InitServerGui(myBuilder: Gtkada_Builder) is begin
      Put_Line("Init Gui Components");
      PortGEntry := Gtk_GEntry(myBuilder.Get_Object("config_port"));
      PortGEntry.Set_Text("12321");
      InformationsTreeView := Gtk_Tree_View(myBuilder.Get_Object("informationsTreeView"));
      InformationsTreeStore := Gtk_Tree_Store(myBuilder.Get_Object("treestore1"));

     -- InformationsTreeViewListStore.Append(InformationsTreeViewIterator);
     --InformationsTreeViewListStore.Set(InformationsTreeViewIterator,0,"Test");
     -- Column 1: Nachrichtentyp
     -- Column 0: Nachricht

      InformationsTreeStore.Append(Iter   => SecondLevelIterator,
                       Parent => InformationsTreeViewIterator);
      InformationsTreeStore.Set(Iter   => SecondLevelIterator,
                    Column => 0 ,
                    Value  => "Test456" );





      Put_Line("Initialization complete!");
   End InitServerGui;



   end Concrete_Server_Gui_Logic;
