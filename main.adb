with ServerGuiEntryPoint;
with ClientGUIEntrypoint;

procedure main is

begin
<<<<<<< HEAD
   --ServerGuiEntryPoint.ServerGuiEntryPoint;
   ClientGUIEntrypoint.ClientGUIEntrypoint;
=======
   Concrete_Client_Ui.Instance    := new Concrete_Ui;
   Concrete_Client_Logic.Instance := new Concrete_Client;
   Concrete_Client_Logic.Instance.InitializeGUI (GUIPtr    (Concrete_Client_Ui.Instance));
   Concrete_Client_Ui.Instance.initClientUI     (ClientPtr (Concrete_Client_Logic.Instance));
>>>>>>> origin/feature/Client_Logic
end main;
