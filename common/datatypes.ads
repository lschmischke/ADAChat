with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;  use Ada.Containers;
with GNAT.SHA512;
with ADa.Text_IO; use ada.Text_IO;
with ada.containers.Ordered_Sets;

package dataTypes is
   type User is tagged private;
   type UserPtr is access User;

   function "<" (first : in UserPtr; second : in UserPtr) return Boolean;
   function "=" (first : in UserPtr; second : in UserPtr) return Boolean;

  -- package UserList is new Doubly_Linked_Lists(Element_Type => UserPtr);
   package UserSet is new Ada.Containers.Ordered_Sets(Element_Type => UserPtr,
						      "<" => dataTypes."<",
						      "=" => dataTypes."=");

   function getUsername(this : in UserPtr) return Unbounded_String;
   procedure setUsername(this : in out UserPtr; name : in Unbounded_String);
   function encodePassword(password : in Unbounded_String) return Unbounded_String;
   function getPassword(this : in UserPtr) return Unbounded_String;
   function setPassword(this : in out UserPtr; password : in Unbounded_String) return Boolean;
   function getContacts (this : in UserPtr) return UserSet.Set;
   procedure setContacts (this : in out UserPtr; contacts : in UserSet.Set);
   function UserToString(this : in UserPtr) return String;



private
   type User is tagged
      record
         username : Unbounded_String;
         password : Unbounded_String;
         contacts : UserSet.Set;
      end record;
end dataTypes;
