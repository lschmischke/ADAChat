with Client_Logic; use Client_Logic;
with Communication_Objects; use Communication_Objects;


package Concrete_Client_Logic is

   type Concrete_Client is new Client_Interface with record
      null;
   end record;

   procedure connectToServer(This : in out Concrete_Client);
   procedure disconnectFromServer(This : in out Concrete_Client);
   procedure sendMessage(This : in out Concrete_Client;
           Message : out Communication_Object'Class);

end Concrete_Client_Logic;
