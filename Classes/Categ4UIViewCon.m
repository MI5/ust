#import "StufeFrei.h"
#import "StufeBMG.h"
#import "StufeSteuersatz.h"
#import "IgeOrt.h"
#import "EinfuhrFrei.h"
#import "IgeFrei.h"
#import "EinfuhrSchuldner.h"
#import "IgeSchuldner.h"
#import "StufeSchuldner.h"
#import "StufeRechnung1.h"
#import "StufeRechnung2.h"
#import "EinfuhrRechnung.h"
#import "IgeRechnung.h"
#import "StufeVorSt.h"
#import "EinfuhrVorSt.h"
#import "IgeVorSt.h"
#import "EinfuhrResult.h"
#import "IgeResult.h"
#import "Result.h"
#import "VorStBerichtigung.h"

@implementation UIViewController (myCategory)

NSString * typeOfNextButton = @"";

- (void) addNextButton:(NSString *)title {
	UIBarButtonItem* nextViewItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(loadNextView:)];
    self.navigationItem.rightBarButtonItem = nextViewItem;

	typeOfNextButton = title;
}

- (void) killNextButton {
	self.navigationItem.rightBarButtonItem = nil;
}

- (void) loadNextView:(id)sender {
	//[self alertWithString:typeOfNextButton];
	UITableViewController *nextStep = nil;

	if ([typeOfNextButton isEqualToString:@"Steuerbefreiung"])
		nextStep = [[StufeFrei alloc] initWithNibName:@"StufeFrei" bundle:nil];
	else if ([typeOfNextButton isEqualToString:@"BMG"])
		nextStep = [[StufeBMG alloc] initWithNibName:@"StufeBMG" bundle:nil];
	else if ([typeOfNextButton isEqualToString:@"Steuersatz"])
		nextStep = [[StufeSteuersatz alloc] initWithNibName:@"StufeSteuersatz" bundle:nil];
	//else if ([typeOfNextButton isEqualToString:@"Entstehung"])
	//{
	//	nextStep = [[StufeEntstehung alloc] initWithNibName:@"StufeEntstehung" bundle:nil];
	//	[[Data instance] setSteuersatz:k19Prozent];
	//}
	else if ([typeOfNextButton isEqualToString:@"Ort"]) // Gilt nur bei Ort des i. g. E.
		nextStep = [[IgeOrt alloc] initWithNibName:@"IgeOrt" bundle:nil];
	else if ([typeOfNextButton isEqualToString:@"StFrei"])
		nextStep = [[EinfuhrFrei alloc] initWithNibName:@"EinfuhrFrei" bundle:nil];
	else if ([typeOfNextButton isEqualToString:@"Steuerfreie i.g.E."])
		nextStep = [[IgeFrei alloc] initWithNibName:@"IgeFrei" bundle:nil];
	else if ([typeOfNextButton isEqualToString:@"Steuerschuld"]) {
		if ([[Data instance] umsatzArt] == kEinfuhr)
			nextStep = [[EinfuhrSchuldner alloc] initWithNibName:@"EinfuhrSchuldner" bundle:nil];
		else if ([[Data instance] umsatzArt] == kIge)
			nextStep = [[IgeSchuldner alloc] initWithNibName:@"IgeSchuldner" bundle:nil];
		else
			nextStep = [[StufeSchuldner alloc] initWithNibName:@"StufeSchuldner" bundle:nil];
	} else if ([typeOfNextButton isEqualToString:@"Rechnung"]) {
		if ([[Data instance] umsatzArt] == kEinfuhr)
			nextStep = [[EinfuhrRechnung alloc] initWithNibName:@"EinfuhrRechnung" bundle:nil];
		else if ([[Data instance] umsatzArt] == kIge)
			nextStep = [[IgeRechnung alloc] initWithNibName:@"IgeRechnung" bundle:nil];
		else {
			if ([[Data instance] steuersatz] == k19Prozent) {
				if ([[Data instance] entgelt] * 1.19 > 250.0)
					nextStep = [[StufeRechnung2 alloc] initWithNibName:@"StufeRechnung2" bundle:nil];
				else
					nextStep = [[StufeRechnung1 alloc] initWithNibName:@"StufeRechnung1" bundle:nil];
			} else {
				if ([[Data instance] entgelt] * 1.07 > 250.0)
					nextStep = [[StufeRechnung2 alloc] initWithNibName:@"StufeRechnung2" bundle:nil];
				else
					nextStep = [[StufeRechnung1 alloc] initWithNibName:@"StufeRechnung1" bundle:nil];
			}
		}
	} else if ([typeOfNextButton isEqualToString:@"VorSt"]) {
		if ([[Data instance] umsatzArt] == kIge)
			nextStep = [[IgeVorSt alloc] initWithNibName:@"IgeVorSt" bundle:nil];
		else
			nextStep = [[StufeVorSt alloc] initWithNibName:@"StufeVorSt" bundle:nil];
	} else if ([typeOfNextButton isEqualToString:@"Vorsteuer"]) {
		nextStep = [[EinfuhrVorSt alloc] initWithNibName:@"EinfuhrVorSt" bundle:nil];
    } else if ([typeOfNextButton isEqualToString:@"Ergebnis"]) {
		if ([[Data instance] umsatzArt] == kEinfuhr)
			nextStep = (UITableViewController *)[[EinfuhrResult alloc] initWithNibName:@"EinfuhrResult" bundle:nil];
		else if ([[Data instance] umsatzArt] == kIge)
			nextStep = (UITableViewController *)[[IgeResult alloc] initWithNibName:@"IgeResult" bundle:nil];
		else
			nextStep = (UITableViewController *)[[Result alloc] initWithNibName:@"Result" bundle:nil];

        //nextStep.bottomLayoutGuide = nil;
        // TODO: nextStep.edgesForExtendedLayout = UIRectEdgeBottom; // So view is not hidden beneath bar at bottom
	} else if ([typeOfNextButton isEqualToString:@"VorSt-B."]) {
		nextStep = [[VorStBerichtigung alloc] initWithNibName:@"VorStBerichtigung" bundle:nil];
    }

	[self.navigationController pushViewController:nextStep animated:YES];
}



- (UITableViewCellStyle) getCellStyle {
    if ([[Data instance] showLaw]) {
		return UITableViewCellStyleSubtitle;
    }

	return UITableViewCellStyleDefault;
}



- (void)alertWithString:(NSString *)text {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Hinweis", nil) message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];   
}
- (void)alertSchema:(NSString *)text {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Prüfschema beendet", nil) message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];   
}
- (void)alert:(NSInteger)number {
	[self alertWithString:[NSString stringWithFormat:@"%ld", (long)number]];
}
- (void)alert {
	[self alertWithString:@"Hier sind wir"];
}


// Fügt eine weitere 0 an, falls sonst eine Nachkommastelle fehlen würde (z. B. 7,1 €)
- (NSString*)checkIfToAddEndingZero:(NSString*)s {
	// Einfacher Vergleich und kein isEqualToString, da ein unichar zurückgeliefert wird, was kein Objekt ist
    if ([s characterAtIndex:[s length]-2] == ',') {
		return @"0";
    } else {
		return @"";
    }
}

//Funktioniert nicht, und wenn dann eher für UIView als für UIViewcontroller
/*
- (UIView *)findFirstResponder {
    if (self.isFirstResponder && [self respondsToSelector:@selector(placeholderRectForBounds)]) {
        return self;     
    }
	
    for (UIView *subView in self.subviews)
	{
        UIView *firstResponder = [subView findFirstResponder];
		
        if (firstResponder != nil && [self respondsToSelector:@selector(placeholderRectForBounds)]) {
            return firstResponder;
        }
    }

    return nil;
} */
@end
