with Client_Logic; use Client_Logic;
with Communication_Objects; use Communication_Objects;
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.IO_Exceptions;


package Concrete_Client_Logic is

   type Concrete_Client is new Client_Interface with record
      null;
   end record;

   procedure connectToServer(This : in out Concrete_Client);

   procedure disconnectFromServer(This : in out Concrete_Client);

   procedure sendMessage(This : in out Concrete_Client);

   procedure readMessage(This : in out Concrete_Client);

end Concrete_Client_Logic;
