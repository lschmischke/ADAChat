package body Protocol is

   function messageObjectToString(message : MessageObject) return String is
   begin
      return MessageTypeE'Image(message.messagetype) & Seperator & Ada.Strings.Unbounded.To_String(message.sender) &
        Seperator & Trim(Integer'Image(message.receiver), Left) & Seperator & Ada.Strings.Unbounded.To_String(message.content);
   end messageObjectToString;

   function stringToMessageObject(message : in Unbounded_String) return MessageObject is
      MessageParts : GNAT.String_Split.Slice_Set;
      MessagePart : Unbounded_String;
      Count : Slice_Number;
      newMessageObject : MessageObject;
         begin
      -- # Nachricht wird an definiertem Trennzeichen zerstueckelt #
      GNAT.String_Split.Create(S => MessageParts, From => Ada.Strings.Unbounded.To_String(message),
                               Separators => Seperator, Mode => GNAT.String_Split.Multiple);
      Count := GNAT.String_Split.Slice_Count(MessageParts);
      if count >=4 then
         newMessageObject.messagetype := MessageTypeE'Value(GNAT.String_Split.Slice(MessageParts, 1));
         newMessageObject.sender := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(MessageParts, 2));
         newMessageObject.receiver := Integer'Value(GNAT.String_Split.Slice(MessageParts, 3));

         for i in 4 .. GNAT.String_Split.Slice_Count(MessageParts) loop
            newMessageObject.content := newMessageObject.content & GNAT.String_Split.Slice(MessageParts, i);
         end loop;
      else
         Put_Line("Cannot convert String to MessageObject");
         return createMessage(messagetype => Invalid,
                       sender      => To_Unbounded_String("unknown"),
                       receiver    => -1 ,
                       content     => message);

      end if;
      return newMessageObject;
   end;

   function createMessage(messagetype : in MessageTypeE; sender : in Unbounded_String; receiver : in Integer; content : in Unbounded_String) return MessageObject is
      result : MessageObject;
   begin
      result.messagetype := messagetype;
      result.sender := sender;
      result.receiver := receiver;
      result.content := content;
      return result;
   end createMessage;

   procedure printMessageToInfoConsole(message : in MessageObject) is
      messageType : String := MessageTypeE'Image(message.messagetype);
      sender : String := To_String(message.sender);
      receiver : String := Trim(Integer'Image(message.receiver),Left);
      content : String := To_String(message.content);
   begin
      Put_Line("messageType -> " & MessageTypeE'Image(message.messagetype) & " (length "& Positive'Image(messageType'Length) & ")");
      Put_Line("sender      -> " & To_String(message.sender) & " (length "&Positive'Image(sender'Length)& ")");
      Put_Line("receiver    ->" & Integer'Image(message.receiver)  & " (length "&Positive'Image(receiver'Length)& ")");
      Put_Line("content     -> " & To_String(message.content & " (length "&Positive'Image(content'Length)& ")"));
   end printMessageToInfoConsole;

   procedure writeMessageToStream(ClientSocket : in Socket_Type; message : MessageObject)is
      OutputChannel : Stream_Access;
   begin
      OutputChannel := Stream(ClientSocket);
      String'Write(OutputChannel, messageObjectToString(message));
   end writeMessageToStream;


   function readMessageFromStream (ClientSocket : in Socket_Type) return MessageObject is
      incoming_data : Stream_Element_Array(1..4096);
      incoming_data_size : Stream_Element_Offset;
      incoming_string : Ada.Strings.Unbounded.Unbounded_String;

   begin
      -- # Eigehende Nachrichten lesen (blockierender Aufruf) #
          Receive_Socket(Socket => ClientSocket, Item => incoming_data, Last => incoming_data_size);

      -- # Eingegangene Nachricht aus Character-Array in String zusammebauen #
      for i in 1 .. incoming_data_size loop
          incoming_string := incoming_string & Character'Val(incoming_data(i));
      end loop;

      return stringToMessageObject(incoming_string);

   end readMessageFromStream;



end Protocol;
