package body User_Databases is

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   protected body User_Database is

      --------------------------------------------------------------------------------------------------------------------------------------------------------

      procedure registerUser (username : in Unbounded_String; password : in Unbounded_String; success : out Boolean) is
         newUser  : UserPtr := new User;
         contacts : UserList.List;
      begin
         newUser.setUsername (username);

         newUser.setPassword (password);
         newUser.setContacts (contacts);

         users.Insert (username, newUser);

         -- hard-speichern des Users
         saveUserDatabase;
         success := True;
      exception
         when Constraint_Error =>
            success := False;
      end registerUser;

      --------------------------------------------------------------------------------------------------------------------------------------------------------

      function getUser (username : in Unbounded_String) return UserPtr is
         user : UserPtr;
      begin
         user := users.Element (Key => username);
         return user;
      exception
         when Constraint_Error =>
            Put_Line ("User '" & To_String (username) & "' not found in database");
            return null;
      end getUser;

      --------------------------------------------------------------------------------------------------------------------------------------------------------

      procedure saveUserDatabase is
         Write_To : String := To_String (databaseFileName);
         DataFile : File_Type;
      begin
         begin
            Open (File => DataFile, Mode => Out_File, Name => Write_To);
         exception
            when others => -- TODO: welcher Fehler wird hier normalerweise geworfen?
               Create (File => DataFile, Mode => Out_File, Name => Write_To);
         end;

         for user of users loop
            -- schreibe jeden User in eine Line im folgenden Format
            -- username:userpasswort[:contact]*
            Put_Line (DataFile, To_String (userToUnboundedString (this => user)));
         end loop;
         Close (DataFile);
      end saveUserDatabase; -- writes User Database to file

      --------------------------------------------------------------------------------------------------------------------------------------------------------

      procedure loadUserDatabase is
         Read_From          : String := To_String (databaseFileName);
         DataFile           : File_Type;
         contactNames       : contactNamesList.List;
         userToContactNames : userToContactNamesMap.Map;
      begin
         begin
            Open (File => DataFile, Mode => In_File, Name => Read_From);

         exception
            when others => --# welcher Fehler wird hier normalerweise geworfen? #
               Put_Line
                 ("ERROR: Userdatabase file doesn't exist. Creating Userdatabase file with name: " &
                  To_String (databaseFileName));
               Create (File => DataFile, Mode => In_File, Name => Read_From);
               return;
         end;

         -- Erster Durchgang lege alle Benutzer an, Benutzer haben noch keine Kontakte
         Put_Line ("Reading from database file, first iteration.");
         begin
            loop
               declare
                  -- lese Line aus dem File
                  userLine : String := Get_Line (DataFile);
                  -- konvertiere Line in User
                  user : UserPtr;
               begin
                  Put_Line ("Read from database file: " & userLine);
                  StringToLonelyUser (userLine, contactNames, user);

                  -- füge User zur Map hinzu
                  users.Insert (Key => user.getUsername, New_Item => user);
                  -- speichere gefundene Kontaktnamen zwischen
                  userToContactNames.Insert (Key => user.getUsername, New_Item => contactNames);
                  contactNames.Clear;
               end;
            end loop;

         exception
            when Error : Ada.IO_Exceptions.End_Error =>
               Put_Line ("closed Database File " & To_String (databaseFileName));
               Close (DataFile);
            when Error : others =>
               Put_Line (Exception_Information (Error));
               Close (DataFile);
         end;

         Put_Line ("Reading from database file, second iteration.");
         -- zweiter Durchgang: da alle User angelegt sind, können nun die Kontakte geknüpft werden
         declare
            Index : userToContactNamesMap.Cursor := userToContactNames.First;
         begin
            -- durchlaufe alle user (map)
            while Index /= userToContactNamesMap.No_Element loop
               declare
                  user : UserPtr := getUser (username => Key (Index));
               begin
                  -- durchlaufe alle kontaktnamen eines users (liste)
                  for contactName of userToContactNames.Element (Key => Key (Index)) loop
                     declare
                        contact : UserPtr := getUser (contactName);
                     begin
                        if contact /= null then
                           Put_Line
                             ("Adding contact " & To_String (contactName) & " to user '" & To_String (user.getUsername) & "'");
                           user.addContact (contact);
                        end if;
                     end;
                  end loop;
               end;
               Index := Next (Index);
            end loop;
         end;
      end loadUserDatabase; -- loads user database from file

      --------------------------------------------------------------------------------------------------------------------------------------------------------

   end User_Database;

   --------------------------------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------------------------------

   function userToUnboundedString (this : in out UserPtr) return Unbounded_String is
      --result : Unbounded_String := this.user_data.username;
      result   : Unbounded_String := this.getUsername;
      contacts : UserList.List    := this.getContacts;
   begin
      -- Trennzeichen
      Append (Source => result, New_Item => To_Unbounded_String (Protocol.Seperator));
      -- Passwort
      Append (Source => result, New_Item => this.getPassword);

      for contact of contacts loop
         -- Trennzeichen
         Append (Source => result, New_Item => To_Unbounded_String (Protocol.Seperator));
         -- Kontaktname
         Append (Source => result, New_Item => contact.getUsername);
      end loop;
      return result;
   end userToUnboundedString;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

   procedure StringToLonelyUser (inputLine : in String; contactNames : out contactNamesList.List; newUser : out UserPtr) is
      MessageParts : GNAT.String_Split.Slice_Set;
      MessagePart  : Unbounded_String;
      Count        : Slice_Number;
   begin
      newUser := new User;
      -- Nachricht wird an definiertem Trennzeichen zerstueckelt
      GNAT.String_Split.Create
        (S          => MessageParts,
         From       => inputLine,
         Separators => Protocol.Seperator,
         Mode       => GNAT.String_Split.Multiple);
      Count := GNAT.String_Split.Slice_Count (MessageParts);

      -- Slice 1: username
      newUser.setUsername (To_Unbounded_String (GNAT.String_Split.Slice (MessageParts, 1)));
      -- Slice 2: password
      newUser.setPassword (To_Unbounded_String (GNAT.String_Split.Slice (MessageParts, 2)));
      -- Slice rest: contacts
      for i in 3 .. Count loop
         contactNames.Append (New_Item => To_Unbounded_String (GNAT.String_Split.Slice (MessageParts, i)));
      end loop;
   end StringToLonelyUser;

   --------------------------------------------------------------------------------------------------------------------------------------------------------

end User_Databases;
