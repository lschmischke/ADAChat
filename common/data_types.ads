with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;


package Data_Types is
-- public
   type User_Rights is private;
   function getIsAdminFlag(this : in User_Rights) return Boolean;
   procedure setIsAdminFlag(this : in out User_Rights; flag : Boolean);
   function getCanKickGroupMembersFlag(this : in User_Rights) return Boolean;
   procedure setCanKickGroupMembersFlag(this : in out User_Rights; flag : Boolean);

   type User is private;
   type User_Ptr is access User;
   function getUsername(this : in User_Ptr) return Unbounded_String;
   procedure setUsername(this : in out User_Ptr; name : in Unbounded_String);
   function getPassword(this : in User_Ptr; authorizedUser : User_Ptr) return Unbounded_String;
   function setPassword(this : in out User_Ptr; password : in Unbounded_String; authorizedUser : User_Ptr) return Boolean;
   function getUserRights(this : in User_Ptr) return User_Rights;
   function setUserRights(this : in out User_Ptr; rights : in User_Rights; authorizedUser : User_Ptr) return Boolean;

   type User_ContactList is private;
   type User_ContactList_Ptr is access User_ContactList;
   function isEmpty(this : in User_ContactList_Ptr) return Boolean;
   function isFull(this : in User_ContactList_Ptr) return Boolean;
   function getUser(this : in User_ContactList_Ptr; userToGet : in User_Ptr) return User_Ptr;
   function addUser(this : in out User_ContactList_Ptr; userToAdd : in User_Ptr) return Boolean;
   function removeUser(this : in out User_ContactList_Ptr; userToRem : in User_Ptr) return Boolean;

   type User_Data_Set is private;
   type User_Data_Set_Ptr is access User_Data_Set;
   function getUserData(this : in User_Data_Set_Ptr) return User_Ptr;
   procedure setUserData(this : in out User_Data_Set_Ptr; userToSet : in User_Ptr);
   function getContacts(this : in User_Data_Set_Ptr) return User_ContactList_Ptr;
   procedure setContacts(this : in out User_Data_Set_Ptr; contactsToSet : in User_ContactList_Ptr);
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

   package Linked_List is new Doubly_Linked_Lists(Element_Type => User_Ptr);

   type User_ContactList is record
      list : Linked_List.List;
      maxSize : Ada.Containers.Count_Type := 50;
   end record;

   type User_Data_Set is record
      user_data : User_Ptr;
      contacts : User_ContactList_Ptr;
   end record;

end Data_Types;
