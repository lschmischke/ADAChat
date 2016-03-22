with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Communication_Objects.Messages is

   type Message is new Communication_Objects.Communication_Object with record
	Content : Unbounded_String;
   end record;

   function getContent(This : in Message) return Unbounded_String;

end Communication_Objects.Messages;
