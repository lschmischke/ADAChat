with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;


package body sspPackage is

   procedure startGame(this : in out schere ) is



   begin
      Put_Line("Welcome to Rock-Paper-Scissors!");
      loop
         Put_Line("Player 1, enter your choice:");
         Put_Line("0 for Rock, 1 for Paper, 2 for Scissors");

         Choices_IO.Get(this.p1choice);
         Put_Line("Player 2, enter your choice:");
         Put_Line("0 for Rock, 1 for Paper, 2 for Scissors");
         Choices_IO.Get(this.p2choice);

         if(this.p1choice=this.p2choice) then
            Put_Line("DRAW");
         elsif (this.p1choice = choices'Last and then this.p2choice = choices'First) then
            Put_Line("Player 1 won with " & choices'image(this.p1choice) & " against Player 2's "& choices'image(this.p2choice)& ".") ;
         elsif(choices'Succ(this.p1choice) = this.p2choice) then
            Put_Line("Player 2 won with " & choices'image(this.p2choice) & " against Player 1's "& choices'image(this.p1choice)& ".") ;
         else
            Put_Line("Player 1 won with " & choices'image(this.p1choice) & " against Player 2's "& choices'image(this.p2choice)& ".") ;
         end if;
         New_Line;

      end loop;

   end startGame;


end sspPackage;
