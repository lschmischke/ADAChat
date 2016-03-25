with Ada.Text_IO; use Ada.Text_IO;
with gameMain; use gameMain;

package sspPackage is

    Type choices is (Rock, Paper, Scissors);
   package Choices_IO is new Enumeration_IO(choices);

   Type schere is new gameMain.gameParent with record
      p1choice :  choices;
      p2choice :  choices;
   end record;







   procedure startGame(this : in out schere);
   --procedure setPlayerChoice(playerNumber : in Natural; choice : in choices);
   --procedure evaluateWinner;

end sspPackage ;
