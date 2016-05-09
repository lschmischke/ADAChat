--Implementierung der Client_Logic

--Includes
with GNAT.String_Split; use GNAT.String_Split;

package body Concrete_Client_Logic is

   client : Socket_Type;
   address : Sock_Addr_Type;
   channel : Stream_Access;
   SocketInitialized : Boolean := False;

   procedure initializeGUI(this : in out Concrete_Client; ptr : in GUIPtr) is

   begin

      this.gui := ptr;

   end InitializeGUI;

   -----------------------------------------------------------------------------

   procedure initializeSocket(this : in out Concrete_Client; serverAdress : in Unbounded_String;
                              serverPort : in Port_Type) is

   begin
      --#Socket initialisieren und erzeugen#
      if not SocketInitialized then
         create_Socket (client);
         address.Addr := inet_Addr(to_String(serverAdress));
         address.Port := serverPort;
         this.socket := client;
         connect_Socket (client, address);
         channel := stream (client);
         server_Listener_Task.start;
         SocketInitialized := True;
      end if;
   end InitializeSocket;


   -----------------------------------------------------------------------------

   procedure connectToServer(this : in out Concrete_Client; userName : in Unbounded_String;
                              password : in Unbounded_String) is

      connectMessage : MessageObject;

   begin

      --#ConnectMessage erzeugen#
      connectMessage := createMessage(messagetype => protocol.Connect,
                                      sender      => userName,
                                      receiver    => serverID,
                                      content     => password);

      --#ConnectMessage nach Protokoll an Server#
      writeMessageToStream(clientSocket => client,
                           message      => connectMessage);

   end connectToServer;

   -----------------------------------------------------------------------------

   procedure disconnectFromServer(this : in out Concrete_Client; userName : in Unbounded_String;
                                  msg : in Unbounded_String) is

      disconnectMessage : MessageObject;

   begin

      --#DisconnectMessage erzeugen#
      disconnectMessage := createMessage(messagetype => protocol.Disconnect,
                                         sender      => userName,
                                         receiver    => this.ServerRoomId,
                                         content     => msg);

      --#DisconnectMessage nach Protokoll an Server#
      writeMessageToStream(clientSocket => client,
                           message      => disconnectMessage);

   end disconnectFromServer;

   -----------------------------------------------------------------------------

   procedure registerAtServer(this : in out Concrete_Client; username : in Unbounded_String; password : in Unbounded_String) is

      registerMessage : MessageObject;

   begin

      registerMessage := createMessage(messagetype => register,
                                       sender      => userName,
                                       receiver    => serverID,
                                       content     => password);

      writeMessageToStream(clientSocket => client,
                           message      => registerMessage);

   end registerAtServer;

   -----------------------------------------------------------------------------

   procedure requestChatroom(this : in out Concrete_Client; userName : in Unbounded_String; id_Receiver : in Integer;
                             participant : in Unbounded_String) is

     requestMessage : MessageObject;

   begin

      requestMessage := createMessage(messagetype => chatrequest,
                                      sender      => userName,
                                      receiver    => id_Receiver,
                                      content     => participant);

      writeMessageToStream(clientSocket => client,
                           message      => requestMessage);

   end requestChatroom;

   -----------------------------------------------------------------------------

   procedure leaveChatroom(this : in out Concrete_Client; userName : in Unbounded_String; id_Receiver : in Integer;
                           Message : in Unbounded_String) is

      leaveMessage : MessageObject;

   begin

      leaveMessage := createMessage(messagetype => leavechat,
                                    sender      => userName,
                                    receiver    => id_Receiver,
                                    content     => message);

      writeMessageToStream(clientSocket => client,
                           message      => leaveMessage);

   end leaveChatroom;

   -----------------------------------------------------------------------------

   procedure sendTextMessage(this : in out Concrete_Client; username : in Unbounded_String;
                             id_Receiver : in Integer; msg : in Unbounded_String) is

      message : MessageObject;

   begin

      message := createMessage(messagetype => protocol.Chat,
                               sender      => username,
                               receiver    => id_Receiver,
                               content     => msg);

      writeMessageToStream(ClientSocket => client,
                           message      => message);

   end sendTextMessage;

   -----------------------------------------------------------------------------

   procedure sendMessageObject(This : in out Concrete_Client; username : in Unbounded_String;
                               id_Receiver : in Integer; msgObject : in MessageObject) is


   begin

      writeMessageToStream(clientSocket => client,
                           message      => msgObject);

   end sendMessageObject;

   -----------------------------------------------------------------------------

   procedure readFromServer(This : in out Concrete_Client; ServerSocket : in Socket_Type) is

      msgObject : MessageObject;
      msg : Unbounded_String;
   begin

      msgObject := readMessageFromStream(clientSocket => client);
      protocol.printMessageToInfoConsole(msgObject);
      this.processMessageObject(msgObject);

   end readFromServer;

   -----------------------------------------------------------------------------

   procedure processMessageObject(this : in out Concrete_Client; msgObject : in MessageObject) is

   begin
      case MsgObject.Messagetype is

         when Connect =>
            this.serverRoomId := msgObject.receiver;
            this.gui.loginSuccess;
         when Chat =>

            --#Ist ID bekannt, bin ich schon im Chatroom
            --#wenn ja, zeige Message in diesem Chatraum
            --#wenn nein, lege Chatraum an und oeffne guifenster

            if this.ChatRoomIdSet.contains(item => msgObject.receiver) then
               null;
            else
               this.ChatRoomIdSet.insert(new_Item => msgObject.receiver);
               this.gui.updateChatRoomId(msgObject.receiver, msgObject.sender);
            end if;
            this.gui.showChatMessages(message => msgObject);

         when Refused =>
            declare
               message: Unbounded_String;
            begin
               --#1.refused wenn kein Serverconnect
               --#2. wenn name oder pw falsch
               --#3. user schon eingeloggt
               --#4. wenn Einladung in illegalem Chatraum
               message := to_Unbounded_String("Refused: ");
               append(message, MsgObject.Content);
               this.gui.refusedMessage(reason => message);
            end;

         when Disconnect =>
            declare
               message : Unbounded_String;
            begin
               close_Socket(Client);

               --#Userliste löschen#--
               this.UsersOnline.Clear;
               this.UsersOffline.Clear;

               if msgObject.content = "ok"  then
                  this.gui.disconnectReason(status => to_Unbounded_String("Die Verbindung wurde beendet!"));
               else
                  message := To_Unbounded_String("You were kicked: ");
                  append(Message, MsgObject.Content);
                  this.gui.disconnectReason(status => message);
               end if;
            end;

         when Online =>
            declare
               message: Unbounded_String;
               position: Client2Gui_Communication.Userlist.Cursor;
            begin
               message := MsgObject.Content;
               append(Message, " ist jetzt online!");
               this.UsersOnline.insert(msgObject.content);
               if this.UsersOffline.contains(item => msgObject.content) then
                  position := This.UsersOffline.Find(item => msgObject.content);
                  this.UsersOffline.delete(position);
                  this.gui.SetOfflineUser(users => this.UsersOffline);
               end if;
               this.gui.setOnlineUser(Users => this.UsersOnline);
            end;

         when Offline =>
            declare
               message: Unbounded_String;
               position: Client2Gui_Communication.Userlist.Cursor;
            begin
               message := msgObject.content;
               append(Message, " ist jetzt offline!");
               this.UsersOffline.insert(msgObject.content);
               if this.UsersOnline.contains(Item => msgObject.content) then
                  position := this.UsersOnline.find(item => msgObject.content);
                  this.UsersOnline.delete(position);
                  this.gui.setOnlineUser(users => this.UsersOnline);
               end if;
              this.gui.setOfflineUser(users => this.UsersOffline);
            end;

         when Chatrequest =>
            declare
               message: Unbounded_String;
            begin

               this.ChatRoomIdSet.insert(new_Item => msgObject.receiver);
               this.gui.updateChatRoomId(chatId => msgObject.Receiver, name => msgObject.content);

            end;

         when Protocol.Userlist =>
            declare
               substrings : GNAT.String_Split.Slice_Set;
               userSet : Client2Gui_Communication.Userlist.Set;
            begin
               GNAT.String_Split.create (s => substrings,
                                         from       => To_String(MsgObject.Content),
                                         separators => Protocol.Seperator,
                                         mode       => GNAT.String_Split.Single);

               for i in 1 .. GNAT.String_Split.Slice_Count (substrings) loop
                  UserSet.insert(new_Item => to_Unbounded_String(GNAT.String_Split.Slice (substrings, i)));
               end loop;

               if this.ChatRoomParticipants.contains(msgObject.receiver) then
                  this.ChatRoomParticipants.delete(msgObject.receiver);
               end if;

               this.ChatRoomParticipants.insert(key      => msgObject.receiver,
                                                new_Item => userSet);

               this.gui.showChatParticipants(chatraum     => msgObject.receiver,
                                             participants => userSet);
            end;

         when AddContact =>
            this.gui.contactRequest(username => msgObject.content);

         when RemContact =>
            this.gui.ContactRemove(username => msgObject.content);

         when others =>
            null;

      end case;
   end processMessageObject;

   -----------------------------------------------------------------------------
   function hash (R : Natural) return Hash_Type is
   begin
      return Hash_Type (R);
   end hash;

   -----------------------------------------------------------------------------
   -----------Implementierung des Gui2Client_Communication interfaces-----------
   -----------------------------------------------------------------------------

   procedure loginUser(this : in out Concrete_Client; username : in Unbounded_String; password : in Unbounded_String) is

   begin
      this.connectToServer(userName     => username,
                           password     => password);
   end loginUser;

   -----------------------------------------------------------------------------

   procedure disconnectUser(this : in out Concrete_Client; username : in Unbounded_String; message : in Unbounded_String) is

   begin
      this.disconnectFromServer(userName => username,
                                msg      => message);
   end DisconnectUser;

   -----------------------------------------------------------------------------

   procedure registerUser(this : in out Concrete_Client; username : in Unbounded_String; password : in Unbounded_String) is

   begin
      this.registerAtServer(userName => username,
                            password => password); --#TODO ENCODE EINFUEGEN#--
   end registerUser;

   -----------------------------------------------------------------------------

   procedure inviteToGroupChat(this : in out Concrete_Client; username : in Unbounded_String; receiver : in Integer;
                               participant : in Unbounded_String) is

   begin
      this.requestChatroom(userName    => username,
                           id_Receiver => receiver,
                           participant => participant);
   end InviteToGroupChat;

   -----------------------------------------------------------------------------

   procedure sendMessageToChat(this : in out Concrete_Client; receiver: in Integer; username : in Unbounded_String;
                               message : in Unbounded_String) is

   begin

      this.sendTextMessage(username    => username,
                           id_Receiver => receiver,
                           msg         => message);
   end SendMessageToChat;
   -----------------------------------------------------------------------------

   procedure requestChat(this : in out Concrete_Client; username : in Unbounded_String;
                         participant : in Unbounded_String) is
   begin

      this.requestChatroom(userName    => username,
                           id_Receiver => this.ServerRoomId,
                           participant => participant);

   end requestChat;

   -----------------------------------------------------------------------------

   task body Server_Listener_Task is
   begin
      accept Start;
      loop
         begin
            Instance.readFromServer(client);
         end;
      end loop;
   end Server_Listener_Task;

end Concrete_Client_Logic;
