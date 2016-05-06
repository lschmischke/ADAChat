with Concrete_Server_Logic; use Concrete_Server_Logic;
with Concrete_Client_Logic; use Concrete_Client_Logic;
with Concrete_Client_Ui; use Concrete_Client_Ui;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Protocol; use Protocol;
with Client_Window;
with Client2Gui_Communication; use Client2Gui_Communication;
with Gui2Client_Communication; use Gui2Client_Communication;
with ServerGuiEntryPoint; use ServerGuiEntryPoint;

procedure server is

begin
   ServerGuiEntryPoint.ServerGuiEntryPoint;
end server;
