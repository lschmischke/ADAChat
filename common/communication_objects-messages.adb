with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Communication_Objects.Messages is

   function getContent(This : in Message) return Unbounded_String is
   begin
      return This.Content;
   end getContent;

end  Communication_Objects.Messages;
