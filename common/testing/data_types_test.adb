with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Data_Types; use Data_Types;
with Ada.Assertions;  use Ada.Assertions;


procedure Data_Types_Test is
   testRights1, testRights2 : User_Rights;
   testUser1, testUser2 : User_Ptr := new User;
   testContacts1, testContacts2 : User_ContactList_Ptr := new User_ContactList;
   testUserSet1, testUserSet2 : User_Data_Set_Ptr := new User_Data_Set;
   b : Boolean;
begin
   setIsAdminFlag(this => testRights1, flag => false);
   setCanKickGroupMembersFlag(this => testRights1, flag => true);

   setIsAdminFlag(this => testRights2, flag => false);
   setCanKickGroupMembersFlag(this => testRights2, flag => true);


   setUsername(this => testUser1, name => TO_Unbounded_String("Max Mustermann"));
   b := setPassword(this => testUser1, password => TO_Unbounded_String("abc123"), authorizedUser => testUser2);
   b := setUserRights(this => testUser1, rights => testRights1, authorizedUser => testUser2);

   setUsername(this => testUser2, name => TO_Unbounded_String("John Doe"));
   b := setPassword(this => testUser2, password => TO_Unbounded_String("xyz789"), authorizedUser => testUser1);
   b := setUserRights(this => testUser2, rights => testRights2, authorizedUser => testUser1);


   b := addUser(this => testContacts1, userToAdd => testUser2);
   testUser2 := getUser(this => testContacts1, userToGet => testUser2);
   b := removeUser(this => testContacts1, userToRem => testUser2);


   setUserData(this => testUserSet1, userToSet => testUser1);
   setContacts(this => testUserSet1, contactsToSet => testContacts1);

end Data_Types_Test;
