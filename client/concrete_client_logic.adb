--Implementierung der Client_Logic

--Includes
with GNAT.String_Split; use GNAT.String_Split;

package body Concrete_Client_Logic is

   Client : Socket_Type;
   Address : Sock_Addr_Type;
   Channel : Stream_Access;

   procedure InitializeGUI(This : in out Concrete_Client; Ptr : in GUIPtr) is

   begin

      This.GUI := Ptr;

   end InitializeGUI;

   -----------------------------------------------------------------------------

   procedure InitializeSocket(This : in out Concrete_Client; ServerAdress : in Unbounded_String;
                              ServerPort : in Port_Type) is

   begin
      --#Socket initialisieren und erzeugen#
      Create_Socket (Client);
      Address.Addr := Inet_Addr(To_String(ServerAdress));
      Address.Port := ServerPort;
      This.Socket := Client;
      Connect_Socket (Client, Address);
      Channel := Stream (Client);
      Server_Listener_Task.Start;
   end InitializeSocket;


   -----------------------------------------------------------------------------

   procedure ConnectToServer(This : in out Concrete_Client; UserName : in Unbounded_String;
                             Password : in Unbounded_String) is

      ConnectMessage : MessageObject;

   begin

      --#ConnectMessage erzeugen#
      ConnectMessage := createMessage(messagetype => Protocol.Connect,
                                      sender      => UserName,
                                      receiver    => ServerID,
                                      content     => Password);

      --#ConnectMessage nach Protokoll an Server#
      writeMessageToStream(ClientSocket => Client,
                           message      => ConnectMessage);

   end ConnectToServer;

   -----------------------------------------------------------------------------

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

   -----------------------------------------------------------------------------

   procedure RegisterAtServer(This : in out Concrete_Client; Username : in Unbounded_String; Password : in Unbounded_String) is

      RegisterMessage : MessageObject;

   begin

      RegisterMessage := createMessage(messagetype => Register,
                                       sender      => UserName,
                                       receiver    => ServerID,
                                       content     => Password);

      WriteMessageToStream(ClientSocket => Client,
                           message      => RegisterMessage);

   end RegisterAtServer;

   -----------------------------------------------------------------------------

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

   -----------------------------------------------------------------------------

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

   -----------------------------------------------------------------------------

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

   -----------------------------------------------------------------------------

   procedure SendMessageObject(This : in out Concrete_Client; Username : in Unbounded_String;
                               Id_Receiver : in Integer; MsgObject : in MessageObject) is


   begin

      WriteMessageToStream(ClientSocket => Client,
                           message      => MsgObject);

   end SendMessageObject;

   -----------------------------------------------------------------------------

   procedure ReadFromServer(This : in out Concrete_Client; ServerSocket : in Socket_Type) is

      MsgObject : MessageObject;
      Msg : Unbounded_String;
   begin

      MsgObject := readMessageFromStream(ClientSocket => Client);
      Protocol.printMessageToInfoConsole(MsgObject);
      This.ProcessMessageObject(MsgObject);

   end ReadFromServer;

   -----------------------------------------------------------------------------

   procedure ProcessMessageObject(This : in out Concrete_Client; MsgObject : in MessageObject) is

   begin
      case MsgObject.Messagetype is

         when Connect =>
            This.ServerRoomId := MsgObject.Receiver;
            This.GUI.LoginSuccess;
         when Chat =>

            --#Ist ID bekannt, bin ich schon im Chatroom
            --#wenn ja, zeige Message in diesem Chatraum
            --#wenn nein, lege Chatraum an und oeffne guifenster

            if This.ChatRoomIdSet.Contains(Item => MsgObject.Receiver) then
               --#TODO#
               --#zeige Message im Chatraum an
               null;
            else
               This.ChatRoomIdSet.Append(New_Item => MsgObject.Receiver);
               --#TODO
               --#oeffne neues Chatfenster
            end if;

         when Refused =>
            declare
               Message: Unbounded_String;
            begin
               --#1.refused wenn kein Serverconnect
               --#2. wenn name oder pw falsch
               --#3. user schon eingeloggt
               --#4. wenn Einladung in illegalem Chatraum
               Message := To_Unbounded_String("Refused: ");
               Append(Message, MsgObject.Content);
               This.GUI.RefusedMessage(Reason => Message);
            end;

         when Disconnect =>
            declare
               Message : Unbounded_String;
            begin
               Close_Socket(Client);

               --#Userliste löschen#--
               This.UsersOnline.Clear;
               This.UsersOffline.Clear;

               if MsgObject.Content = "ok"  then
                  This.GUI.DisconnectReason(Status => To_Unbounded_String("Die Verbindung wurde beendet!"));
               else
                  Message := To_Unbounded_String("You were kicked: ");
                  Append(Message, MsgObject.Content);
                  This.GUI.DisconnectReason(Status => Message);
               end if;
            end;

         when Online =>
            declare
               Message: Unbounded_String;
               Position: Client2Gui_Communication.Userlist.Cursor;
            begin
               Message := MsgObject.Content;
               Append(Message, " ist jetzt online!");
               This.UsersOnline.Append(MsgObject.Content);
               if This.UsersOffline.Contains(Item => MsgObject.Content) then
                  Position := This.UsersOffline.Find(Item => MsgObject.Content);
                  This.UsersOffline.Delete(Position);
                  This.GUI.SetOfflineUser(Users => This.UsersOffline);
               end if;
               This.GUI.SetOnlineUser(Users => This.UsersOnline);
            end;

         when Offline =>
            declare
               Message: Unbounded_String;
               Position: Client2Gui_Communication.Userlist.Cursor;
            begin
               Message := MsgObject.Content;
               Append(Message, " ist jetzt offline!");
               This.UsersOffline.Append(MsgObject.Content);
               if This.UsersOnline.Contains(Item => MsgObject.Content) then
                  Position := This.UsersOnline.Find(Item => MsgObject.Content);
                  This.UsersOnline.Delete(Position);
                  This.GUI.SetOnlineUser(Users => This.UsersOnline);
               end if;
               This.GUI.SetOfflineUser(Users => This.UsersOffline);
            end;

         when Chatrequest =>
            declare
               Message: Unbounded_String;
            begin
               Message := To_Unbounded_String("Chatraum :");
               Append(Message, Integer'Image(MsgObject.Receiver));
               This.ChatRoomIdSet.Append(New_Item => MsgObject.Receiver);

               --##TODO Chatfenster oeffnen

            end;

         when Protocol.Userlist =>
            declare
               Substrings : GNAT.String_Split.Slice_Set;
               UserSet : Client2Gui_Communication.Userlist.List;
            begin
               GNAT.String_Split.Create (S => Substrings,
                                         From       => To_String(MsgObject.Content),
                                         Separators => Protocol.Seperator,
                                         Mode       => GNAT.String_Split.Single);

               for I in 1 .. GNAT.String_Split.Slice_Count (Substrings) loop
                  UserSet.Append(New_Item => To_Unbounded_String(GNAT.String_Split.Slice (Substrings, I)));
               end loop;
               This.ChatRoomParticipants.Append(--Key      => MsgObject.Receiver,
                                                New_Item => UserSet);

               This.GUI.ShowChatParticipants(Chatraum     => MsgObject.Receiver,
                                             Participants => UserSet);
            end;

         when AddContact =>
            --#TODO
            This.GUI.ContactRequest(Username => MsgObject.Content);

         when RemContact =>
            --#TODO
            This.GUI.ContactRemove(Username => MsgObject.Content);

         when others =>
            null;

      end case;
   end ProcessMessageObject;

   -----------------------------------------------------------------------------

   procedure RefreshUserlist(This : in out Concrete_Client; User : in Unbounded_String) is

   begin
      null;
   end RefreshUserlist;

   -----------------------------------------------------------------------------

   function SearchFriendList(This : in out Concrete_Client; User : in Unbounded_String) return Boolean is

   begin
      return False;
   end SearchFriendList;

   -----------------------------------------------------------------------------
   function Hash (R : Natural) return Hash_Type is
   begin
      return Hash_Type (R);
   end Hash;

   -----------------------------------------------------------------------------
   -----------Implementierung des Gui2Client_Communication interfaces-----------
   -----------------------------------------------------------------------------

   procedure LoginUser(This : in out Concrete_Client; Username : in Unbounded_String; Password : in Unbounded_String) is

   begin
      This.ConnectToServer(UserName     => Username,
                           Password     => Password);
   end LoginUser;

   -----------------------------------------------------------------------------

   procedure DisconnectUser(This : in out Concrete_Client; Username : in Unbounded_String; Message : in Unbounded_String) is

   begin
      This.DisconnectFromServer(UserName => Username,
                                Msg      => Message);
   end DisconnectUser;

   -----------------------------------------------------------------------------

   procedure RegisterUser(This : in out Concrete_Client; Username : in Unbounded_String; Password : in Unbounded_String) is

   begin
      This.RegisterAtServer(UserName => Username,
                            Password => Password); --#TODO ENCODE EINFUEGEN
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

   task body Server_Listener_Task is
   begin
      accept Start;
      loop
         declare
            MsgObject : MessageObject;
	 begin
	    Put_Line("before read");
	    MsgObject := readMessageFromStream(ClientSocket => Client);
	    Put_Line("after read");
	    printMessageToInfoConsole(MsgObject);
            Instance.ProcessMessageObject(MsgObject);
         end;
      end loop;
   end Server_Listener_Task;

end Concrete_Client_Logic;
