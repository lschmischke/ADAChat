package body Concrete_Client_Logic is

   procedure connectToServer(This : in out Client_Interface) is null;
   procedure disconnectFromServer(This : in out Client_Interface) is null;
   procedure sendMessage(This : in out Client_Interface;
           Message : out Communication_Object'Class) is null;

end Concrete_Client_Logic;
