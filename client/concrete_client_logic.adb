package body Concrete_Client_Logic is

   Client : Socket_Type;
   Address : Sock_Addr_Type;
   Channel : Stream_Access;


   procedure ConnectToServer(This : in out Concrete_Client; UserName : in Unbounded_String;
                             Password : in Unbounded_String; ServerAdress : in Unbounded_String;
                             ServerPort : in Port_Type) is

      ConnectMessage : MessageObject;

   begin

      --Socket initialisieren und erzeugen
      Create_Socket (Client);
      Address.Addr := Inet_Addr(To_String(ServerAdress));
      Address.Port := ServerPort;
      This.Socket := Client;
      Connect_Socket (Client, Address);
      Channel := Stream (Client);

      --ConnectMessage erzeugen
      ConnectMessage := createMessage(messagetype => Protocol.Connect,
                                      sender      => UserName,
                                      receiver    => 0,
                                      content     => Password);

      --ConnectMessage nach Protokoll an Server
      writeMessageToStream(ClientSocket => Client,
                           message      => ConnectMessage);

   end ConnectToServer;



   procedure DisconnectFromServer(This : in out Concrete_Client; UserName : in Unbounded_String;
                                  Id_Receiver : in Integer; Msg : in Unbounded_String) is

      DisconnectMessage : MessageObject;

   begin

      --DisconnectMessage erzeugen
      DisconnectMessage := createMessage(messagetype => Protocol.Disconnect,
                                         sender      => UserName,
                                         receiver    => Id_Receiver,
                                         content     => Msg);

      --DisconnectMessage nach Protokoll an Server
      writeMessageToStream(ClientSocket => Client,
                           message      => DisconnectMessage);

      --Socket schliessen
      Close_Socket (Client);

   end DisconnectFromServer;


   procedure SendMessage(This : in out Concrete_Client; Username : in Unbounded_String;
                         Id_Receiver : in Integer; Msg : in Unbounded_String) is

      Message : MessageObject;

   begin

      --Message erzeugen
      Message := createMessage(messagetype => Protocol.Chat,
                               sender      => Username,
                               receiver    => Id_Receiver,
                               content     => Msg);

      --Message nach Protokoll an Server
      WriteMessageToStream(ClientSocket => Client,
                           message      => Message);

   end SendMessage;


   procedure ReadFromServer(This : in out Concrete_Client; ServerSocket : in Socket_Type) is

      MsgObject : MessageObject;

   begin

      MsgObject := readMessageFromStream(ClientSocket => Client);

      This.ProcessMessageObject(MsgObject);

   end ReadFromServer;


   procedure ProcessMessageObject(This : in out Concrete_Client; MsgObject : in MessageObject) is

   begin

      case MsgObject.Messagetype is

         when Connect => null;
         when Chat => null;
         when Refused => null;
         when Disconnect => null;
         when Online => null;
         when Offline => null;
         when Chatrequest => null;
         when Userlist => null;
         when Leavechat => null;
         when Invalid => null;
         when Register => null;
      end case;

   end ProcessMessageObject;


end Concrete_Client_Logic;
