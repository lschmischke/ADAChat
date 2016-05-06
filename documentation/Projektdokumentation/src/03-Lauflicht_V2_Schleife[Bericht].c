/** ************************************************************************

  Datei blink1.c

  Ablauffähig auf Hardware: MSP430-Education-Board mit MSP430F2272

  Lässt auf dem MSP430-Edu-Board eine LED blinken

  Kommentar zur Schaltung auf Board:
     P1.0 - P1.7              LED leuchtet wenn Ausgang=L (0)

   Autor:   Daniel Kreck, Leonard Schmischke
   Stand:   22.10.2015
*/

#include <msp430x22x2.h>

// Funktions-Prototypen
void Warteschleife(unsigned long Anzahl);          // Software Warteschleife

int main(void) {

  WDTCTL = WDTPW + WDTHOLD;  	     // Watchdog timer anhalten

  // Hardware-Initialisierung
  P1DIR = 0xFF;           // Port 1 arbeitet mit allen Leitungen (P1.0-P1.7) als Ausgabeport
  
  unsigned char value = 0x01; // 0 0 0 0   0 0 0 1
  while(1)    // Endlosschleife
  {
    for (unsigned char i=0;i<7;i++) {
      P1OUT = ~value; // im ersten Durchgang: 1 1 1 1   1 1 1 0
      value = value << 1; // 0 0 0 0   0 0 1 0
      Warteschleife(25000);
    } 
	// nach 1. Schleife steht value auf: 1 0 0 0   0 0 0 0
    for(unsigned char i =0;i<7;i++) {
      P1OUT = ~value; // im ersten Durchgang: 0 1 1 1   1 1 1 1
      value = value >> 1; // 0 1 0 0   0 0 0 0
      Warteschleife(25000);
    }    
	// nach 2. Schleife steht value auf: 0 0 0 0   0 0 0 1
}
  
 // return 0;    // eigentlich richtig, Statement wird aber niemals erreicht 
}


void Warteschleife(unsigned long Anzahl){
unsigned long i;    
for (i = Anzahl; i > 0; i--);   // Schleifenvariable herunterzählen
}
