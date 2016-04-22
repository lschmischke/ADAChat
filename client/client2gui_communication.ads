package Client2Gui_Communication is

   type GUI is interface;

   procedure UpdateOnlineUsers(This : in GUI) is abstract;

   procedure UpdateOfflineUsers(This : in GUI) is abstract;

   procedure ShowChatMessages(This : in GUI) is abstract;

   end Client2Gui_Communication;
