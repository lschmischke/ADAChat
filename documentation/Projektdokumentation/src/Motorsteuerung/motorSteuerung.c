#include <msp430x22x2.h>
#include <lcd_bib.h>
#include <lcd_bib.c>

#define RED_BTN (0x01)
#define YEL_BTN (0x02)
#define GRE_BTN (0x04)
#define BLU_BTN (0x20)

void Warteschleife (long wartezeit);
void writeToLCD(int wert,char column,char row,char anzahlDigits);

unsigned char text [16];
unsigned int taktA = 32768;
int counter=0;
int sekunden=0;
int impulseProUmdrehung=24;

int main(void) {
  WDTCTL = WDTPW + WDTHOLD;
  
  // Hardware-Konfiguration
  P2DIR = P2DIR & 0xD8; // 1101 1000 - Ports der Schalter auf Einlesen
  P1DIR = 0xFF;         // LED Ports als Ausgang
  
  // Beschreiben des TimerA-Controlregisters, zwei Bits setzen:
        //   - TimerA Source Select = 1 (Eingangstakt ist TAClock)
        //   - Clear TimerA-Register    (Zaehlregister auf 0 setzen)
        //   - Timer startet noch nicht  
  TACTL = TASSEL_1 + TACLR;
  TBCTL = TBSSEL_0 + TBCLR;  
  
  // Port 2 Interrupt Enable an Leitung 0/1/2/5 -> Alle Tasten
  P2IE = BIT0 | BIT1 | BIT2 | BIT5;
  // Interrupt Edge Select -> fallende Flanke  
  P2IES = BIT0 | BIT1 | BIT2 | BIT5; 

  TACCTL0 = CCIE;
  TACCR0 = taktA;
  P4SEL = BIT7;  // P7 soll alternativ angesteuert werden
  P4DIR = ~BIT7; // P4.7 ist Input, Rest Output
     
  lcd_init(16);
  lcd_clear(); 
  writeToLCD(0,0,0,5);
  lcd_gotoxy(6, 0);
  lcd_puts("rounds/min");
 
  P4OUT=0;       // Strom an Motor ist aus
  P1OUT=0xFF;
  
  TACTL |= MC_1; // Start Timer_A im Up-Mode
  TBCTL |= MC_2; // Start Timer_B im Continuous-Mode
  
 
 __enable_interrupt();      
  while (1) {
    __low_power_mode_3();    
    __no_operation();    // nur fuer C-Spy-Debugger
  }
    
  // return 0;
}


// Timer_A interrupt service routine
#pragma vector=TIMERA0_VECTOR
__interrupt void Timer_A0(void) {
	unsigned int drehzahl = TBR * 5 / 2;
	writeToLCD(drehzahl, 0, 0, 5);
	TBCTL |= TBCLR; // Zaehlregister wird zurueckgesetzt
}

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
      // keine Funktion
      break;
    case (RED_BTN):
      // Stop
      // P4.4 und P4.6 soll kein Strom bekommen
      P4OUT = 0;
      lcd_puts("Stopp     ");
      break;
  }
   
  Warteschleife(25000); // kompensiert Prellen
  P2IFG=0;              // Interupt bearbeitet, Flag-Register loeschen
}

void writeToLCD(int wert,char column,char row,char anzahlDigits) {
  uint2string(text,wert);
  lcd_gotoxy(column,row);
  lcd_puts(text+(5-anzahlDigits));
}

void Warteschleife (long wartezeit) {
  for (long i=0; i<wartezeit; i++);
}