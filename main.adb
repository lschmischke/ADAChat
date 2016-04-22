with client_logic;
with Concrete_Server_Logic; use Concrete_Server_Logic;
with Concrete_Client_Logic; use Concrete_Client_Logic;
with client_ui;
<<<<<<< HEAD
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Protocol; use Protocol;


procedure main is

   Client : Concrete_Client_Logic.Concrete_Client;
   Server : Concrete_Server_Ptr := new Concrete_Server;
   Msg : MessageObject;

begin

   StartServer(server);

   Client.connectToServer(To_Unbounded_String("leo"), To_Unbounded_String("123"),
                          To_Unbounded_String("127.0.0.1"), 12321);

   msg := readMessageFromStream(ClientSocket => Client.Socket);
      printMessageToInfoConsole(msg);

=======
with Ada.Strings.Unbounded;


procedure main is
   --server : Concrete_Server_Ptr := new Concrete_Server;
   cserver : Concrete_Server;
begin
   --Data_Types_Test.Test;
   -- Server_Ui.Start_Server(server);
   --Concrete_Server_Logic.StartNewServer(cserver,"127.0.0.1",12321);
   cserver.startServer("127.0.0.1",12321);
>>>>>>> origin/feature/server_logic
end main;
