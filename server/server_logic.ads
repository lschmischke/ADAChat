with Communication_Objects; use Communication_Objects;

package Server_Logic is

   type Server_Interface is interface;

   procedure dummy1(This : in out Server_Interface) is abstract;
   procedure InitializeServer(This : in out Server_Interface) is abstract;
   procedure dummy3(This : in out Server_Interface) is abstract;

end Server_Logic;
