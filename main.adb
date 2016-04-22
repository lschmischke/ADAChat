with client_logic;
with Concrete_Server_Logic; use Concrete_Server_Logic;
with Concrete_Client_Logic; use Concrete_Client_Logic;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Protocol; use Protocol;


procedure main is
<<<<<<< HEAD

   cserver : Concrete_Server;
   Client : Concrete_Client_Logic.Concrete_Client;
   Msg : MessageObject;

=======
   --server : Concrete_Server_Ptr := new Concrete_Server;
      cserver : Concrete_Server;
     -- pragma Unreferenced(cserver);
>>>>>>> origin/feature/server_logic
begin

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

end main;
