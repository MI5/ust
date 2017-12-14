//
//  Data.m
//  USt
//
//  Created by Matthias Blanquett on 22.06.10.
//  Copyright 2010 City Software. All rights reserved.
//
//  Schöner Zugriff auf eine Variable eines Views, aber hier nicht angewendet, sondern Lösung als Singleton
//	[[[[self navigationController] viewControllers] objectAtIndex:0] setBmgTyp:2];
//	[[[[self navigationController] viewControllers] objectAtIndex:0] bmgTyp];

#import "Data.h"


static Data *myData = NULL;

@interface Data()
// Private Variablen werden hier deklariert

@end

@implementation Data

extern Data *myData; // Nicht unbedingt nötig, aber zeigt dem Code-Leser, dass auf eine externe Variable zugegriffen wird

@synthesize bmgTyp;
@synthesize firstTimeStart;
@synthesize entgeltlich;
@synthesize show3dSatz2;
@synthesize itIs3_1a;
@synthesize besteuerung;
@synthesize umsatzArt;
@synthesize steuersatz;
@synthesize showLaw;
@synthesize entgelt;
@synthesize leistungsArt;
@synthesize kfzUmsatz;
@synthesize steuerbarNach1;
@synthesize steuerbarNach2;
@synthesize bmgNach;
@synthesize fallDes13b;

- (id)init {
	self = [super init]; // Ruft stets die Methode der Superklasse auf

	// Alle Variablen initialisieren
	bmgTyp = undefinedBMG;
	firstTimeStart = TRUE;
	entgeltlich = TRUE;
	show3dSatz2 = TRUE;
	itIs3_1a = FALSE;
	besteuerung = kSollBesteuerung;
	umsatzArt = kLeistung;
	steuersatz = k19Prozent;
	showLaw = TRUE; // Wird beim Start eh abgefragt und überschrieben
	entgelt = 100.00;
	leistungsArt = kUndefined;
	kfzUmsatz = FALSE;
	fallDes13b = FALSE;
	steuerbarNach1 = @"?";
	steuerbarNach2 = @"?";
	bmgNach = @"?";

	return self;
}

+ (Data *)instance {
	@synchronized(self)
    {
		if (myData == NULL)
			myData = [[self alloc] init];	// Kein Autorelease: Sonst stürzt App ab.
											// Ich verzichte für das Singleton auf einen Release
											// Das Singleton soll für die gesamte Lebenszeit der App verfügbar sein
    }

	return(myData);
}

- (void) clearData {
	// Zugriff von außen, kann natürlich auch von innen erfolgen
	[[Data instance] setBmgTyp:undefinedBMG];
	[[Data instance] setLeistungsArt:kUndefined];
	[[Data instance] setKfzUmsatz:FALSE];
	[[Data instance] setSteuerbarNach1:@"?"];
	[[Data instance] setSteuerbarNach2:@"?"];
	[[Data instance] setBmgNach:@"?"];
	[[Data instance] setItIs3_1a:FALSE];
}


@end
