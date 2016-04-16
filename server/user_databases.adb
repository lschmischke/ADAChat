package body User_Databases is

   function registerUser(this : in out User_Database; username : in String; password : in String) return Boolean is
      user : UserPtr;
      bool : Boolean;
      contacts : ContactList.List;

   begin
      setUsername(user, To_Unbounded_String(username));

      bool := setPassword(user, To_Unbounded_String( password));
      setContacts(user, contacts);

      User_Maps.Insert(Container => this.users,
                       Key       => To_Unbounded_String(username),
                       New_Item  => user);
      -- # TODO Constraint_Error, wenn Key schon vorhanden, muss abgefangen werden #
      return true;

   Exception
      when Constraint_Error =>
           return false;

   end registerUser;

   function getUser(database : in User_Database; username : in Unbounded_String) return UserPtr is
      user: UserPtr;
   begin
      user := database.users.Element(Key => username);
      return user;

   Exception
      when Constraint_Error =>
         Put_Line("User '"&To_String(username)&"' not found in database");
         return null;

   end getUser;


   procedure saveUserDatabase(this : in User_Database) is
      Write_To : String := To_String(this.databaseFileName);
      DataFile : File_type;
      usermap : User_Maps.map :=this.users;
   begin
      begin
      Open(File => DataFile,
           Mode => Out_File,
           Name => Write_To);
      exception
         when others => --# welcher Fehler wird hier normalerweise geworfen? #
            Create(File => DataFile,
                   Mode => Out_File,
                   Name => Write_To);
      end;

      for user of usermap loop
         --# schreibe jeden User in eine Line im folgenden Format
         --# username:userpasswort[:contact]*
         Put_Line(DataFile, To_String(userToUnboundedString(this => user)));
      end loop;
      Close(DataFile);
   end saveUserDatabase; -- writes User Database to file

   procedure loadUserDatabase(this : in out User_Database) is
      Read_From : String := To_String(this.databaseFileName);
      DataFile : File_type;
      contactNames : contactNamesList.List;
      userToContactNames : userToContactNamesMap.Map;
   begin
       begin
      Open(File => DataFile,
           Mode => In_File,
           Name => Read_from);
      exception
         when others => --# welcher Fehler wird hier normalerweise geworfen? #
            Put_line("ERROR: Userdatabase file doesn't exist. Creating Userdatabase file with name: "& To_String(this.databaseFileName));
            Create(File => DataFile,
                   Mode => In_File,
                   Name => Read_From);
            return;
      end;

      --#Erster Durchgang lege alle Benutzer an, Benutzer haben noch keine Kontakte
      Put_Line("Reading from database file, first iteration.");
      begin

         loop
            declare
               --# lese Line aus dem File
               userLine : String := Get_Line(DataFile);

               --# konvertiere Line in User
               user : UserPtr;
            begin
               Put_Line("Read from database file: "&userLine);
               user:= StringToLonelyUser(userLine, this, contactNames);

               --#f�ge User zur Map hinzu
               this.users.Insert(Key      => getUsername(user),
                                 New_Item => user);
                --#speichere gefundene Kontaktnamen zwischen
               userToContactNames.Insert(Key      => getUsername(user),
                                         New_Item => contactNames);
               contactNames.Clear;


            end;
         end loop;

      Exception
         when Error:Ada.IO_Exceptions.End_Error =>
            Close(DataFile);
         when Error:others =>
            Put_Line(Exception_Information(Error));
            Close(DataFile);
      end;

      Put_Line("Reading from database file, second iteration.");
      --#zweiter Durchgang: da alle User angelegt sind, k�nnen nun die Kontakte gekn�pft werden
      declare
         Index : userToContactNamesMap.Cursor := userToContactNames.First;
      begin
         --#durchlaufe alle user (map)
         while Index /= userToContactNamesMap.No_Element loop
            declare
               user : UserPtr := getUser(this,username => Key (Index));
               bool : boolean;
            begin
               --# durchlaufe alle kontaktnamen eines users (liste)
               for contactName of userToContactNames.Element(Key => key(index)) loop
                  declare
                     contact : UserPtr := getUser(this, contactName);
                  begin
                     if contact /= null then
                        Put_Line("Adding contact " & To_String(contactName) & " to user '"&To_String(getUsername(user))&"'");
                        bool := addContact(user,contact);
                     end if;

                    end;

               end loop;
            end;
            Index := Next(Index);
         end loop;
      end;
   end loadUserDatabase; -- loads user database from file

   function userToUnboundedString(this : in out UserPtr) return Unbounded_String is
      --result : Unbounded_String := this.user_data.username;
      result : Unbounded_String := getUsername(this);
      contacts : ContactList.List := getContacts(this);
   begin
      --#Trennzeichen
      Append(Source   => result,
             New_Item => To_Unbounded_String(Protocol.Seperator));
      --#Passwort
      Append(Source   => result,
             New_Item => getPassword(this));

      for contact of contacts loop
         --#Trennzeichen
         Append(Source   => result,
                New_Item => To_Unbounded_String(Protocol.Seperator));
         --#Kontaktname
         Append(Source   => result,
              New_Item => getUsername(contact));
      end loop;
      return result;
   end userToUnboundedString;


   function StringToLonelyUser(inputLine : in String; database : in User_Database; contactNames : out contactNamesList.List ) return UserPtr is
      MessageParts : GNAT.String_Split.Slice_Set;
      MessagePart : Unbounded_String;
      Count : Slice_Number;
      newUser: UserPtr := new User;
      bool : Boolean;

   begin
      -- # Nachricht wird an definiertem Trennzeichen zerstueckelt #
      GNAT.String_Split.Create(S => MessageParts, From => inputLine,
                               Separators => Protocol.Seperator, Mode => GNAT.String_Split.Multiple);
      Count := GNAT.String_Split.Slice_Count(MessageParts);

      --#TODO: Pruefen, ob Nachricht richtiges Format


      --#Slice 1: username
      setUsername(newUser,To_Unbounded_String(Gnat.String_Split.Slice(MessageParts, 1)));
      --#Slice 2: password
      bool := setPassword(newUser,To_Unbounded_String(Gnat.String_split.slice(MessageParts, 2)));
      --#Slice rest: contacts
      for i in 3 .. Count loop
         contactNames.Append(New_Item => To_Unbounded_String(Gnat.String_split.slice(MessageParts, i)));
      end loop;


      return newUser;

   end StringToLonelyUser;

end User_Databases;
