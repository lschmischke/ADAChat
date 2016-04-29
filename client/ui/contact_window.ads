with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Client_Window;
limited with Concrete_Client_Logic;

package Contact_Window is

   type ContactWindow is new Client_Window.Window with record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
      Client : Client_Window.Client_Ptr;
   end record;
   GladeFile : constant String := "Contact_Window.glade";

   procedure Search_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Update_Status  (Object : access Gtkada_Builder_Record'Class);
   procedure Add_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Offline_Contact_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Online_Contact_Action  (Object : access Gtkada_Builder_Record'Class);

private

   procedure Init(This : in out ContactWindow; Client_Instance : Client_Window.Client_Ptr);

   Instance : ContactWindow;

end Contact_Window;
