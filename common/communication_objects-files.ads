package Communication_Objects.Files is
   type File is new Communication_Object with private;

   private

type File is tagged
record
	x: Integer;
end record;
   end Communication_Objects.Files;
