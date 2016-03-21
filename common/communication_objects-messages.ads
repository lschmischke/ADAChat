package Communication_Objects.Messages is
  procedure dummy;

   type Message is abstract tagged private;

private

type Message is abstract tagged
record
	x: Integer;
end record;
end Communication_Objects.Messages;
