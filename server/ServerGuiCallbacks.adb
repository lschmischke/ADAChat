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
with Gtk.Tool_Button; use Gtk.Tool_Button;
with Concrete_Server_Gui_Logic; use Concrete_Server_Gui_Logic;
with Concrete_Server_Logic; use Concrete_Server_Logic;
with GUI_to_Server_Communication; use GUI_to_Server_Communication;
with Server_To_GUI_Communication; use Server_To_GUI_Communication;
package body ServerGuiCallbacks is




   --PortGEntry : Gtk_GEntry;
   --InformationsTreeView : Gtk_Tree_View;
   --InformationsTreeStore: Gtk_Tree_Store;
   InformationsTreeViewIterator: Gtk_Tree_Iter;
   SecondLevelIterator: Gtk_Tree_Iter;
   --UserContextMenu: Gtk_Menu;
   --Val: Gint;
   Toolbutton_Server_Stop: Gtk_Tool_Button;
   Toolbutton_Server_Start: Gtk_Tool_Button;
   MyServer: ServerPtr := new Concrete_Server;
   MyGui: GUIPtr := new Server_Gui;



   procedure InitializeGuiReferences(myBuilder: access Gtkada_Builder_Record'Class) is begin
      Toolbutton_Server_Start := Gtk_Tool_Button(myBuilder.Get_Object("toolbutton_start_server"));
      Toolbutton_Server_Stop := Gtk_Tool_Button(myBuilder.Get_Object("toolbutton_stop_server"));
      end InitializeGuiReferences;




   procedure Quit (Object : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Object);
   begin
      Gtk.Main.Main_Quit;
   end Quit;

 procedure rowHandler ( Object : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Object);
   begin
      Put_Line("ROW");
   end rowHandler;





   procedure clicked_button_about ( Object : access Gtkada_Builder_Record'Class) is
   begin
      Put_Line("about");


   end clicked_button_about;

   procedure clicked_button_server_start ( Object : access Gtkada_Builder_Record'Class) is begin
      MyServer.startServer(ipAdress => "127.0.0.1",
                         port     => 12321);
       MyGui.printInfoMessage("Server started!");
      Toolbutton_Server_Start.Set_Sensitive(Sensitive => False);
      Toolbutton_Server_Stop.Set_Sensitive(Sensitive => True);
   end clicked_button_server_start;

   procedure clicked_button_server_stop ( Object : access Gtkada_Builder_Record'Class) is begin
       MyServer.stopServer;
       MyGui.printInfoMessage("Server stopped!");
      Toolbutton_Server_Start.Set_Sensitive(Sensitive => True);
      Toolbutton_Server_Stop.Set_Sensitive(Sensitive => False);
      end clicked_button_server_stop;









end ServerGuiCallbacks;
