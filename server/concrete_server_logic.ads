with Server_Logic; use Server_Logic;

package Concrete_Server_Logic is

   type Concrete_Server is new Server_Interface with record
      null;
   end record;

   procedure dummy1(This : in out Server_Interface);

   procedure dummy2(This : in out Server_Interface);

   procedure dummy3(This : in out Server_Interface);

end Concrete_Server_Logic;
