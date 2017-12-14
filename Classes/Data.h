//
//  Data.h
//  USt
//
//  Created by Matthias Blanquett on 22.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Data : NSObject
{
	NSInteger bmgTyp;
	BOOL firstTimeStart;
	BOOL entgeltlich;
	BOOL show3dSatz2;
	BOOL itIs3_1a; // Es handelt sich um einen Fall des § 3 (1a) UStG
	BOOL besteuerung;
	NSInteger umsatzArt;
	NSInteger steuersatz;
	BOOL showLaw;
	
	CGFloat entgelt;
	NSInteger leistungsArt;
	BOOL kfzUmsatz; // Variable gilt nur für Leistungen, bei igE kein VorSt-Abzug bei KFZ, deswegen eigene Variable
	BOOL fallDes13b;

	// Hilfsstrings für die Lösung des Falles
	NSString* steuerbarNach1;
	NSString* steuerbarNach2;
	NSString* bmgNach;
}

@property (nonatomic) NSInteger bmgTyp; // No Memory management policies (only for object properties)
@property (nonatomic) BOOL firstTimeStart;
@property (nonatomic) BOOL entgeltlich;
@property (nonatomic) BOOL show3dSatz2;
@property (nonatomic) BOOL itIs3_1a;
@property (nonatomic) BOOL besteuerung;
@property (nonatomic) NSInteger umsatzArt;
@property (nonatomic) NSInteger steuersatz;
@property (nonatomic) BOOL showLaw;
@property (nonatomic) CGFloat entgelt;
@property (nonatomic) NSInteger leistungsArt;
@property (nonatomic) BOOL kfzUmsatz;
@property (nonatomic) BOOL fallDes13b;
@property (nonatomic, copy) NSString* steuerbarNach1;
@property (nonatomic, copy) NSString* steuerbarNach2;
@property (nonatomic, copy) NSString* bmgNach;



- (id) init;
+ (Data *)instance;

-(void) clearData;

@end
