with MatchPackage; use MatchPackage;


package body gameenginepackage is
   function ID_Hashed ( id : Natural) return Hash_Type is
   begin
      return Ada.Containers.Hash_Type(id);
   end ID_hashed;




   procedure broadcastPlayerTurn(this : in out GameEngine; matchID : Natural; gameObj : in gameObject) is
      players : PlayerList.List;
      thisMatch : Match;
      begin
      --find players involved with matchID
      thisMatch := this.matchMap.Element(Key => matchID);


      --broadcast player turn to those players
      for player in players.Iterate loop
         --broadcast something
         null;
      end loop;

   end broadcastPlayerTurn;

   procedure startMatch(this : in out GameEngine; gameID : Natural; playerAID : Natural; playerBID : Natural) is
      match : MatchPackage.Match;
   begin
      -- create new match and map it
      match.matchID := this.matchIDCounter;
      this.matchIDCounter := this.matchIDCounter+1;
      match.gameID :=  gameID;
      match.players.Append(playerAID);
      match.players.Append(playerBID);

      this.matchMap.Insert(Key      => match.matchID,
                           New_Item => match);

      -- broadcast new match to involved players
   end startMatch;

   procedure closeMatch(this : in out GameEngine; matchID : Natural) is
      begin
      --broadcast to players that match is closed
      --delete match out of map
      this.matchMap.Delete(Key => matchID);
      end closeMatch;

   procedure registerGame(this : in out gameEngine; gameName : Unbounded_String) is
   begin
      this.gameList.Insert(Key      => this.gameIDCounter,
                           New_Item => gameName);
      this.gameIDCounter := this.gameIDCounter +1;
   end registerGame;

   procedure broadcastGameList is null;


end gameenginepackage;
