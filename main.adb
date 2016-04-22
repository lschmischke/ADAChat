with client_logic;
with Concrete_Server_Logic; use Concrete_Server_Logic;
<<<<<<< HEAD
with Client_Ui;
with Server_Ui;
with Ada.Strings.Unbounded;
=======
with Concrete_Client_Logic; use Concrete_Client_Logic;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Protocol; use Protocol;
>>>>>>> origin/feature/Client_Logic


procedure main is

   cserver : Concrete_Server;
   Client : Concrete_Client_Logic.Concrete_Client;
   Msg : MessageObject;

begin
<<<<<<< HEAD
   --Data_Types_Test.Test;
   -- Server_Ui.Start_Server(server);
   Concrete_Server_Logic.StartServer(server);
   Client_Ui.initClientUI;
=======

   cserver.startServer("127.0.0.1",12321);

   Client.connectToServer(To_Unbounded_String("a"), To_Unbounded_String("a"),
                          To_Unbounded_String("127.0.0.1"), 12321);

   msg := readMessageFromStream(ClientSocket => Client.Socket);
   printMessageToInfoConsole(msg);

   Client.SendTextMessage(Username    => To_Unbounded_String("a"),
                          Id_Receiver => 2,
                          Msg         => To_Unbounded_String("Hallo Ewald"));

   loop
   msg := readMessageFromStream(ClientSocket => Client.Socket);
      printMessageToInfoConsole(msg);
      end loop;

>>>>>>> origin/feature/Client_Logic
end main;
