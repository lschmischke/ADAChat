with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Communication_Objects.Messages.Disconnect is

    procedure dummy;

   type Disconnect is new Communication_Objects.Messages.Message with record
	Username: Unbounded_String;
   end record;

   end Communication_Objects.Messages.Disconnect;
