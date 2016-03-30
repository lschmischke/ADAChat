with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;

package body Concrete_Client_Logic is

   procedure connectToServer(This : in out Concrete_Client) is

   begin
      null;
   end connectToServer;

   procedure disconnectFromServer(This : in out Concrete_Client) is

   begin
      null;
   end disconnectFromServer;

   procedure sendMessage(This : in out Concrete_Client;
                         Message : out Communication_Object'Class) is

   begin
      null;
   end sendMessage;

end Concrete_Client_Logic;
