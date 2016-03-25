with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Equal_Case_Insensitive;
with Ada.Containers.Hashed_Maps;  use Ada.Containers;
with Ada.Strings.Hash_Case_Insensitive;

with Data_Types; use Data_Types;


package User_Databases is
-- public
   type User_Database is tagged private;
   function getUser(This : in out User_Database; userToGet : in User) return User;
   function addUser(This : in out User_Database; userToAdd : in User) return Boolean;
   function removeUser(This : in out User_Database; userToRem : in User) return Boolean;

private
   package User_Maps is new Hashed_Maps
     (Key_Type => Unbounded_String,
      Element_Type => User,
      Hash => Ada.Strings.Hash_Case_Insensitive,
      Equivalent_Keys => "=");
   use User_Maps;

   type User_Database is tagged record
      users : User_Maps.Map;
      maxUsers : Integer;
   end record;

end User_Databases;
