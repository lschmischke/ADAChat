package body datatypes is

   function getUsername(this : in UserPtr) return Unbounded_String is
   begin
      return this.username;
   end getUsername;


   procedure setUsername(this : in out UserPtr; name : in Unbounded_String) is
   begin
      this.username := name;
   end setUserName;

   function encodePassword(password : in Unbounded_String) return Unbounded_String is
   begin
      return To_Unbounded_String(GNAT.SHA512.Digest(To_String(password)));
   end encodePassword;

   function getPassword(this : in UserPtr) return Unbounded_String is
   begin
      return this.password;
   end getPassword;

   function setPassword(this : in out UserPtr; password : in Unbounded_String) return Boolean is
   begin
      this.password := encodePassword(password);
      return true;
   end setPassword;

   function getContacts (this : in UserPtr) return ContactList.List is
   begin
      return this.contacts;
   end getContacts;

   procedure setContacts (this : in out UserPtr; contacts : in ContactList.List) is
   begin
      this.contacts := contacts;
   end setContacts;

   function addContact (this : in out UserPtr; contactToAdd : UserPtr) return Boolean is
   begin
      if not this.contacts.Contains(contactToAdd) then
         this.contacts.Append(New_Item => contactToAdd);
         return true;
      else return false;
      end if;

   end addContact;


   function removeContact (this : in out UserPtr; contactToRemove : UserPtr) return boolean is
      pos : ContactList.Cursor := this.contacts.Find(Item     => contactToRemove);
   begin
      if this.contacts.Contains(contactToRemove) then

         this.contacts.Delete(Position => pos);
         return true;
      else
         return false;
      end if;

      end removeContact;

end datatypes;
