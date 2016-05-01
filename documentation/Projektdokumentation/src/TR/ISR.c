#pragma vector=PORT2_VECTOR
__interrupt void Port2ISR (void) {     
  int interruptWert = P2IFG & (BIT0 | BIT1 | BIT2 | BIT5);
  lcd_clear();
  writeToLCD(result, 0, 0, 5); //alter Wert
  switch (interruptWert) {
    case (BLU_BTN):
      result++;
      lcd_gotoxy(5,0);
      lcd_puts("+1");
      break;
    case (GRE_BTN):
      result--;
      lcd_gotoxy(5,0);
      lcd_puts("-1");
      break;
    case (YEL_BTN) :
      result = result << 1;
      lcd_gotoxy(5,0);
      lcd_puts("*2");
      break;
    case (RED_BTN):
      result = result >> 1;
      lcd_gotoxy(5,0);
      lcd_puts("/2");
      break;
  }
  lcd_gotoxy(0,1);
  lcd_puts("=");
  writeToLCD(result,1,1,5);  // neuer Wert
  P1OUT = ~result; // LEDs zeigen Wert
  Warteschleife(25000); // kompensiert Prellen
  P2IFG=0; // Interupt ist bearbeitet, Interrupt-Flag-Register loeschen!!
}


