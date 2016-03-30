with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with Ada.Strings.Unbounded.Equal_Case_Insensitive;
with Ada.Containers.Hashed_Maps;  use Ada.Containers;

with Data_Types; use Data_Types;

package User_Databases is
-- public
   type User_Database is private;
   function getUser(this : in out User_Database; userToGet : in User) return User;
   function addUser(this : in out User_Database; userToAdd : in User) return Boolean;
   function removeUser(this : in out User_Database; userToRem : in User) return Boolean;

private
   package User_Maps is new Hashed_Maps
     (Key_Type => Unbounded_String,
      Element_Type => User,
      Hash => Ada.Strings.Unbounded.Hash_Case_Insensitive,
      Equivalent_Keys => "=");
   use User_Maps;

   type User_Database is record
      users : User_Maps.Map;
      maxSize : Integer := 1000000;
   end record;

end User_Databases;
