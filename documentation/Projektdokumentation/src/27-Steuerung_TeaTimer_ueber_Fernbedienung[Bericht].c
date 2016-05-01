// ****************************************************************************
//
//       FernbedienungInterruptA1.c
//       8.10.2008
//
// ****************************************************************************

#include  <msp430x22x2.h>
#include <lcd_bib.h>
#include <lcd_bib.c>
#include <string.h>

#define arraySize 1000
#define telegrammSize 14

//Tasten
#define Taste_0 0
#define Taste_1 1
#define Taste_2 2
#define Taste_3 3
#define Taste_4 4
#define Taste_5 5
#define Taste_6 6
#define Taste_7 7
#define Taste_8 8
#define Taste_9 9
#define VolPlus    16
#define VolMinus    17
#define ChPlus     22
#define ChMinus     21
#define TV_AV   56
#define Standby 12
#define SmartPicture  13
#define SmartSound    36
#define Favorite  34
#define Mute  13
#define Menu  18
#define OK    47
#define Display 15
#define A_Ch  23  
#define Sleep 35
#define MTS   44

void Warteschleife(long);
void writeToLCD(int,char,char,char);
void piepen(char);
void goToState(int);

unsigned char text [16];

//Fernbedienung

#define KONFIG 0
#define RUNNING 1
#define STOPPED 2
#define BEEPING 3

int message [telegrammSize];
int dateCounter=0;
int higherValue = 60;
int lowerValue = 30;
int bitValue = 1;
int hilfsFlanke=0;
int kommando = -1;
int oldToggleBit;

//TeaTimer
#define MaxTimer 65535
#define MaxPieps 5

long sekundenTakt = 32768;
unsigned int StartZeit = 0;
unsigned int vergangeneZeit = 0;
char state = 0;

char timerString [5];

void main(void)
{
  WDTCTL = WDTPW + WDTHOLD;  // Stop  Watchdog Timer

	state = KONFIG;
  
  TACTL = TASSEL_1 + TACLR;  // Beschreiben des TimerA-Controlregisters, es werden zwei Bits gesetzt:
                             //   - TimerA Source Select = 1 (Eingangstakt ist AClock) was wollen wir?
                             //   - Clear TimerA-Register    (Z?hlregister auf 0 setzen)
                             // Timer startet noch nicht
  
  TBCTL = TBSSEL_1 + TBCLR;  // Beschreiben des TimerA-Controlregisters, es werden zwei Bits gesetzt:
                             //   - TimerA Source Select = 1 (Eingangstakt ist AClock)
                             //   - Clear TimerA-Register    (Zählregister auf 0 setzen)
                             // Timer startet noch nicht

  TBCCTL0 = CCIE;            // Capture/Compare-Unit0 Control-Register beschreiben:
                             //   - Interrupt-Auslösung durch Capture/Compare-Unit0 freischalten (CCR0)
             

  
  P2IE = BIT3;        // Port 2 Interrupt Enable an Leitung 3
  P2IES = BIT3;       // Interrupt Edge Select -> fallende Flanke an Leitung 3
  
  P2DIR |= BIT4;  //Konfig für Lautsprecher
  
  lcd_init(16); //Initialisierung des Displays mit 16 Spalten
  lcd_clear(); //Display wird gelöscht
  
  goToState(KONFIG);
  lcd_gotoxy(0,1);
  lcd_puts("Time: 00000");
 
  TACTL  |= MC_2; //Timer A startet in Cont MODE
  
  __enable_interrupt();      // enable general interrupt (Interrupts global frei schalten)
  while (1) {
    //energiesparen
    __low_power_mode_3();
  }   
}

// PORT2 interrupt service routine - von der Fernbedienung
#pragma vector=PORT2_VECTOR
__interrupt void PORT2ISR (void)
{
  int timerAReg = TAR;
  TAR = 0; //Register zurücksetzen
  
  //wenn doppelte flankenzeit -> Wechsel von 0 auf 1, bzw. 1 auf 0
  if(timerAReg<higherValue+ 15 && timerAReg>higherValue-15) {
      	bitValue^=1;
	message[dateCounter++] = bitValue;
	hilfsFlanke=0; // war eine informationstragende Flanke
  } else if (timerAReg<lowerValue+15 && timerAReg>lowerValue-15) { // kurze Flankenzeit ->  Datum wird eingetragen
	if(hilfsFlanke==0) {
		hilfsFlanke=1; // war HilfsFlanke
	} else {
	      	message[dateCounter++] = bitValue;
		hilfsFlanke=0; // war keine HilfsFlanke
	}
  } else {
    // Anfang des nächsten Telegramms nach langer Wartezeit, weil vorheriges unvollständig
	dateCounter=0;
	bitValue=1;
	message[dateCounter++]  = bitValue;
  }
  P2IES = P2IES ^ BIT3 ; //toggle EdgeSelect


  if(dateCounter == telegrammSize) { //Telegramm vollständig empfangen
   	bitValue=1; //Startwert des nächsten Telegramms
   	dateCounter = 0;
 	P2IES=BIT3; //soll wieder bei fallender Flanke auslösen
	//wenn neue Nachricht (toggle bit nicht gesetzt) -> stelle Nachricht dar
        int newToggleBit = message[2];
	if(newToggleBit != oldToggleBit) { //prüfe toggleBit, 1 = neue Nachricht
          oldToggleBit = newToggleBit;
          kommando = 0;
          
          //setzt Kommando zusammen und stelle es dar
          
          lcd_gotoxy(12,0);
          lcd_puts("K: ");
          for (char i = 8; i<telegrammSize;i++) {
            kommando = kommando << 1;
            kommando +=message[i];
          }
          writeToLCD(kommando,14,0,2);
           
	
		  switch(state) {
		  case KONFIG:
			  if(kommando <10) {
				//append die Zahl an den bisherigen Wert in StartZeit bis zu Max
				if((MaxTimer-kommando)/10 < StartZeit ) {
					StartZeit=MaxTimer;
				} else {
					StartZeit*=10;
					StartZeit+=kommando;
				}
				writeToLCD(StartZeit,6,1,5);
			  } else if (kommando == Display) {
				StartZeit=0;
                                writeToLCD(StartZeit,6,1,5);
			  } else if (kommando == OK) {
				goToState(RUNNING);
				//timerB starten
				
			  }
				break;
		  case RUNNING:
			if(kommando == Standby) {
				goToState(STOPPED);
			
			}
			break;
		  case STOPPED:
			if(kommando == OK) {
				goToState(RUNNING);
			} else if (kommando == Display) {
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
  }
  P2IFG=0;         // Interupt bearbeitet, Interrupt-Flag-Register l?schen
}

char blinkToggle = 0;
char anzahlPieps = 0;
// Timer B0 interrupt service routine
// wird jedesmal aufgerufen, wenn Interrupt von TimerB kommt
#pragma vector=TIMERB0_VECTOR
__interrupt void Timer_B0 (void)
{
  //TimerB wird abhängig von State definiert
  switch(state) {
	  case KONFIG:
		//nix
	  break;
	  case RUNNING:
	  //muss im Sekundentakt runterzählen
                vergangeneZeit++;
                if(StartZeit-vergangeneZeit==0) {
	            goToState(BEEPING);
		}
		writeToLCD(StartZeit-vergangeneZeit,6,1,5);
		
		break;
	  case STOPPED:
	  //timer steht - Restanzeige muss blinken
		if(blinkToggle == 1) {
			writeToLCD(StartZeit-vergangeneZeit,6,1,5);
		} else {
			lcd_gotoxy(6,1);
			lcd_puts("-----");
		}
		blinkToggle ^= 1;	  
	  break;
	  case BEEPING:
		piepen(2);
		anzahlPieps++;
		if(anzahlPieps==MaxPieps) {
			goToState(KONFIG);
		}
	  break;
   }
  
}

void Warteschleife(long dauer) {
  for(long i = 0; i <dauer; i++) {}
}

void writeToLCD(int wert,char column,char row,char anzahlDigits) {
  uint2string(text,wert);
  lcd_gotoxy(column,row);
  lcd_puts(text+(5-anzahlDigits));
}

void piepen (char anzahlPieps) {
      int frequenz = 200; // hoeherer Wert entspricht tieferer Ton
      int dauerTon = 100; //entspricht NICHT sekunden
      for(char pieps = 0; pieps<anzahlPieps; pieps++) {  //Abwechselnd Frequenzgeben und nichts tun    
      for(long i=0;i<dauerTon;i++) {
        Warteschleife(frequenz);
        P2OUT ^=BIT4; //toggeln in bestimmter Frequenz -> Rechtecksignal am Lautsprecher
      }
      Warteschleife(dauerTon*frequenz); // wartet entsprechend der Dauer des Tons
    }
}

void goToState(int newState) {
  state=newState;
  switch(newState) {
  case KONFIG:
    TBCTL = MC_0;
    vergangeneZeit=0;
    StartZeit=0;
    anzahlPieps=0;
    writeToLCD(StartZeit,6,1,5);
    lcd_gotoxy(0,0);
    lcd_puts("Konfig ");
    //timerBstoppen;
    break;
  case RUNNING:
    
   
    if(StartZeit==0) goToState(BEEPING);
    else {
      TBCCR0 = sekundenTakt;
      TBCTL = TBSSEL_1 + TBCLR;
      TBCTL |= MC_1; //upmode
      lcd_gotoxy(0,0);
      lcd_puts("Running");
      
      writeToLCD(StartZeit-vergangeneZeit,6,1,5);
    }    
    break;
  case STOPPED:
    TBCCR0 = sekundenTakt/2;
    TBCTL |= TBCLR;
    
    lcd_gotoxy(0,0);
    lcd_puts("Stopped");
    break;
  case BEEPING:
    TBCCR0 = sekundenTakt;
    TBCTL = TBSSEL_1 + TBCLR;
    TBCTL |= MC_1;
    lcd_gotoxy(0,0);
    lcd_puts("Beeping");
    break;
  }
}

