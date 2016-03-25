package body MatchPackage is
   procedure getPlayers( this : Match; players : out PlayerList) is
   begin
      players := this.players;
   end getPlayers;

end MatchPackage
