with Server_Logic; use Server_Logic;
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.IO_Exceptions;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;
with GNAT.String_Split; use GNAT.String_Split;

package Concrete_Server_Logic is

   task type Client_Task is
      entry Start(Socket : Socket_Type; SocketAddress : Sock_Addr_Type);
   end;
   type Client_Task_Ptr is access Client_Task;

   type Concrete_Client is record
      Username : Unbounded_String;
      Socket : Socket_Type;
      SocketAddress : Sock_Addr_Type;
      CommunicationTask : Client_Task_Ptr;
   end record;
   type Concrete_Client_Ptr is access Concrete_Client;

   package Client_List is new Doubly_Linked_Lists(Element_Type => Concrete_Client_Ptr);

   --type Concrete_Server is new Server_Interface with record
   type Concrete_Server is record
     Socket : Socket_Type;
     SocketAddress : Sock_Addr_Type;
     Connected_Clients : Client_List.List;
   end record;
   type Concrete_Server_Ptr is access Concrete_Server;

   --overriding --optional
   procedure dummy1(This : in out Concrete_Server_Ptr);

   procedure InitializeServer(This : in out Concrete_Server_Ptr);

   procedure dummy3(This : in out Concrete_Server_Ptr);

   task Main_Server_Task is
      entry Start;
      --entry Stop;
   end;

end Concrete_Server_Logic;
