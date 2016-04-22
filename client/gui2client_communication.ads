with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Gui2Client_Communication is

   type Client is interface;

   procedure LoginUser(This : in out Client; Username : in Unbounded_String; Password : in Unbounded_String) is abstract;

   procedure DisconnectUser(This : in out Client; Username : in Unbounded_String; Message : in Unbounded_String) is abstract;

   procedure RegisterUser(This : in out Client; Username : in Unbounded_String; Password : in Unbounded_String) is abstract;

   procedure InviteToGroupChat(This : in out Client; Username : in Unbounded_String; Receiver : in Integer;
                               Participant : in Unbounded_String) is abstract;

   procedure SendMessageToChat(This : in out Client; Receiver: in Integer; Username : in Unbounded_String;
                               Message : in Unbounded_String) is abstract;

end Gui2Client_Communication;
