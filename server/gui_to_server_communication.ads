with Ada.Text_IO; use Ada.Text_IO;

package GUI_to_Server_Communication is
   type Server is interface;

   procedure startServer(thisServer : aliased in Server; ipAdress: String; port : Natural) is abstract;
   procedure stopServer(thisServer : aliased in  Server) is abstract;
   function loadDB(thisServer : aliased in Server; DataFile : File_type) return Boolean is abstract;
   procedure saveDB(thisServer : aliased in Server; DataFile : File_type) is abstract;
   procedure closeServer(thisServer : aliased in Server) is abstract;
   procedure sendMessageToUser(thisServer : aliased in Server; username : String; messagestring : String) is abstract;
   procedure deleteUserFromDatabase(thisServer : aliased in Server; username : String) is abstract;
   procedure kickUserWithName(thisServer : aliased in Server; username:String) is abstract;


end GUI_to_Server_Communication;
