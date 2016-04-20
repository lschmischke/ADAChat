package body Concrete_Client_Logic is

   Client : Socket_Type;
   Address : Sock_Addr_Type;
   Channel : Stream_Access;

--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------

   procedure DisconnectFromServer(This : in out Concrete_Client; UserName : in Unbounded_String;
                                  Msg : in Unbounded_String) is

      DisconnectMessage : MessageObject;

   begin

      --DisconnectMessage erzeugen
      DisconnectMessage := createMessage(messagetype => Protocol.Disconnect,
                                         sender      => UserName,
                                         receiver    => 0,
                                         content     => Msg);

      --DisconnectMessage nach Protokoll an Server
      WriteMessageToStream(ClientSocket => Client,
                           message      => DisconnectMessage);

      --Socket schliessen
      Close_Socket (Client);

   end DisconnectFromServer;

--------------------------------------------------------------------------------

   procedure RegisterAtServer(This : in out Concrete_Client; UserName : in Unbounded_String; Password : in Unbounded_String) is

      RegisterMessage : MessageObject;

   begin

      RegisterMessage := createMessage(messagetype => Register,
                                       sender      => UserName,
                                       receiver    => 0,
                                       content     => Password);

      WriteMessageToStream(ClientSocket => Client,
                           message      => RegisterMessage);

   end RegisterAtServer;

--------------------------------------------------------------------------------

   procedure RequestChatroom(This : in out Concrete_Client; UserName : in Unbounded_String; Id_Receiver : in Integer;
                             Participant : in Unbounded_String) is

      RequestMessage : MessageObject;

   begin

      RequestMessage := createMessage(messagetype => Register,
                                       sender      => UserName,
                                       receiver    => Id_Receiver,
                                       content     => Participant);

      WriteMessageToStream(ClientSocket => Client,
                           message      => RequestMessage);

   end RequestChatroom;

--------------------------------------------------------------------------------

   procedure LeaveChatroom(This : in out Concrete_Client; UserName : in Unbounded_String; Id_Receiver : in Integer;
                           Message : in Unbounded_String) is

      LeaveMessage : MessageObject;

   begin

      LeaveMessage := createMessage(messagetype => Register,
                                       sender      => UserName,
                                       receiver    => Id_Receiver,
                                       content     => Message);

      WriteMessageToStream(ClientSocket => Client,
                           message      => LeaveMessage);

   end LeaveChatroom;

--------------------------------------------------------------------------------

   procedure SendTextMessage(This : in out Concrete_Client; Username : in Unbounded_String;
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

   end SendTextMessage;

--------------------------------------------------------------------------------

   function ReadFromServer(This : in out Concrete_Client; ServerSocket : in Socket_Type) return Unbounded_String is

      MsgObject : MessageObject;

      Msg : Unbounded_String;

   begin

      MsgObject := readMessageFromStream(ClientSocket => Client);

      Msg := This.ProcessMessageObject(MsgObject);

      return Msg;

   end ReadFromServer;

--------------------------------------------------------------------------------

   function ProcessMessageObject(This : in out Concrete_Client; MsgObject : in MessageObject) return Unbounded_String is

   begin

      case MsgObject.Messagetype is

         when Connect =>
               --TODO
            null;
         when Chat =>
            --TODO
            null;
         when Refused =>
            --TODO
            null;
         when Disconnect =>
            --TODO
            null;
         when Online =>
            --TODO
            null;
         when Offline =>
            --TODO
            null;
         when Chatrequest =>
            --TODO
            null;
         when Userlist =>
            --TODO
            null;
         when Leavechat =>
            --TODO
            null;
         when Invalid =>
            --TODO
            null;
         when Register =>
            --TODO
            null;
      end case;

   end ProcessMessageObject;

--------------------------------------------------------------------------------

   procedure RefreshUserlist(This : in out Concrete_Client; User : in Unbounded_String) is

   begin
      null;
   end RefreshUserlist;

--------------------------------------------------------------------------------

end Concrete_Client_Logic;
