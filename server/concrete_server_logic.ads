with Server_Logic; use Server_Logic;

package Concrete_Server_Logic is

   type Concrete_Server is new Server_Interface with record
      null;
   end record;

   overriding procedure dummy1(This : in out Server_Interface);

   overriding procedure dummy2(This : in out Server_Interface);

   overriding procedure dummy3(This : in out Server_Interface);

end Concrete_Server_Logic;
