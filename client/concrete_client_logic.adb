with GNAT.String_Split; use GNAT.String_Split;
package body Concrete_Client_Logic is

   Client : Socket_Type;
   Address : Sock_Addr_Type;
   Channel : Stream_Access;

   procedure init(This : in out Concrete_Client; Ui_Instance : Ui_Ptr)is
   begin
      This.ui := Ui_Instance;
   end init;
   --------------------------------------------------------------------------------

   procedure ConnectToServer(This : in out Concrete_Client; UserName : in Unbounded_String;
                             Password : in Unbounded_String; ServerAdress : in Unbounded_String;
                             ServerPort : in Port_Type) is

      ConnectMessage : MessageObject;

   begin
      --Instance.AddOnlineUser(UserName => To_Unbounded_String("Testus"));
      --#Socket initialisieren und erzeugen#
      Create_Socket (Client);
      Address.Addr := Inet_Addr(To_String(ServerAdress));
      Address.Port := ServerPort;
      This.Socket := Client;
      Connect_Socket (Client, Address);
      Channel := Stream (Client);

      --#ConnectMessage erzeugen#
      ConnectMessage := createMessage(messagetype => Protocol.Connect,
                                      sender      => UserName,
                                      receiver    => ServerID,
                                      content     => Password);

      --#ConnectMessage nach Protokoll an Server#
      writeMessageToStream(ClientSocket => Client,
                           message      => ConnectMessage);

   exception
      when Error : Socket_Error =>
         Put ("Socket_Error in ConnectToServer: ");
         Put_Line (Exception_Information (Error));
      when Error : others =>
         Put ("Unexpected exception in ConnectToServer: ");
         Put_Line (Exception_Information (Error));

   end ConnectToServer;

   --------------------------------------------------------------------------------

   procedure DisconnectFromServer(This : in out Concrete_Client; UserName : in Unbounded_String;
                                  Msg : in Unbounded_String) is

      DisconnectMessage : MessageObject;

   begin

      --#DisconnectMessage erzeugen#
      DisconnectMessage := createMessage(messagetype => Protocol.Disconnect,
                                         sender      => UserName,
                                         receiver    => ServerID,
                                         content     => Msg);

      --#DisconnectMessage nach Protokoll an Server#
      WriteMessageToStream(ClientSocket => Client,
                           message      => DisconnectMessage);

   end DisconnectFromServer;

   --------------------------------------------------------------------------------

   procedure RegisterAtServer(This : in out Concrete_Client; Username : in Unbounded_String; Password : in Unbounded_String;
                          ServerAdress : in Unbounded_String; ServerPort : in Port_Type;
                          AnswerFromServer : out MessageObject) is

      RegisterMessage : MessageObject;

   begin

      RegisterMessage := createMessage(messagetype => Register,
                                       sender      => UserName,
                                       receiver    => ServerID,
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

      Message := createMessage(messagetype => Protocol.Chat,
                               sender      => Username,
                               receiver    => Id_Receiver,
                               content     => Msg);

      WriteMessageToStream(ClientSocket => Client,
                           message      => Message);

   end SendTextMessage;

   --------------------------------------------------------------------------------

   procedure SendMessageObject(This : in out Concrete_Client; Username : in Unbounded_String;
                               Id_Receiver : in Integer; MsgObject : in MessageObject) is


   begin

      WriteMessageToStream(ClientSocket => Client,
                           message      => MsgObject);

   end SendMessageObject;

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
            This.ServerRoomId := MsgObject.Receiver;
            return To_Unbounded_String("Die Verbindung wurde hergestellt!");

         when Chat =>

            --#Ist ID bekannt, bin ich schon im Chatroom
            --#wenn ja, zeige Message in diesem Chatraum
            --#wenn nein, lege Chatraum an und oeffne guifenster

            if This.ChatRoomIdSet.Contains(Item => MsgObject.Receiver) then
               --#TODO#
               --#zeige Message im Chatraum an
               null;
            else
               This.ChatRoomIdSet.Insert(New_Item => MsgObject.Receiver);
               --#TODO
               --#oeffne neues Chatfenster
            end if;

            return MsgObject.Content;

         when Refused =>
            declare
               Message: Unbounded_String;
            begin

               --#TODO
               --#1.refused wenn kein Serverconnect
               --#2. wenn name oder pw falsch
               --#3. user schon eingeloggt
               --#4. wenn einladung in illegalem Chatraum

               Message := To_Unbounded_String("Refused: ");
               Append(Message, MsgObject.Content);
               return Message;
            end;

         when Disconnect =>
            declare
               Message : Unbounded_String;
            begin
               Close_Socket(Client);
               --#TODO TODO TODO
               --#Fenster entsprechend schliessen

               --#Userliste löschen#--
               This.UsersOnline.Clear;
               This.UsersOffline.Clear;

               if MsgObject.Content = "ok"  then
                  return To_Unbounded_String("Die Verbindung wurde beendet!");
               else
                  Message := To_Unbounded_String("You were kicked: ");
                  Append(Message, MsgObject.Content);
                  return Message;
               end if;
            end;

         when Online =>
            declare
               Message: Unbounded_String;
            begin
               Message := MsgObject.Content;
               Append(Message, " ist jetzt online!");
               This.UsersOnline.Insert(MsgObject.Content);
               if This.UsersOffline.Contains(Item => MsgObject.Content) then
                  This.UsersOffline.Delete(Item => MsgObject.Content);
               end if;
               --#TODOTODO refreshUserlist()
               return Message;
            end;

         when Offline =>
            declare
               Message: Unbounded_String;
            begin
               Message := MsgObject.Content;
               Append(Message, " ist jetzt offline!");
               This.UsersOffline.Insert(MsgObject.Content);
               if This.UsersOnline.Contains(Item => MsgObject.Content) then
                  This.UsersOnline.Delete(Item => MsgObject.Content);
               end if;
               --#TODOTODO refreshUserlist()
               return Message;
            end;

         when Chatrequest =>
            declare
               Message: Unbounded_String;
            begin
               Message := To_Unbounded_String("Chatraum :");
               Append(Message, Integer'Image(MsgObject.Receiver));
               This.ChatRoomIdSet.Insert(New_Item => MsgObject.Receiver);
               --##TODO Chatfenster oeffnen
               return Message;
            end;

         when Protocol.Userlist =>
            declare
               Substrings : GNAT.String_Split.Slice_Set;
               UserSet : Userlist.Set;
            begin
               GNAT.String_Split.Create (S => Substrings,
                                         From       => To_String(MsgObject.Content),
                                         Separators => Protocol.Seperator,
                                         Mode       => GNAT.String_Split.Single);

               for I in 1 .. GNAT.String_Split.Slice_Count (Substrings) loop
                  UserSet.Insert(New_Item => To_Unbounded_String(GNAT.String_Split.Slice (Substrings, I)));
               end loop;
               This.ChatRoomParticipants.Insert(Key      => MsgObject.Receiver,
                                                New_Item => UserSet);
            end;

         when Leavechat =>
            --#TODO
            --#verlasse Chatraum, schliesse Chatfenster
            return MsgObject.Content;

         when AddContact =>
            --#TODO
            --#anfrage mitteilen, bestaetigen oder ablehnen
            null;
         when RemContact =>
            --#TODO
            --freund loeschen oder freundesanfrage ablehnen
            null;
         when others =>
            null;
      end case;

      return To_Unbounded_String("abcdfg");

   end ProcessMessageObject;

   --------------------------------------------------------------------------------

   procedure RefreshUserlist(This : in out Concrete_Client; User : in Unbounded_String) is

   begin
      null;
   end RefreshUserlist;

   --------------------------------------------------------------------------------

   function SearchFriendList(This : in out Concrete_Client; User : in Unbounded_String) return Boolean is

   begin
      return False;
   end SearchFriendList;

   function Hash (R : Natural) return Hash_Type is
   begin
      return Hash_Type (R);
   end Hash;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------

   procedure LoginUser(This : in out Concrete_Client; Username : in Unbounded_String; Password : in Unbounded_String;
                       ServerAdress : in Unbounded_String; ServerPort : in Port_Type;
                       AnswerFromServer : out MessageObject) is

   begin
      This.ConnectToServer(UserName     => Username,
                           Password     => Password,
                           ServerAdress => To_Unbounded_String("127.0.0.1"),
                           ServerPort   => 12321);
      AnswerFromServer := readMessageFromStream(ClientSocket => Client);
   end LoginUser;

   -----------------------------------------------------------------------------

   procedure DisconnectUser(This : in out Concrete_Client; Username : in Unbounded_String; Message : in Unbounded_String) is

   begin
      This.DisconnectFromServer(UserName => Username,
                                Msg      => Message);
   end DisconnectUser;

   -----------------------------------------------------------------------------

   procedure RegisterUser(This : in out Concrete_Client; Username : in Unbounded_String; Password : in Unbounded_String;
                          ServerAdress : in Unbounded_String; ServerPort : in Port_Type;
                          AnswerFromServer : out MessageObject) is

   begin
      This.RegisterAtServer(UserName => Username,
                            Password => Password,
                            ServerAdress => ServerAdress,
                            ServerPort => ServerPort,
                            AnswerFromServer => AnswerFromServer); --#TODO ENCODE EINFUEGEN
   end RegisterUser;

   -----------------------------------------------------------------------------

   procedure InviteToGroupChat(This : in out Concrete_Client; Username : in Unbounded_String; Receiver : in Integer;
                               Participant : in Unbounded_String) is

   begin
      This.RequestChatroom(UserName    => Username,
                           Id_Receiver => Receiver,
                           Participant => Participant);
   end InviteToGroupChat;

   -----------------------------------------------------------------------------

   procedure SendMessageToChat(This : in out Concrete_Client; Receiver: in Integer; Username : in Unbounded_String;
                               Message : in Unbounded_String) is

   begin

      This.SendTextMessage(Username    => Username,
                           Id_Receiver => Receiver,
                           Msg         => Message);
   end SendMessageToChat;

   -----------------------------------------------------------------------------

end Concrete_Client_Logic;
