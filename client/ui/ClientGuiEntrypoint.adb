package body ClientGUIEntrypoint is
   procedure ClientGUIEntrypoint is
   begin
      --  Initialize GtkAda.
      Gtk.Main.Init;
      Concrete_Client_Ui.Instance    := new Concrete_Ui;
      Concrete_Client_Logic.Instance := new Concrete_Client;
      Concrete_Client_Logic.Instance.InitializeGUI (GUIPtr    (Concrete_Client_Ui.Instance));
      Concrete_Client_Ui.Instance.initClientUI     (ClientPtr (Concrete_Client_Logic.Instance));
      --  Start the Gtk+ main loop
      Gtk.Main.Main;
      Unref(Concrete_Client_Ui.Instance.Login_Window.Builder);
      Unref(Concrete_Client_Ui.Instance.Contact_Window.Builder);
   end ClientGUIEntrypoint;
end ClientGUIEntrypoint;
