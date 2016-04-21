with client_logic;
with Concrete_Server_Logic; use Concrete_Server_Logic;
with client_ui;
with Ada.Strings.Unbounded;


procedure main is
   server : Concrete_Server_Ptr := new Concrete_Server;
begin
   --Data_Types_Test.Test;
   -- Server_Ui.Start_Server(server);
   Concrete_Server_Logic.StartServer(server);
end main;
