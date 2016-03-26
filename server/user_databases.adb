package body User_Databases is

   function getUser(this : in out User_Database; userToGet : in User) return User is
   begin
      return userToGet;
   end getUser;

   function addUser(this : in out User_Database; userToAdd : in User) return Boolean is
   begin
      return false;
   end addUser;

   function removeUser(this : in out User_Database; userToRem : in User) return Boolean is
   begin
      return false;
   end removeUser;

end User_Databases;
