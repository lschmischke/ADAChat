/* ************************************************************
Beispielprogramm blink1.c
L¨asst auf dem Board eine LED endlos blinken
Kommentar zur Schaltung auf Board:
Leuchtdioden an P1.0 - P1.7 leuchten wenn Ausgang=L (0)
*/
#include <msp430x22x2.h> // Header-Datei mit den Hardwaredefinitionen f¨ur genau diesen MC
#include <lcd_bib.h>
#include <lcd_bib.c>

#define RED_BTN (0x01)
#define YEL_BTN (0x02)
#define GRE_BTN (0x04)
#define BLU_BTN (0x20)

void Warteschleife (long wartezeit);
void writeToLCD(int wert,char column,char row,char anzahlDigits);
unsigned char text [16];
int counter=0;
unsigned int taktA = 32768;
int sekunden=0;
int impulseProUmdrehung=24;
int main(void) {
  WDTCTL = WDTPW + WDTHOLD; // watchdog timer anhalten
  // Hardware-Konfiguration
  
  P2DIR = P2DIR & 0xD8; // 1101 1000 - Ports der Schalter auf Einlesen stellen
  P1DIR = 0xFF; // LED Port als Ausgang  
  TACTL = TASSEL_1 + TACLR;
  TBCTL = TBSSEL_0 + TBCLR;  // Beschreiben des TimerA-Controlregisters, es werden zwei Bits gesetzt:
                             //   - TimerA Source Select = 0 (Eingangstakt ist TBClock)
                             //   - Clear TimerA-Register    (Zählregister auf 0 setzen)
                             // Timer startet noch nicht
  
  P2IE = BIT0 | BIT1 | BIT2 | BIT5; // Port 2 Interrupt Enable an Leitung 0/1/2/5 -> Alle Tasten
  P2IES = BIT0 | BIT1 | BIT2 | BIT5; // Interrupt Edge Select -> fallende Flanke


  
  TACCTL0 = CCIE;
  TACCR0 = taktA;
  P4SEL = BIT7; //P7 soll alternativ angesteuert werden, füttert timerB
  P4DIR = ~BIT7; //P4.7 ist input, Rest ist Out
     
  lcd_init(16); //Initialisierung des Displays mit 16 Spalten
  lcd_clear(); //Display wird gelöscht
  writeToLCD(0,0,0,5);
  lcd_gotoxy(6, 0);
  lcd_puts("rounds/min");
 
  
  P4OUT=0;  //Strom an Moter ist aus
  P1OUT=0xFF; //??
  TACTL |= MC_1;              // Timer A im UpMode
  TBCTL |= MC_2;             // Start Timer_B im continous mode (Mode Control = 2)
  
 
 __enable_interrupt();      // enable general interrupt (Interrupts global frei schalten)
  while (1) {
    __low_power_mode_3();    // low power mode 0:  
    __no_operation();        // nur für C-Spy-Debugger
  }
    
  //return 0; // Statement wird nicht erreicht
}


// Timer A interrupt service routine
// wird jedesmal aufgerufen, wenn Interrupt CCR0 von TimerA kommt
int umdrehungen;
int speed;
#pragma vector=TIMERA0_VECTOR
__interrupt void Timer_A0 (void)
{
  //hardgecodet, aber am effektivsten
  writeToLCD(TBR*5/2,0,0,5);
  
  
  
  //überlauf ab ((2^16)-1)/60 = 1093 Impulse Pro Sekunde -> max 2730 Umdrehungen pro Minute
  //writeToLCD(TBR*60/impulseProUmdrehung,0,0,5);
  
  //Überlauf ab 5460 Umdrehungen pro Minute, dafür ungenauer
  //writeToLCD(TBR*30/impulseProUmdrehung*2,0,0,5);
  
  
  
  TBCTL |= TBCLR;
}

#pragma vector=PORT2_VECTOR
__interrupt void Port2ISR (void) {     
  int interruptWert = ~P2IN & 0x27; // 0x27 entspricht Bits 0/1/2/5 gesetzt
  lcd_gotoxy(0,1);
  switch (interruptWert) {
    case (BLU_BTN):
      //linkslauf
      //P4.6 soll angesteuert werden
      //P4.4 soll kein Strom bekommen
      P4OUT = BIT6;      
      lcd_puts("Linkslauf");
      break;
    case (GRE_BTN):
      //rechtslauf
      //P4.4 soll angesteuert werden
      //P4.6 soll kein Strom bekommen
      P4OUT = BIT4;
      lcd_puts("Rechtslauf");
      break;
    case (YEL_BTN) :
      //nix
      break;
    case (RED_BTN):
      //stop
      //P4.4 und P4.6 soll kein Strom bekommen
      P4OUT = 0;
      lcd_puts("Stopp     ");
      break;
  }
  
  
  Warteschleife(25000); // kompensiert Prellen
  P2IFG=0; // Interupt ist bearbeitet, Interrupt-Flag-Register löschen!!
}

void writeToLCD(int wert,char column,char row,char anzahlDigits) {
  uint2string(text,wert);
  lcd_gotoxy(column,row);
  lcd_puts(text+(5-anzahlDigits));
}

void Warteschleife (long wartezeit) {
  for (long i = 0; i< wartezeit;i++);
}