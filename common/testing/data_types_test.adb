
package body  Data_Types_Test is
   procedure Test is
      pragma Assertion_Policy(Check);

      procedure Free_User is new Ada.Unchecked_Deallocation
        (Object => User, Name => User_Ptr);

      procedure Free_User_ContactList is new Ada.Unchecked_Deallocation
        (Object => User_ContactList, Name => User_ContactList_Ptr);


      testRights1, testRights2 : User_Rights;
      testUser1, testUser2 : User_Ptr := new User;
      testContacts : User_ContactList_Ptr := new User_ContactList;
   begin

      setIsAdminFlag(this => testRights1, flag => false);
      setCanKickGroupMembersFlag(this => testRights1, flag => true);

      setIsAdminFlag(this => testRights2, flag => false);
      setCanKickGroupMembersFlag(this => testRights2, flag => true);

      Assert(testRights1 = testRights2, "testRight objects should be equal");
      Assert(not getIsAdminFlag(testRights1), "right isAdmin is corrupt");
      Assert(getCanKickGroupMembersFlag(testRights1), "right canKickGroupMembers is corrupt");

      --------------------------------------------------------------------------

      setUsername(this => testUser1, name => TO_Unbounded_String("Max Mustermann"));
      Assert(setPassword(this => testUser1, password => TO_Unbounded_String("abc123"), authorizedUser => testUser2), "set password failed");
      Assert(setUserRights(this => testUser1, rights => testRights1, authorizedUser => testUser2), "set userrights failed");

      setUsername(this => testUser2, name => TO_Unbounded_String("John Doe"));
      Assert(setPassword(this => testUser2, password => TO_Unbounded_String("xyz789"), authorizedUser => testUser1), "set password failed");
      Assert(setUserRights(this => testUser2, rights => testRights2, authorizedUser => testUser1), "set userrights failed");

      Assert(testUser1 /= testUser2, "testUser objects should be not equal");
      Assert(getUsername(testUser2) = TO_Unbounded_String("John Doe"), "username is corrupt");
      Assert(getPassword(testUser2, testUser1) = TO_Unbounded_String("xyz789"), "password is corrupt");
      Assert(getUserRights(testUser2) = testRights2, "userrights are corrupt");

      --------------------------------------------------------------------------

      Assert(addUser(this => testContacts, userToAdd => testUser1), "adding testUser1 failed");
      Assert(addUser(this => testContacts, userToAdd => testUser2), "adding testUser2 failed");
      Assert(getUser(this => testContacts, userToGet => testUser1) = testUser1, "get testUser1 failed");

      Assert(not addUser(this => testContacts, userToAdd => testUser1), "adding testUser1 successfull");
      Assert(removeUser(this => testContacts, userToRem => testUser1), "removing tesUser1 failed");
      Assert(getUser(this => testContacts, userToGet => testUser1) = null, "get testUser1 successfull");
      Assert(addUser(this => testContacts, userToAdd => testUser1), "adding testUser1 failed");
      Assert(getUser(this => testContacts, userToGet => testUser1) = testUser1, "get testUser1 failed");

      --------------------------------------------------------------------------

      Assert(testContacts /= null, "contactlist is null");
      Assert(testUser1 /= null, "user1 is null");
      Assert(testUser2 /= null, "user2 is null");

      Free_User_ContactList(testContacts);
      Free_User(testUser1);
      Free_User(testUser2);

      Assert(testContacts = null, "free contactlist failed");
      Assert(testUser1 = null, "free user1 failed");
      Assert(testUser2 = null, "free user2 failed");

      end Test;

end Data_Types_Test;
