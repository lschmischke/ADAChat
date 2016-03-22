with Communication_Objects; use Communication_Objects;

package Client_Logic is

   type Client_Interface is interface;

   procedure connectToServer(This : in out Client_Interface) is abstract;
   procedure disconnectFromServer(This : in out Client_Interface) is abstract;
   procedure sendMessage(This : in out Client_Interface;
           Message : out Communication_Object'Class) is abstract;

end client_logic;
