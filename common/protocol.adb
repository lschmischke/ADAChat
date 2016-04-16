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

      newMessageObject.messagetype := MessageTypeE'Value(GNAT.String_Split.Slice(MessageParts, 1));
      newMessageObject.sender := Ada.Strings.Unbounded.To_Unbounded_String(GNAT.String_Split.Slice(MessageParts, 2));
      newMessageObject.receiver := Integer'Value(GNAT.String_Split.Slice(MessageParts, 3));

      for i in 4 .. GNAT.String_Split.Slice_Count(MessageParts) loop
         newMessageObject.content := newMessageObject.content & GNAT.String_Split.Slice(MessageParts, i);
      end loop;

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


end Protocol;
