#include  <msp430x22x2.h>
#include <lcd_bib.h>
#include <lcd_bib.c>

void Warteschleife(long);
void writeToLCD(int,char,char,char);
void piepen(int);

long takt = 32768;
int sekunden = 20;
int intCounter = 0;
unsigned char text [16];

void main(void) {
  WDTCTL = WDTPW + WDTHOLD;  // Stop Watchdog Timer

  TACTL = TASSEL_1 + TACLR;  
  // Interrupt-Ausloesung durch Capture/Compare-Unit0 freischalten
  TACCTL0 = CCIE;
  // Capture/Compare-Register 0 mit Zaehlwert belegen  
  TACCR0 = takt; 

  P1DIR |= 0xFF; 
  P2DIR |= BIT4; // Konfiguration Lautsprecher
  
  lcd_init(16);  
  lcd_clear();
  lcd_gotoxy(0,0);
  lcd_puts("TeaTimer");
  writeToLCD(sekunden,1,1,5); // Startwert anzeigen
  P1OUT = ~sekunden;
  
  
  TACTL |= MC_1;             // Start Timer_A im Up-Mode
  __enable_interrupt();      // Interrupts global freischalten
  while (intCounter != sekunden) {
    __low_power_mode_0();    
    __no_operation();        // nur fuer C-Spy-Debugger
  }   
}

// Timer A0 interrupt service routine
// wird jedesmal aufgerufen, wenn Interrupt CCR0 von Timer_A kommt
#pragma vector=TIMERA0_VECTOR
__interrupt void Timer_A0 (void) {
  intCounter++;
  writeToLCD(sekunden-intCounter,1,1,5); // Zeit auf LCD anzeigen
  P1OUT = ~(sekunden-intCounter);        // Zeit mit LEDs anzeigen
  if(intCounter == sekunden) {
    TACTL = MC_0;                        // Timer wird angehalten
    lcd_gotoxy(1,1);
    lcd_puts("FERTIG");
    P1OUT = 0x00;                        // Alle LEDs an
    piepen(10);
  } 
}

void piepen(int anzahlPieps) {
	int frequenz = 200; // hoeherer Wert entspricht tieferem Ton
	int dauerTon = 100; // keine genaue Zeiteinheit
	for (int i=0; i<anzahlPieps; i++) {  
		for (int j=0; i<dauerTon; j++) {
			Warteschleife(frequenz);
			P2OUT ^= BIT4; 
		}
		// wartet entsprechend der Dauer des Tons
		Warteschleife(dauerTon*frequenz); 
	}
}

void Warteschleife(long dauer) {
  for(long i=0; i<dauer; i++) {}
}

void writeToLCD(int wert,char column,char row,char anzahlDigits) {
  uint2string(text,wert);
  lcd_gotoxy(column,row);
  lcd_puts(text+(5-anzahlDigits));
}
