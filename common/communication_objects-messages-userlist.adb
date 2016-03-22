package body Communication_Objects.Messages.Userlist is

   function getUsers(this : in Userlist) return Users is
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
