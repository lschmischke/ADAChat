/** ************************************************************************

  Datei blink1.c

  Ablauffähig auf Hardware: MSP430-Education-Board mit MSP430F2272

  Lässt auf dem LCD Display des MSP430-Edu-Boards "Hallo Welt" erscheinen.

   Autor:   Daniel Kreck, Leonard Schmischke
   Stand:   5.10.2009
*/

#include <msp430x22x2.h>
#include <lcd_bib.h>
#include <lcd_bib.c>

#define RED_BTN (0x01)
#define YEL_BTN (0x02)
#define GRE_BTN (0x04)
#define BLU_BTN (0x20)

// Funktions-Prototypen
void Warteschleife(unsigned long Anzahl); // Software Warteschleife
unsigned int result = 0x00; // aktueller Wert des TR
unsigned char text [] = ""; // CharArray für Textausgabe (LCD)
void writeToLCD(int wert,char column,char row,char anzahlDigits);

int main (void) {

  WDTCTL = WDTPW + WDTHOLD;  	     // Watchdog timer anhalten

  // Hardware-Initialisierung
  P1DIR = 0xFF; //alle LED Ports sind Out - Ausgabe ist 1  
  P2DIR = P2DIR & 0xD8; // 1101 1000 - Ports der Schalter auf Einlesen stellen (0 = Einlesen)
  
  lcd_init(16); //Initialisierung des Displays mit 16 Spalten
  lcd_clear(); //Display wird gelöscht
  lcd_gotoxy(0,0); //Cursor wird auf 0,0 gesetzt
  
  P1OUT = ~result; //Startwert auf LEDs
  
  P2IE = BIT0 | BIT1 | BIT2 | BIT5; // Port 2 Interrupt Enable an Leitung 0/1/2/5 -> Alle Tasten
  P2IES = BIT0 | BIT1 | BIT2 | BIT5; // Interrupt Edge Select -> fallende Flanke  
  
  
  lcd_gotoxy(0,0);
  lcd_puts("Taschenrechner");
  writeToLCD(0,1,1,5);
  __enable_interrupt(); // enable general interrupt (Interrupts global frei schalten)
  
  __low_power_mode_4(); // MSP430-Guide S.199
    
  //Endlosschleife
  while(1) {}
  // return 0;    Wird nicht erreicht
}

void Warteschleife(unsigned long Anzahl) {
  unsigned long i;    
  for (i = Anzahl; i > 0; i--);   // Schleifenvariable herunterzählen
}

void writeToLCD(int wert,char column,char row,char anzahlDigits) {
  uint2string(text,wert);
  lcd_gotoxy(column,row);
  lcd_puts(text+(5-anzahlDigits));
}

#pragma vector=PORT2_VECTOR
__interrupt void Port2ISR (void) {     
  int interruptWert = P2IFG & 0x27; // 0x27 entspricht Bits 0/1/2/5 gesetzt
  lcd_clear();
  writeToLCD(result,0,0,5);
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
  writeToLCD(result,1,1,5);  
  P1OUT = ~result; // LEDs zeigen Wert
  Warteschleife(25000); // kompensiert Prellen
  P2IFG=0; // Interupt ist bearbeitet, Interrupt-Flag-Register löschen!!
}


