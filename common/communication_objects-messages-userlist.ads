with Data_Types; use Data_Types;

package Communication_Objects.Messages.Userlist is

   type Users is array (Integer) of User;

   type Userlist is new Communication_Objects.Messages.Message with record

        UList : Users;

   end record;

   function getUsers(This : in Userlist) return Users;

   procedure addUser(This : in Userlist; U : in User);

   procedure deleteUser(This : in Userlist; U : in User);

end Communication_Objects.Messages.Userlist;
