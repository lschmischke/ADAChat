package body Communication_Objects.Messages.Userlist is

   function getUsers(this : in Userlist) return List is
   begin
      return This.Users;
   end getUsers;

   procedure addUser(This : in Userlist; User : in User) is
   begin
      null;
   end addUser;

   procedure deleteUser(This : in Userlist; User : in User) is
   begin
      null;
   end deleteUser;

end Communication_Objects.Messages.Userlist;
