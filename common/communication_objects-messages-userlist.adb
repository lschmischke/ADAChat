package body Communication_Objects.Messages.Userlist is

   function getUsers(This : in Userlist) return UserRecord is
   begin
      return This.UList;
   end getUsers;

   procedure addUser(This : in Userlist; U : in User) is
   begin
      null;
   end addUser;

   procedure deleteUser(This : in Userlist; U : in User) is
   begin
      null;
   end deleteUser;

end Communication_Objects.Messages.Userlist;
