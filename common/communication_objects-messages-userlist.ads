with Data_Types; use Data_Types;

package Communication_Objects.Messages.Userlist is

   type UserRecord is array (Positive range <>) of User;

   type Userlist is new Communication_Objects.Messages.Message with record

      UList : UserRecord(1..32);
      User_Number : Positive;

   end record;

   function getUsers(This : in Userlist) return UserRecord;

   procedure addUser(This : in Userlist; U : in User);

   procedure deleteUser(This : in Userlist; U : in User);

end Communication_Objects.Messages.Userlist;
