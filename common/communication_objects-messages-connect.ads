with Unbounded_String; use Unbounded_String;

package Communication_Objects.Messages.Connect is

    procedure dummy;

   type Connect is new Communication_Objects.Messages.Message with record
	Username: Unbounded_String;
   end record;

   end Communication_Objects.Messages.Connect;
