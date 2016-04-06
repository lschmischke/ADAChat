with client_logic;
with Server_Logic;
with Concrete_Server_Logic; use Concrete_Server_Logic;
with client_ui;
with Server_Ui;
with Communication_Objects.Files;
with Communication_Objects.Messages;
with Communication_Objects.Messages.Disconnect;
with Communication_Objects.Messages.Connect;
with Communication_Objects.Messages.Refuse;
with Communication_Objects.Messages.Userlist;
with Ada.Strings.Unbounded;
with Data_Types_Test; use Data_Types_Test;

procedure main is
   server : Concrete_Server;
begin
   Data_Types_Test.Test;
   Server_Ui.Start_Server(server);
end main;
