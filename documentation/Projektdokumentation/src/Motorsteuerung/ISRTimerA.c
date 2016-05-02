#pragma vector=TIMERA0_VECTOR
__interrupt void Timer_A0 (void) {
  unsigned int drehzahl = TBR*5/2;
  writeToLCD(drehzahl,0,0,5);
  TBCTL |= TBCLR; // Zaehlregister wird zurueckgesetzt
}