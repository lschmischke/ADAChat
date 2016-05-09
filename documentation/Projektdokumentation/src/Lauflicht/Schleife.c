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
