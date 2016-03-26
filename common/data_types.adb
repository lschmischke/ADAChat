package body Data_Types is

   function isEmpty(this : in out User_ContactList) return Boolean is
   begin
      return this.list.Is_Empty;
   end isEmpty;

   function isFull(this : in out User_ContactList) return Boolean is
   begin
      return this.maxSize = this.list.Length;
   end isFull;

   function getUser(this : in out User_ContactList; userToGet : in User) return User is
      Not_Found : exception;
   begin
      for user of this.list loop
         if user = userToGet then return user;
         end if;
      end loop;
      raise Not_Found;
   end getUser;

   function addUser(this : in out User_ContactList; userToAdd : in User) return Boolean is
   begin
      if not isFull(this) and then not this.list.Contains(userToAdd) then
         this.list.Append(userToAdd);
         return true;
      end if;
      return false;
   end addUser;

   function removeUser(this : in out User_ContactList; userToRem : in User) return Boolean is
      posi : Linked_List.Cursor;
   begin
      if not isEmpty(this) then
         posi := this.list.Find(userToRem);
         this.list.Delete(posi);
         return true;
      end if;
      return false;
   end removeUser;

end Data_Types;
