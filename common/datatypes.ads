with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;
with GNAT.SHA512;

package dataTypes is
   type User is tagged private;
   type UserPtr is access User;

   package UserList is new Doubly_Linked_Lists(Element_Type => UserPtr);

   function getUsername(this : in UserPtr) return Unbounded_String;
   procedure setUsername(this : in out UserPtr; name : in Unbounded_String);
   function encodePassword(password : in Unbounded_String) return Unbounded_String;
   function getPassword(this : in UserPtr) return Unbounded_String;
   function setPassword(this : in out UserPtr; password : in Unbounded_String) return Boolean;
   function getContacts (this : in UserPtr) return UserList.List;
   procedure setContacts (this : in out UserPtr; contacts : in UserList.List);
   function addContact (this : in out UserPtr; contactToAdd : UserPtr) return Boolean;
   function removeContact (this : in out UserPtr; contactToRemove : UserPtr) return boolean;


private

   type User is tagged
      record
         username : Unbounded_String;
         password : Unbounded_String;
         contacts : UserList.List;
      end record;


end dataTypes;
