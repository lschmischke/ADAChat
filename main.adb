with Concrete_Server_Logic; use Concrete_Server_Logic;
with Concrete_Client_Logic; use Concrete_Client_Logic;
with Concrete_Client_Ui; use Concrete_Client_Ui;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Protocol; use Protocol;
with Client_Window;
with Client2Gui_Communication; use Client2Gui_Communication;
with Gui2Client_Communication; use Gui2Client_Communication;
with ServerGuiEntryPoint; use ServerGuiEntryPoint;

procedure main is

begin
   --ServerGuiEntryPoint.ServerGuiEntryPoint;

   Concrete_Client_Ui.Instance    := new Concrete_Ui;
   Concrete_Client_Logic.Instance := new Concrete_Client;
   Concrete_Client_Logic.Instance.InitializeGUI (GUIPtr    (Concrete_Client_Ui.Instance));
   Concrete_Client_Ui.Instance.initClientUI     (ClientPtr (Concrete_Client_Logic.Instance));
end main;
