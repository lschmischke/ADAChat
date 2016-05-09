#pragma vector=PORT2_VECTOR
__interrupt void Port2ISR (void) {     
  int interruptWert = P2IFG & (BIT0 | BIT1 | BIT2 | BIT5);
  lcd_gotoxy(0,1);
  switch (interruptWert) {
    case (BLU_BTN):
      // Linkslauf
      // P4.6 soll angesteuert werden
      // P4.4 soll kein Strom bekommen
      P4OUT = BIT6;      
      lcd_puts("Linkslauf");
      break;
    case (GRE_BTN):
      // Rechtslauf
      // P4.4 soll angesteuert werden
      // P4.6 soll kein Strom bekommen
      P4OUT = BIT4;
      lcd_puts("Rechtslauf");
      break;
    case (YEL_BTN) :
      // ohne Funktion
      break;
    case (RED_BTN):
      // Stop
      // P4.4 und P4.6 soll kein Strom bekommen
      P4OUT = 0;
      lcd_puts("Stopp     ");
      break;
  }
  
  Warteschleife(25000); // kompensiert Prellen
  P2IFG=0; // Interupt ist bearbeitet, Interrupt-Flag-Register loeschen!
}
