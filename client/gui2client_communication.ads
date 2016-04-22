package Gui2Client_Communication is

   type Client is interface;

   procedure LoginUser(This : in Client) is abstract;

   procedure DisconnectUser(This : in Client) is abstract;

   procedure RegisterUser(This : in Client) is abstract;

   procedure InviteToGroupChat(This : in Client) is abstract;

   procedure SendMessageToChat(This : in Client) is abstract;

end Gui2Client_Communication;
