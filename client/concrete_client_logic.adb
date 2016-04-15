with GNAT.Sockets; use GNAT.Sockets;
with Ada.Streams; use Ada.Streams;

package body Concrete_Client_Logic is

   Server_IP : Unbounded_String;
   Client  : Socket_Type;
   Address : Sock_Addr_Type;
   Channel : Stream_Access;

   Send   : String := (1 => ASCII.CR, 2 => ASCII.LF,
                       3 => ASCII.CR, 4 => ASCII.LF);

   Offset : Ada.Streams.Stream_Element_Count;
   Data   : Ada.Streams.Stream_Element_Array (1 .. 256);

   procedure connectToServer(This : in out Concrete_Client) is

   begin

      GNAT.Sockets.Initialize;
      Create_Socket (Client);
      Address.Addr := Inet_Addr("127.0.0.1");
      Address.Port := 80;

      Connect_Socket (Client, Address);
      Channel := Stream (Client);

   end connectToServer;



   procedure disconnectFromServer(This : in out Concrete_Client) is

   begin
      null;
   end disconnectFromServer;



   procedure sendMessage(This : in out Concrete_Client;
                         Message : out Communication_Object'Class) is

   begin

      String'Write (Channel, "Test-Message Test-Message Test-Message" & Send);

   end sendMessage;



   procedure readMessage(This : in out Concrete_Client;
                         Message : out Communication_Object'Class) is

   begin

      loop
      Ada.Streams.Read (Channel.All, Data, Offset);
      exit when Offset = 0;
      for I in 1 .. Offset loop
         Ada.Text_IO.Put (Character'Val (Data (I)));
      end loop;
      end loop;

   end readMessage;

end Concrete_Client_Logic;
