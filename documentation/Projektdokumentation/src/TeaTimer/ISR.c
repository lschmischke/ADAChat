#pragma vector=TIMERA0_VECTOR
__interrupt void Timer_A0 (void)
{
  intCounter++;
  // Sekunden auf Display anzeigen
  writeToLCD(sekunden-intCounter,1,1,5);
  P1OUT = ~(sekunden-intCounter); // Zeit mit LEDS anzeigen
  if(intCounter == sekunden) {
    TACTL = MC_0; // Timer wird angehalten
    lcd_gotoxy(1,1);
    lcd_puts("FERTIG");
    P1OUT = 0x00; // Alle LEDs an
    piepen(10);
  } 
}
