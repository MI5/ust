//
//  Kfz_UController.h
//
//  Created by Matthias Blanquett on 06.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Kfz_Controller : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *bmg;
    IBOutlet UITextField *bruttolistenpreis;
    IBOutlet UITextField *doppeltehhf;
    IBOutlet UITextField *entfernungskm;
    IBOutlet UITextField *monate;
    IBOutlet UITextField *zwischenwert;
	IBOutlet UIView *view;

	NSInteger viewTyp; // Speichert ob Arbeitnehmer oder Unternehmer
	BOOL fahrtenbuch;

	NSNumberFormatter *numberFormatter;
}


//@property (nonatomic, retain) UITextField *bmg;
//@property (nonatomic, retain) UITextField *bruttolistenpreis;
//@property (nonatomic, retain) UITextField *doppeltehhf;
//@property (nonatomic, retain) UITextField *entfernungskm;
//@property (nonatomic, retain) UITextField *monate;
//@property (nonatomic, retain) UITextField *zwischenwert;
@property (nonatomic, assign) BOOL fahrtenbuch;
@property (nonatomic, assign) NSInteger viewTyp;

//NIEMALS property/synthesize aufrufen, sonst wird der im IB erstellte VIEW komplett überschrieben und leer erzeugt
//@property (nonatomic, retain) UIView *view;

- (IBAction)changedMethod:(id)sender;

- (void)changedData;
@end