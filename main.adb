with client_logic;
with Concrete_Server_Logic; use Concrete_Server_Logic;
with client_ui;
with Ada.Strings.Unbounded;


procedure main is
   --server : Concrete_Server_Ptr := new Concrete_Server;
   cserver : Concrete_Server;
      pragma Unreferenced(cserver);
begin
   --Data_Types_Test.Test;
   -- Server_Ui.Start_Server(server);
   --Concrete_Server_Logic.StartNewServer(cserver,"127.0.0.1",12321);
   cserver.startServer("127.0.0.1",12321);

end main;
