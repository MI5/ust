//
//  Stufe15a.h
//  USt
//
//  Created by Matthias Blanquett on 10.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Stufe17 : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *neueBmg;
    IBOutlet UITextField *alteBmg;
    IBOutlet UITextField *steuersatz;
    IBOutlet UITextField *alteVorsteuer;
    IBOutlet UITextField *differenzBmg;
    IBOutlet UITextField *vorsteuerAenderung;

	NSNumberFormatter *numberFormatter;
}

@end
