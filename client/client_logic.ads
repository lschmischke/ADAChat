

package Client_Logic is

   type Client_Interface is interface;

   procedure connectToServer(This : in out Client_Interface) is abstract;
   procedure disconnectFromServer(This : in out Client_Interface) is abstract;

end client_logic;
