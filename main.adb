with client_logic;
with Server_Logic;
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
begin
  Data_Types_Test.Test;
end main;
