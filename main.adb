with client_logic;
with Server_Logic;
with Concrete_Server_Logic; use Concrete_Server_Logic;
with Client_Ui;
with Server_Ui;
with Ada.Strings.Unbounded;


procedure main is
   server : Concrete_Server_Ptr := new Concrete_Server;
begin
   --Data_Types_Test.Test;
   -- Server_Ui.Start_Server(server);
   Concrete_Server_Logic.StartServer(server);
   Client_Ui.initClientUI;
end main;
