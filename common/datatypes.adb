package body datatypes is

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   protected body User is
      function getUsername return Unbounded_String is
      begin
	 return username;
      end getUsername;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   procedure setUsername(name : in Unbounded_String) is
   begin
      username := name;
   end setUserName;


   --------------------------------------------------------------------------------------------------------------------------------------------------------

   function getPassword return Unbounded_String is
   begin
      return password;
   end getPassword;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   procedure setPassword(pw : in Unbounded_String)is
   begin
      password := pw;
   end setPassword;


   --------------------------------------------------------------------------------------------------------------------------------------------------------

   procedure setContacts (contactList : in UserList.List) is
   begin
      contacts := contactList;
   end setContacts;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   procedure addContact (contactToAdd : UserPtr) is
      begin

      if not contacts.Contains(contactToAdd) then
         contacts.Append(New_Item => contactToAdd);
	 end if;
      end addContact;


   --------------------------------------------------------------------------------------------------------------------------------------------------------

   procedure removeContact (contactToRemove : UserPtr) is
      pos : UserList.Cursor := contacts.Find(Item     => contactToRemove);
   begin
      if contacts.Contains(contactToRemove) then
         contacts.Delete(Position => pos);
      end if;
      end removeContact;
   end User;


   --------------------------------------------------------------------------------------------------------------------------------------------------------

        function encodePassword(password : in Unbounded_String) return Unbounded_String is
   begin
      return To_Unbounded_String(GNAT.SHA512.Digest(To_String(password)));
   end encodePassword;
end datatypes;
