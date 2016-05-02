with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Protocol; use Protocol;
with GNAT.Sockets; use GNAT.Sockets;

limited with Client2Gui_Communication;

package Gui2Client_Communication is

   type Client is interface;
   type ClientPtr is access all Client'Class;

   procedure InitializeGUI(This : in out Client; Ptr : in Client2Gui_Communication.GUIPtr) is abstract;

   procedure InitializeSocket(This : in out Client; ServerAdress : in Unbounded_String;
                              ServerPort : in Port_Type) is abstract;

   -- In der GUI gibt es Einstellungen für Server Adresse und Port, eine Antwort vom Server muss immer verarbeitet werden
   procedure LoginUser (This : in out Client; Username : in Unbounded_String; Password : in Unbounded_String) is abstract;

   procedure DisconnectUser(This : in out Client; Username : in Unbounded_String; Message : in Unbounded_String) is abstract;

   -- Für die Registrierung sollte der entsprechende Server angegeben werden, auf dem sich registriert werden soll
   procedure RegisterUser(This : in out Client; Username : in Unbounded_String; Password : in Unbounded_String) is abstract;


   procedure InviteToGroupChat(This : in out Client; Username : in Unbounded_String; Receiver : in Integer;
                               Participant : in Unbounded_String) is abstract;

   procedure SendMessageToChat(This : in out Client; Receiver: in Integer; Username : in Unbounded_String;
                               Message : in Unbounded_String) is abstract;

end Gui2Client_Communication;
