with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Client_Window;
limited with Concrete_Client_Logic;
with Client2Gui_Communication; use Client2Gui_Communication;
with Gui2Client_Communication; use Gui2Client_Communication;

package Contact_Window is

   type ContactWindow is new Client_Window.Window with record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
   end record;
   GladeFile : constant String := "client/Contact_Window.glade";

   type WindowPtr is access all ContactWindow'Class;

   procedure Search_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Update_Status  (Object : access Gtkada_Builder_Record'Class);
   procedure Add_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Offline_Contact_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Online_Contact_Action  (Object : access Gtkada_Builder_Record'Class);

   Instance : WindowPtr;
private

   procedure Init(This : in out ContactWindow);

end Contact_Window;
