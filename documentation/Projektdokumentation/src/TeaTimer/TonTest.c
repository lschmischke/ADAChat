#include  <msp430x22x2.h>

void main(void) {
	WDTCTL = WDTPW + WDTHOLD;  // Stop  Watchdog Timer
	P2DIR |= BIT4;
	while (1) {
		for (int i = 0; i < 1000; i++) {
			//hier ist laut
			for (int j = 0; j < 500; j++) {} //Warteschleife
			P2OUT ^= BIT4;
		}
		for (int i = 0; i < 50000; i++) {
			//hier ist leise
		}
	}
}

