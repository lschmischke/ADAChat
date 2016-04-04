package body Data_Types is

   function getIsAdminFlag(this : in User_Rights) return Boolean is
   begin
      return this.isAdmin;
   end getIsAdminFlag;

   procedure setIsAdminFlag(this : in out User_Rights; flag : Boolean) is
   begin
      this.isAdmin := flag;
   end setIsAdminFlag;

   function getCanKickGroupMembersFlag(this : in User_Rights) return Boolean is
   begin
      return this.canKickGroupMembers;
   end getCanKickGroupMembersFlag;

   procedure setCanKickGroupMembersFlag(this : in out User_Rights; flag : Boolean) is
   begin
      this.canKickGroupMembers := flag;
   end setCanKickGroupMembersFlag;


   function getUsername(this : in User_Ptr) return Unbounded_String is
   begin
      return this.all.username;
   end getUsername;

   procedure setUsername(this : in out User_Ptr; name : in Unbounded_String) is
   begin
      this.all.username := name;
   end setUsername;

   function getPassword(this : in User_Ptr; authorizedUser : User_Ptr) return Unbounded_String is
   begin
      -- if authorizedUser...
      return this.all.password;
   end getPassword;

   function setPassword(this : in out User_Ptr; password : in Unbounded_String; authorizedUser : User_Ptr) return Boolean is
   begin
      -- if authorizedUser...
      -- Restriktionen und Hash speater noch hinzufuegen
      this.all.password := password;
      return true;
   end setPassword;

   function getUserRights(this : in User_Ptr) return User_Rights is
   begin
      return this.all.userrights;
   end getUserRights;

   function setUserRights(this : in out User_Ptr; rights : in User_Rights; authorizedUser : User_Ptr) return Boolean is
   begin
      -- if authorizedUser...
      setIsAdminFlag(this => this.userrights, flag => rights.isAdmin);
      setCanKickGroupMembersFlag(this => this.userrights, flag => rights.canKickGroupMembers);
      return true;
   end setUserRights;


   function isEmpty(this : in User_ContactList_Ptr) return Boolean is
   begin
      return this.all.list.Is_Empty;
   end isEmpty;

   function isFull(this : in User_ContactList_Ptr) return Boolean is
   begin
      return this.all.maxSize = this.all.list.Length;
   end isFull;

   function getUser(this : in User_ContactList_Ptr; userToGet : in User_Ptr) return User_Ptr is
      Not_Found : User_Ptr := null;
   begin
      for u of this.all.list loop
         if u.all = userToGet.all then return u; --seems to be equal to u = userToGet
         end if;
      end loop;
      return Not_Found;
   end getUser;

   function addUser(this : in out User_ContactList_Ptr; userToAdd : in User_Ptr) return Boolean is
   begin
      if not isFull(this => this) and then not this.all.list.Contains(Item => userToAdd) then
         this.all.list.Append(New_Item => userToAdd);
         return true;
      end if;
      return false;
   end addUser;

   function removeUser(this : in out User_ContactList_Ptr; userToRem : in User_Ptr) return Boolean is
      posi : Linked_List.Cursor;
   begin
      if not isEmpty(this => this) then
         posi := this.all.list.Find(Item => userToRem);
         this.all.list.Delete(Position => posi);
         return true;
      end if;
      return false;
   end removeUser;


   function getUserData(this : in User_Data_Set_Ptr) return User_Ptr is
   begin
      return this.all.user_data;
   end getUserData;

   procedure setUserData(this : in out User_Data_Set_Ptr; userToSet : in User_Ptr) is
   begin
      this.all.user_data := userToSet;
   end setUserData;

   function getContacts(this : in User_Data_Set_Ptr) return User_ContactList_Ptr is
   begin
      return this.all.contacts;
   end getContacts;

   procedure setContacts(this : in out User_Data_Set_Ptr; contactsToSet : in User_ContactList_Ptr) is
   begin
      this.all.contacts := contactsToSet;
   end setContacts;

end Data_Types;
