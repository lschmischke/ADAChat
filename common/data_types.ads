with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Data_Types is

   type User is record
      Username : Unbounded_String;
      UserRights : Unbounded_String;
      Password : Unbounded_String;
   end record;

end Data_Types;
