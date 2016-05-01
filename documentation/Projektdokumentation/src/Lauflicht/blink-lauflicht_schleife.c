#include <msp430x22x2.h>   // Headerdatei mit Hardwaredefinitionen

// Funktions-Prototypen
void Warteschleife(unsigned long wartezeit);   // Software Warteschleife

int main(void) {

  WDTCTL = WDTPW + WDTHOLD;	  // Watchdog-Timer anhalten

  // Hardware-Initialisierung
  // Port 1 arbeitet mit allen Leitungen (P1.0-P1.7) als Ausgabeport
  P1DIR = 0xFF; 
  
  unsigned char bitmaske = 0x01;
  unsigned long wartezeit  = 25000;
  while(1) {   // Endlosschleife
    for (unsigned char i=0; i<7; i++) {   
	  // hochzaehlen (von rechts nach links)
      P1OUT = ~bitmakse;
      bitmaske = bitmaske << 1;
      Warteschleife(wartezeit);
    } 
    for (unsigned char i=0; i<7; i++) {   
	  // runterzaehlen (von links nach rechts)
      P1OUT = ~bitmaske;
      bitmaske = bitmaske >> 1;
      Warteschleife(wartezeit);
    }    
  }
  
 // return 0;   // Statement wird niemals erreicht 
}

void Warteschleife(unsigned long wartezeit) {
	unsigned long i;    
	for (i=wartezeit; i>0; i--);
}
