with Concrete_Server_Logic; use Concrete_Server_Logic;
with Concrete_Client_Logic; use Concrete_Client_Logic;
with Concrete_Client_Ui; use Concrete_Client_Ui;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Protocol; use Protocol;
with Client_Window;
with Client2Gui_Communication; use Client2Gui_Communication;
with Gui2Client_Communication; use Gui2Client_Communication;

procedure main is

   cserver : Concrete_Server;
   Client : ClientPtr := new Concrete_Client_Logic.Concrete_Client;
   Msg : MessageObject;
   ui : Concrete_Client_Ui.Concrete_Ui;

begin
   --cserver.startServer("127.0.0.1",12321);

   ui.initClientUI(Client_Instance => Client);

   --Client.connectToServer(To_Unbounded_String("a"), To_Unbounded_String("a"),
   --                       To_Unbounded_String("127.0.0.1"), 12321);

   --msg := readMessageFromStream(ClientSocket => Client.Socket);
   --printMessageToInfoConsole(msg);

   --Client.SendTextMessage(Username    => To_Unbounded_String("a"),
   --                       Id_Receiver => 2,
   --                       Msg         => To_Unbounded_String("Hallo Ewald"));

   --loop
   --msg := readMessageFromStream(ClientSocket => Client.Socket);
   --   printMessageToInfoConsole(msg);
   --   end loop;

end main;
