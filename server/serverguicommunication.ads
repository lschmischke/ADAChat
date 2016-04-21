package ServerGUICommunication is
   type Server is interface;

   procedure startServer(thisServer : aliased in Server; ipAdress: String; port : Natural) is abstract;
   procedure kickUserWithName(thisServer : aliased in Server;username:String) is abstract;
   procedure stopServer(thisServer : aliased in  Server) is abstract;
   function getNumberOfConnectedUsers(thisServer :aliased Server) return Natural is abstract;

end ServerGUICommunication;
