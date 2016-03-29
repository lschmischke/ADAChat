with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;


package Data_Types is
   -- public
   type User is private;

   type User_ContactList is private;
   function isEmpty(this : in out User_ContactList) return Boolean;
   function isFull(this : in out User_ContactList) return Boolean;
   function getUser(this : in out User_ContactList; userToGet : in User) return User;
   function addUser(this : in out User_ContactList; userToAdd : in User) return Boolean;
   function removeUser(this : in out User_ContactList; userToRem : in User) return Boolean;

private
   type User_Rights is record
      isAdmin : Boolean := false;
      canKickGroupMembers : Boolean := false;
   end record;

   type User is record
      username : Unbounded_String;
      password : Unbounded_String;
      userrights : User_Rights;
      --contacts : User_ContactList;
   end record;

   package Linked_List is new Doubly_Linked_Lists(Element_Type => User);

   type User_ContactList is record
      list : Linked_List.List;
      maxSize : Ada.Containers.Count_Type := 50;
   end record;

   type User_Data_Set is record
      user_data : User;
      contacts : User_ContactList;
   end record;

end Data_Types;
