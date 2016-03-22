with Data_Types; use Data_Types;

package Communication_Objects.Messages.Userlist is

   type List is array (Integer) of User;

   type Userlist is new Communication_Objects.Messages.Message with record

        Users : List;

   end record;

   function getUsers(This : in Userlist) return List;

   procedure addUser(This : in Userlist; User : in User);

   procedure deleteUser(This : in Userlist; User : in User);

end Communication_Objects.Messages.Userlist;
