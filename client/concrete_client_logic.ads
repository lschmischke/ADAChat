with Client_Logic; use Client_Logic;

package Concrete_Client_Logic is

   type Concrete_Client is new Client_Interface;

   procedure connectToServer(This : in out Client_Interface);
   procedure disconnectFromServer(This : in out Client_Interface);
   procedure sendMessage(This : in out Client_Interface;
           Message : out Communication_Object'Class);

end Concrete_Client_Logic;
