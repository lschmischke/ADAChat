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
   begin
      return database.users.Element(Key => username);
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
      usermap : User_Maps.map;
   begin
       begin
      Open(File => DataFile,
           Mode => In_File,
           Name => Read_from);
      exception
         when others => --# welcher Fehler wird hier normalerweise geworfen? #
            Put_line("Userdatabase file doesn't exist.");
            return;
      end;

      begin
         loop
            declare
               --# lese Line aus dem File
               userLine : String := Get_Line(DataFile);
               --# konvertiere Line in User
               user : UserPtr := StringToUser(userLine, this);
            begin
               null;
            end;
         end loop;
      Exception
         when others =>
            Close(DataFile);
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

   function StringToUser(inputLine : in String; database : in User_Database) return UserPtr is
      MessageParts : GNAT.String_Split.Slice_Set;
      MessagePart : Unbounded_String;
      Count : Slice_Number;
      user : UserPtr;
      bool : Boolean;
   begin
      -- # Nachricht wird an definiertem Trennzeichen zerstueckelt #
      GNAT.String_Split.Create(S => MessageParts, From => inputLine,
                               Separators => Protocol.Seperator, Mode => GNAT.String_Split.Multiple);
      Count := GNAT.String_Split.Slice_Count(MessageParts);

      --#TODO: Pruefen, ob Nachricht richtiges Format


      --#Slice 1: username
      setUsername(user,To_Unbounded_String(Gnat.String_Split.Slice(MessageParts, 1)));
      --#Slice 2: password
      bool := setPassword(user,To_Unbounded_String(Gnat.String_split.slice(MessageParts, 2)));
      --#Slice rest: contacts
      for i in 3 .. Count loop
         --slice username, suche username, füge username zur contactliste hinzu
         declare
            contactName : Unbounded_String := To_Unbounded_String(Gnat.String_split.slice(MessageParts, i));
            newContact : UserPtr := GetUser(database      => database ,
                                         username => contactName);
         begin
            bool := addContact(this         => user,
                       contactToAdd => newContact);
         end;
      end loop;

      return user;

   end StringToUser;

end User_Databases;
