with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.Sockets; use GNAT.Sockets;

package Client_Logic is

   type Client_Interface is interface;

   procedure connectToServer(This : in out Client_Interface; UserName : in Unbounded_String; Password : in Unbounded_String;
                             ServerAdress : in Unbounded_String; ServerPort : in Port_Type) is abstract;

   procedure disconnectFromServer(This : in out Client_Interface; UserName : in Unbounded_String;
                                  Msg : in Unbounded_String) is abstract;

end client_logic;
