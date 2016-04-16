with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Hash_Case_Insensitive;
with Ada.Strings.Unbounded.Equal_Case_Insensitive;
with Ada.Containers.Hashed_Maps;  use Ada.Containers;
with Ada.Text_IO; use Ada.Text_IO;
with Protocol;
with GNAT.String_Split; use GNAT.String_Split;

with DataTypes; use DataTypes;

package User_Databases is
-- public

   type User_Database is tagged private;
   function registerUser(this : in out User_Database; username : in String; password : in String) return Boolean;
   function getUser(database : in User_Database; username : in Unbounded_String) return UserPtr;

   procedure saveUserDatabase(this : in User_Database); -- writes User Database to file
   procedure loadUserDatabase(this : in out User_Database); -- loads user database from file

   package User_Maps is new Hashed_Maps
     (Key_Type => Unbounded_String,
      Element_Type => UserPtr,
      Hash => Ada.Strings.Unbounded.Hash_Case_Insensitive,
      Equivalent_Keys => "=");
   use User_Maps;


private

   function userToUnboundedString(this : in out UserPtr) return Unbounded_String;
   function StringToUser(inputLine : in String; database : in User_Database) return UserPtr;

   type User_Database is tagged record
      users : User_Maps.Map; -- # username -> userDataSet
      databaseFileName: Unbounded_String := To_Unbounded_String("ADAChatDatabase.txt");
      maxSize : Integer := 1000000;

   end record;


end User_Databases;
