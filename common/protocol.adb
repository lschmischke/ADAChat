package body Protocol is

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   function messageObjectToString(message : MessageObject) return String is
   begin
      return MessageTypeE'Image(message.messagetype) & Seperator & Ada.Strings.Unbounded.To_String(message.sender) &
        Seperator & Trim(Integer'Image(message.receiver), Left) & Seperator & Ada.Strings.Unbounded.To_String(message.content);
   end messageObjectToString;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   function stringToMessageObject(message : in Unbounded_String) return MessageObject is
      MessageParts : GNAT.String_Split.Slice_Set;
      MessagePart : Unbounded_String;
      Count : Slice_Number;
      newMessageObject : MessageObject;
   begin
      Ada.Text_IO.Put_Line (To_String(message));

      -- Nachricht wird an definiertem Trennzeichen zerstückelt
      GNAT.String_Split.Create(S => MessageParts, From => Ada.Strings.Unbounded.To_String(message),
                               Separators => Seperator, Mode => GNAT.String_Split.Multiple);
      Count := GNAT.String_Split.Slice_Count(MessageParts);

      if count >=4 then
         -- TODO: Fehlerbehandlung
         -- Einzelne Attribute des messageObjects werden gefüllt
         newMessageObject.messagetype := MessageTypeE'Value(GNAT.String_Split.Slice(MessageParts, 1));
         newMessageObject.sender := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(MessageParts, 2));
	 newMessageObject.receiver := Natural'Value(GNAT.String_Split.Slice(MessageParts, 3));
	 newMessageObject.content := To_Unbounded_String(GNAT.String_Split.Slice(MessageParts,4));

         -- Für das Content-Attribut wird die Zerstückelung, falls vorhanden, wieder rückgänging gemacht
         for i in 5 .. GNAT.String_Split.Slice_Count(MessageParts) loop
            newMessageObject.content := newMessageObject.content & Protocol.Seperator & GNAT.String_Split.Slice(MessageParts, i);
         end loop;
      else
         Put_Line("Cannot convert String to MessageObject");
         return createMessage(messagetype => Invalid,
                       sender      => To_Unbounded_String("unknown"),
                       receiver    => 0,
                       content     => message);
      end if;
      return newMessageObject;
   end;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   function createMessage(messagetype : in MessageTypeE; sender : in Unbounded_String; receiver : in Natural; content : in Unbounded_String) return MessageObject is
      result : MessageObject;
   begin
      result.messagetype := messagetype;
      result.sender := sender;
      result.receiver := receiver;
      result.content := content&Terminator;
      return result;
   end createMessage;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

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

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   procedure writeMessageToStream(ClientSocket : in Socket_Type; message : MessageObject)is
      OutputChannel : Stream_Access;
   begin
      OutputChannel := Stream(ClientSocket);
      String'Write(OutputChannel, messageObjectToString(message));
   end writeMessageToStream;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   function readMessageFromStream (ClientSocket : in Socket_Type) return MessageObject is
      InputChannel : Stream_Access;
      incoming_string : Ada.Strings.Unbounded.Unbounded_String;
      c : Character;
   begin
      InputChannel := Stream(ClientSocket);
      -- Eigehende Nachrichten lesen (blockierender Aufruf)
      while true loop
	 Character'Read(InputChannel,c);
	 exit when c = Terminator;
	 --Put_Line("in char: "&c);
	 incoming_string := incoming_string & c;
      end loop;

      return stringToMessageObject(incoming_string);
   end readMessageFromStream;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

end Protocol;
