TACTL = TASSEL_1 + TACLR;	
// TimerA Source Select = 1 (Eingangstakt ist AClock)
// Clear TimerA-Register    (Zaehlregister auf 0 setzen)

// Interrupt-Ausloesung durch Capture/Compare-Unit0 freischalten (CCR0)
TACCTL0 = CCIE;				

// Capture/Compare-Register 0 mit Zaehlwert belegen
long takt = 32768;
TACCR0 = takt;				
