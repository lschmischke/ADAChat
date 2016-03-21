package Communication_Objects is

     procedure dummy;

   type Communication_Object is abstract tagged private;

private

type Communication_Object is abstract tagged
record
	x: Integer;
end record;
end Communication_Objects;
