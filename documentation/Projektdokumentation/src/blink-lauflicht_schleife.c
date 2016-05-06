/**********************************************************************

  Datei blink1.c

  Ablauffaehig auf Hardware: MSP430-Education-Board mit MSP430F2272

  Laesst auf dem MSP430-Edu-Board eine LED blinken

  Kommentar zur Schaltung auf Board:
     P1.0 - P1.7              LED leuchtet wenn Ausgang=L (0)

   Autor:   Daniel Kreck, Leonard Schmischke
   Stand:   22.10.2015
*/

#include <msp430x22x2.h>   \\Headerdatei mit Hardwaredefinitionen

// Funktions-Prototypen
void Warteschleife(unsigned long wartezeit);   // Software Warteschleife

int main(void) {

  WDTCTL = WDTPW + WDTHOLD;	  // Watchdog-Timer anhalten

  // Hardware-Initialisierung
  P1DIR = 0xFF;   // Port 1 arbeitet mit allen Leitungen (P1.0-P1.7) als Ausgabeport
  
  unsigned char bitmaske = 0x01;
  unsigned long wartezeit  = 25000;
  while(1) {   // Endlosschleife
    for (unsigned char i=0; i<7; i++) {   // hochzaehlen (von rechts nach links)
      P1OUT = ~bitmakse;
      bitmaske = bitmaske << 1;
      Warteschleife(wartezeit);
    } 
    for (unsigned char i=0; i<7; i++) {   // runterzaehlen (von links nach rechts)
      P1OUT = ~bitmaske;
      bitmaske = bitmaske >> 1;
      Warteschleife(wartezeit);
    }    
  }
  
 // return 0;   // eigentlich richtig, Statement wird aber niemals erreicht 
}

void Warteschleife(unsigned long wartezeit){
	unsigned long i;    
	for (i=wartezeit; i>0; i--);   // Schleifenvariable herunterzaehlen
}
