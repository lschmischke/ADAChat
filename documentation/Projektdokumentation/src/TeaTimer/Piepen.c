void piepen(int anzahlPieps) {
	int frequenz = 200; // hoeherer Wert entspricht tieferer Ton
	int dauerTon = 100; // keine genaue Zeiteinheit
	for (int i=0; i<anzahlPieps; i++) {
		// Ton-Phase
		for (int j=0; i<dauerTon; j++) {
			Warteschleife(frequenz);
			P2OUT ^= BIT4;
		}
		// Pause-Phase
		Warteschleife(dauerTon*frequenz); // Wartezeit = Laenge Ton-Phase
	}
}

