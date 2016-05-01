#include <msp430x22x2.h>
#include <lcd_bib.h>
#include <lcd_bib.c>
#include <string.h>

#define arraySize     100
#define telegrammSize 14

// Tasten
#define Taste_0       0
#define Taste_1       1
#define Taste_2       2
#define Taste_3       3
#define Taste_4       4
#define Taste_5       5
#define Taste_6       6
#define Taste_7       7
#define Taste_8       8
#define Taste_9       9
#define VolPlus      16
#define VolMinus     17
#define ChPlus       22
#define ChMinus      21
#define TV_AV        56
#define Standby      12
#define SmartPicture 13
#define SmartSound   36
#define Favorite     34
#define Mute         13
#define Menu         18
#define OK           47
#define Display      15
#define A_Ch         23  
#define Sleep        35
#define MTS          44

void Warteschleife(long);
void writeToLCD(int, char, char, char);
void piepen(char);
void goToState(int);
void executeKommando(int);

// Fernbedienung
#define KONFIG 0
#define RUNNING 1
#define STOPPED 2
#define BEEPING 3

unsigned char text[16];
int message[telegrammSize];
int dateCounter = 0;
int slowFlank = 58;
int fastFlank = 29;
int bitValue = 1;
int hilfsFlanke = 0;
int kommando = -1;
int oldToggleBit;

// TeaTimer
#define MaxTimer 65535
#define MaxPieps 5

long sekundenTakt = 32768;
unsigned int StartZeit = 0;
unsigned int vergangeneZeit = 0;
char state = 0;
char timerString[5];

void main(void) {
	WDTCTL = WDTPW + WDTHOLD;

	TACTL = TASSEL_1 + TACLR;
	TBCTL = TBSSEL_1 + TBCLR;

	TBCCTL0 = CCIE;

	P2IE = BIT3;        // Port 2 Interrupt Enable an Leitung 3
	P2IES = BIT3;       // Interrupt bei fallender Flanke an Leitung 3

	P2DIR |= BIT4;      // Konfiguration des Lautsprecher

	lcd_init(16); 
	lcd_clear(); 

	goToState(KONFIG);  // Anfangszustand
	lcd_gotoxy(0, 1);
	lcd_puts("Time: 00000");

	TACTL |= MC_2;      // Timer_A startet in Continuous-Mode

	__enable_interrupt();
	while (1) {
		__low_power_mode_3();
	}
}

// PORT2 interrupt service routine - von der Infrator-Schnittstelle
#pragma vector=PORT2_VECTOR
__interrupt void PORT2ISR(void) {
	int timerAReg = TAR;
	TAR = 0; // Register zuruecksetzen

	/* langsame Flanke */
	if (timerAReg < slowFlank + 10 && timerAReg > slowFlank - 10) {
		bitValue ^= 1; 
		message[dateCounter++] = bitValue; 
		hilfsFlanke = 0; 
	}
	/* schnelle Flanke */
	else if (timerAReg < fastFlank + 10 && timerAReg > fastFlank - 10) {
		// letzte Flanke war informationstragend, dies ist eine Hilfsflanke
		if (hilfsFlanke == 0) {
			hilfsFlanke = 1;
		}
		// letzte Flanke war Hilfsflanke, diese ist informationstragend
		else {
			message[dateCounter++] = bitValue;
			hilfsFlanke = 0; // war keine HilfsFlanke
		}
	}
	else {
		/* Zaehlwert liegt ausserhalb der definierten Werte, muss daher der Anfang eines neuen Telegramms sein */
		dateCounter = 0;
		bitValue = 1;
		message[dateCounter++] = bitValue;
	}
	P2IES = P2IES ^ BIT3; // toggle EdgeSelect

	/* Telegramm vollstaendig empfangen */
	if (dateCounter == telegrammSize) { 
		bitValue = 1; // Startwert des naechsten Telegramms
		dateCounter = 0;
		P2IES = BIT3; // soll wieder bei fallender Flanke ausloesen

		/* pruefe, ob neues Telegramm */
		int newToggleBit = message[2];
		if (newToggleBit != oldToggleBit) { 
			oldToggleBit = newToggleBit;
			kommando = 0;

			// setzt Kommando zusammen und stelle es dar
			for (char i = 8; i < telegrammSize; i++) {
				kommando = kommando << 1;
				kommando += message[i];
			}
			lcd_gotoxy(12, 0);
			lcd_puts("K: ");
			writeToLCD(kommando, 14, 0, 2);

			/* Fuehre Kommando aus */
			executeKommando(kommando);
		}
	}
	P2IFG = 0;  // Interupt bearbeitet, Interrupt-Flag-Register loeschen
}

void executeKommando(int kommando) {
	switch (state) {
	case KONFIG:
		if (kommando < 10) { // Ziffern-Tasten
			/* Ziffer an den aktuelle Statzeit anhaengen bis zu Max */
			if ((MaxTimer - kommando) / 10 < StartZeit) {
				StartZeit = MaxTimer;
			}
			else {
				StartZeit *= 10;
				StartZeit += kommando;
			}
			writeToLCD(StartZeit, 6, 1, 5);
		}
		else if (kommando == Display) {
			StartZeit = 0;
			writeToLCD(StartZeit, 6, 1, 5);
		}
		else if (kommando == OK) {
			goToState(RUNNING);
		}
		break;
	case RUNNING:
		if (kommando == Standby) {
			goToState(STOPPED);
		}
		break;
	case STOPPED:
		if (kommando == OK) {
			goToState(RUNNING);
		}
		else if (kommando == Display) {
			goToState(KONFIG);
		}
		break;
	case BEEPING:
		if (kommando == Mute) {
			goToState(KONFIG);
		}
		break;
	}
}

char blinkToggle = 0;
char anzahlPieps = 0;
// Timer_B0 interrupt service routine
#pragma vector=TIMERB0_VECTOR
__interrupt void Timer_B0(void) {
	switch (state) {
	case KONFIG:
		// ohne Funktion
		break;
	case RUNNING:
		// muss im Sekundentakt runterzaehlen
		vergangeneZeit++;
		if (StartZeit - vergangeneZeit == 0) {
			goToState(BEEPING);
		}
		writeToLCD(StartZeit - vergangeneZeit, 6, 1, 5);
		break;
	case STOPPED:
		// Timer steht - Restanzeige muss blinken
		if (blinkToggle == 1) {
			writeToLCD(StartZeit - vergangeneZeit, 6, 1, 5);
		}
		else {
			lcd_gotoxy(6, 1);
			lcd_puts("-----");
		}
		blinkToggle ^= 1;
		break;
	case BEEPING:
		piepen(2); // Doppel-Piepen
		anzahlPieps++;
		if (anzahlPieps == MaxPieps) {
			goToState(KONFIG);
		}
		break;
	}
}

void Warteschleife(long dauer) {
	for (long i=0; i<dauer; i++) {}
}

void writeToLCD(int wert, char column, char row, char anzahlDigits) {
	uint2string(text, wert);
	lcd_gotoxy(column, row);
	lcd_puts(text + (5 - anzahlDigits));
}

void piepen(char anzahlPieps) {
	int frequenz = 200; // hoeherer Wert entspricht tieferer Ton
	int dauerTon = 100; // entspricht NICHT Sekunden
	for (char pieps = 0; pieps < anzahlPieps; pieps++) {  
		/* Ton-Phase */
		for (long i = 0; i < dauerTon; i++) {
			Warteschleife(frequenz);
			P2OUT ^= BIT4; 
		}
		/* Pause-Phase */
		// wartet entsprechend der Dauer des Tons
		Warteschleife(dauerTon*frequenz); 
	}
}

void goToState(int newState) {
	state = newState;
	
	switch (newState) {
	case KONFIG:
		TBCTL = MC_0; // Timer anhalten
		vergangeneZeit = 0;
		StartZeit = 0;
		anzahlPieps = 0;
		writeToLCD(StartZeit, 6, 1, 5);
		lcd_gotoxy(0, 0);
		lcd_puts("Konfig ");
		break;
	case RUNNING:
		if (StartZeit == 0) goToState(BEEPING);
		else {
			TBCCR0 = sekundenTakt;
			TBCTL = TBSSEL_1 + TBCLR;
			TBCTL |= MC_1; // Starten im Up-Mode
			lcd_gotoxy(0, 0);
			lcd_puts("Running");
			writeToLCD(StartZeit - vergangeneZeit, 6, 1, 5);
		}
		break;
	case STOPPED:
		TBCCR0 = sekundenTakt / 2;
		TBCTL |= TBCLR;
		lcd_gotoxy(0, 0);
		lcd_puts("Stopped");
		break;
	case BEEPING:
		TBCCR0 = sekundenTakt;
		TBCTL = TBSSEL_1 + TBCLR;
		TBCTL |= MC_1;
		lcd_gotoxy(0, 0);
		lcd_puts("Beeping");
		break;
	}
}

