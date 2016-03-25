with Ada.Containers.Doubly_Linked_Lists;

package MatchPackage is

   Package PlayerList is new Ada.Containers.Doubly_Linked_Lists(Element_Type => Natural);

   Type Match is record
      matchID : Natural;
      gameID : Natural;
      players : PlayerList.List;

   end record;



   procedure getPlayers(this : Match; players : out PlayerList.List);

end MatchPackage;
