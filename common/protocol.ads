with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.String_Split; use GNAT.String_Split;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package Protocol is

   Seperator : constant String := Character'Image(Character'Val(0));

   type MessageTypeE is (Connect, Chat, Refused, Disconnect, Online, Offline, Chatrequest, Userlist);

   type MessageObject is record
      messagetype : MessageTypeE;
      sender : Unbounded_String;
      receiver : Integer;
      content : Unbounded_String;
   end record;

   function messageObjectToString(message : MessageObject) return String;

   function stringToMessageObject(message : in Unbounded_String) return MessageObject;

end Protocol;
