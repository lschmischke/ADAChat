package body datatypes is

   function getUsername(this : in UserPtr) return Unbounded_String is
   begin
     if(this=null) then
	Put_Line(" FUCKING FEHLER FUCK FUCK");
     return To_Unbounded_String("FFUCK FUFUUFUFUFUFUCK");
     end if;

      return this.username;
   end getUsername;


   procedure setUsername(this : in out UserPtr; name : in Unbounded_String) is
   begin
      this.username := name;
   end setUserName;

   function encodePassword(password : in Unbounded_String) return Unbounded_String is
      hashedPW : String := (GNAT.SHA512.Digest(To_String(password)));
   begin
      Put_Line("New hashed PW: "& hashedPW);
      return To_Unbounded_String(hashedPW);
   end encodePassword;

   function getPassword(this : in UserPtr) return Unbounded_String is
   begin
      return this.password;
   end getPassword;

   function setPassword(this : in out UserPtr; password : in Unbounded_String) return Boolean is
   begin
      this.password := password;
      return true;
   end setPassword;

   function getContacts (this : in UserPtr) return UserSet.Set is
   begin
      return this.contacts;
   end getContacts;

   procedure setContacts (this : in out UserPtr; contacts : in UserSet.Set) is
   begin
      this.contacts := contacts;
   end setContacts;



   function "<" (first : in UserPtr; second : in UserPtr) return Boolean is
      user1 : String := To_String(getUsername(first));
      user2 : String := To_String(getUsername(second));
   begin
      if(user1<user2) then
	 return true;
      else
	 return false;
      end if;
   end "<";

   function "=" (first : in UserPtr; second : in UserPtr) return Boolean is
     user1 : String := To_String(getUsername(first));
      user2 : String := To_String(getUsername(second));
   begin
      if(user1=user2) then
	 return true;
      else
	 return false;
      end if;
   end "=";


end datatypes;
