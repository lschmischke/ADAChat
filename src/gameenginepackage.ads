with Ada.Containers.Hashed_Maps; use Ada.Containers;
with MatchPackage; use MatchPackage;
with ada.Strings.Unbounded; use Ada.Strings.Unbounded;


package GameEnginePackage is

   function ID_Hashed (id : Natural) return Hash_Type;



   Package MatchMapDef is new Ada.Containers.Hashed_Maps(Key_Type        => Natural,
                                                         Element_Type    => Match,
                                                         Hash            => ID_Hashed,
                                                         Equivalent_Keys => "=");
   Package GameMapDef is new Ada.Containers.Hashed_Maps(Key_Type        => Natural,
                                                        Element_Type    => Unbounded_String,
                                                        Hash            => ID_Hashed,
                                                        Equivalent_Keys => "=");

   type gameObject is range 0 .. 1;
   type gameEngine is record
      matchIDCounter : Natural := 0;
      gameIDCounter : Natural := 0;
      matchMap : MatchMapDef.Map;
      gameList : GameMapDef.Map;
   end record;
   procedure registerGame(this : in out gameEngine; gameName : Unbounded_String);
   procedure broadcastPlayerTurn(this :in out GameEngine; matchID : Natural; gameObj : in gameObject);
   procedure startMatch(this : in out GameEngine; gameID : Natural; playerAID : Natural; playerBID : Natural);
   procedure closeMatch(this : in out GameEngine; matchID : Natural);
   procedure broadcastGameList;

end GameEnginePackage;
