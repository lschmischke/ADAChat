with Server_Logic; use Server_Logic;

package Concrete_Server_Logic is

   type Concrete_Server is new Server_Interface with record
      null;
   end record;

   overriding --optional
   procedure dummy1(This : in out Concrete_Server);

   procedure dummy2(This : in out Concrete_Server);

   procedure dummy3(This : in out Concrete_Server);

end Concrete_Server_Logic;
