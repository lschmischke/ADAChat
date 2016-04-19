with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.String_Split; use GNAT.String_Split;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Streams; use Ada.Streams;
with GNAT.Sockets; use GNAT.Sockets;

package Protocol is

   -- Seperator : constant String := Character'Image(Character'Val(0));
     Seperator : constant String :=":";

   type MessageTypeE is (Connect, Chat, Refused, Disconnect, Online, Offline, Chatrequest,
                         Userlist, Leavechat, Invalid, Register, addContact, remContact);

   type MessageObject is record
      messagetype : MessageTypeE;
      sender : Unbounded_String;
      receiver : Integer;
      content : Unbounded_String;
   end record;

   function messageObjectToString(message : in MessageObject) return String;

   function stringToMessageObject(message : in Unbounded_String) return MessageObject;

   function createMessage(messagetype : in MessageTypeE; sender : in Unbounded_String; receiver : in Integer; content : in Unbounded_String) return MessageObject;

   procedure printMessageToInfoConsole(message : in MessageObject);

   procedure writeMessageToStream(ClientSocket : in Socket_Type; message : MessageObject);

   function readMessageFromStream (ClientSocket : in Socket_Type) return MessageObject;

end Protocol;
