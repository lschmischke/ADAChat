--Spezifikation des Fensters mit Kontaktliste

with Glib; use Glib;
with Gtkada.Builder; use Gtkada.Builder;
with Gtk.Window;       use Gtk.Window;
with Gtk.List_Store; use Gtk.List_Store;
with Client_Window;
limited with Concrete_Client_Logic;
with Client2Gui_Communication; use Client2Gui_Communication;
with Gui2Client_Communication; use Gui2Client_Communication;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Contact_Window is

   type ContactWindow is new Client_Window.Window with record
      Builder : Gtkada_Builder;
      Window : Gtk_Window;
      onlineList: Gtk_List_Store;
   end record;
   type WindowPtr is access all ContactWindow'Class;
   
   --#GladeFile aus der das Fenster generiert wird
   GladeFile : constant String := "client/Contact_Window.glade";

   -- Callback für das Suchfeld (nicht implementiert)
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Search_Action  (Object : access Gtkada_Builder_Record'Class);
   
   -- Callback für das Dropdown mit dem Status (nicht implementiert)
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Update_Status  (Object : access Gtkada_Builder_Record'Class);
   
   -- Callback für das Menüelement zum Hinzufügen von Kontakten (nicht implementiert)
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Add_Action  (Object : access Gtkada_Builder_Record'Class);
   
   -- Callback für das Doppelklicken eines Kontaktes in der Offline Liste
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Offline_Contact_Action  (Object : access Gtkada_Builder_Record'Class);
   
   -- Callback für das Doppelklicken eines Kontaktes in der Online Liste
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Online_Contact_Action  (Object : access Gtkada_Builder_Record'Class);
   
   -- Callback für das Doppelklicken eines Elements in der Kontaktanfragen Liste
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Request_Action (Object : access Gtkada_Builder_Record'Class);
   
   -- Callback für das Doppelklicken eines Elements in der Gruppenchat Liste
   -- Object => Builder des Fensters, das den Callback ausgelöst hat
   procedure Groupchat_Action (Object : access Gtkada_Builder_Record'Class);

   -- Hebt einen Kontakt in der Online Liste fett hervor
   -- This => Fenster, indem ein Kontakt hervorgehoben werden soll
   -- sender => Name des Kontakts, der hervorgehoben werden soll
   procedure Highlight(This : in out ContactWindow; sender : Unbounded_String);
   
   -- Hebt ein Element in der Gruppenchat Liste fett hervor
   -- This => Fenster, indem ein Kontakt hervorgehoben werden soll
   -- receiver => ID des Gruppenchats, der hervorgehoben werden soll
   procedure Highlight_Group(This : in out ContactWindow; receiver : Gint);

   Instance : WindowPtr;
private

   -- Muss ausgeführt werden, bevor Window verwendet werden kann
   -- This => Fenster, das initialisiert werden soll
   procedure Init(This : in out ContactWindow);

end Contact_Window;
