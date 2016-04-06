with Server_Logic; use Server_Logic;
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.IO_Exceptions;

package Concrete_Server_Logic is

   type Concrete_Server is new Server_Interface with record
      null;
   end record;

   overriding --optional
   procedure dummy1(This : in out Concrete_Server);

   procedure dummy2(This : in out Concrete_Server);

   procedure dummy3(This : in out Concrete_Server);

   task Main_Server_Task is
      entry Start;
      --entry Stop;
   end;

end Concrete_Server_Logic;
