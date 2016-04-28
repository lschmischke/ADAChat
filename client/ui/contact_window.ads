with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Client_Window;
with Concrete_Client_Logic;

package Contact_Window is

   type ContactWindow is new Client_Window.Window with record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
      Client : Concrete_Client_Logic.Concrete_Client;
   end record;
   GladeFile : constant String := "Contact_Window.glade";

   procedure Search_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Update_Status  (Object : access Gtkada_Builder_Record'Class);
   procedure Add_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Offline_Contact_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Online_Contact_Action  (Object : access Gtkada_Builder_Record'Class);

private

   procedure Init(This : in out ContactWindow; Client_Instance : Concrete_Client_Logic.Concrete_Client);

   Instance : ContactWindow;

end Contact_Window;
