//
//  Stufe15a.m
//  USt
//
//  Created by Matthias Blanquett on 10.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Stufe17.h"


@implementation Stufe17

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
	[super viewDidLoad];	

	// Nötig damit das Keyboard den Fokus verlassen kann, wird jedoch per Linien-zug im IB gelöst
	// self.monate.delegate = self;

	// note: for UITextView, if you don't like autocompletion while typing use:
    // myTextView.autocorrectionType = UITextAutocorrectionTypeNo;

	// Nur hiermit und im Zusammenhang mit dem gesetzten Protokoll in der h-datei funktioniert die Methode shouldChangeCharactersInRange
	neueBmg.delegate = self;

	self.title = NSLocalizedString(@"Änderung BMG", @"");

    // this will cause automatic vertical resize when the table is resized
    // self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;

	numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	[numberFormatter setDecimalSeparator:@","];
	[numberFormatter setGroupingSeparator:@"."];

	[alteBmg setText:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt]]]];
	if ([Data instance].steuersatz == k19Prozent) {
		[steuersatz setText:NSLocalizedString(@"19", nil)];
		[alteVorsteuer setText:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt] * 0.19]]];
	} else {
		[steuersatz setText:@"7"];
		[alteVorsteuer setText:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt] * 0.07]]];
	}
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	// Observe keyboard hide and show notifications to resize the view appropriately.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark Keyboard Methods

- (void)keyboardWillShow:(NSNotification *)aNotification {
	// provide my own Save button to dismiss the keyboard
    UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																			  target:self action:@selector(doneTyping:)];
    self.navigationItem.rightBarButtonItem = saveItem;
}


- (void)doneTyping:(id)sender {
    // finish typing text/dismiss the keyboard by removing it as the first responder
	[neueBmg resignFirstResponder];
	
    self.navigationItem.rightBarButtonItem = nil;   // this will remove the "save" button

	// Hier ist unsere Rechnung
	if (neueBmg.text.length == 0) {
		[differenzBmg setText:@""];
		[vorsteuerAenderung setText:@""];
	} else {
		[differenzBmg setText:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[numberFormatter numberFromString:neueBmg.text] floatValue] - [[Data instance] entgelt]]]];
		[vorsteuerAenderung setText:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt] * 0.07]]];

		if ([Data instance].steuersatz == k19Prozent) {
			[vorsteuerAenderung setText:[numberFormatter stringFromNumber:[NSNumber numberWithFloat: [[numberFormatter numberFromString:differenzBmg.text] floatValue] * 0.19]]];
		} else {
			[vorsteuerAenderung setText:[numberFormatter stringFromNumber:[NSNumber numberWithFloat: [[numberFormatter numberFromString:differenzBmg.text] floatValue] * 0.07]]];
		}
	}
}

#pragma mark -
#pragma mark implementierte Delegate-Methoden

- (BOOL) textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)textEntered {
	// sorgt dafür, dass man nur eine bestimmte Anzahl von Stellen eingeben kann
	NSUInteger newLength = [textField.text length] + [textEntered length] - range.length;
	if (newLength > 8 && [textField.text rangeOfString:@","].length > 0) // Bei nem Komma mit drin lassen wir noch eine Stellen mehr zu
		return NO;

    if (newLength > 7 && !([textField.text rangeOfString:@","].length > 0)) {
        return NO;
    }
	// Es gibt leider unsinnige Runden, wenn ich mehr Stellen zulassen würde
	
	
	// Ich arbeite hier bewusst mit Kommas, da deutsches Programm, aber man könnte wohl auch mit
	// [numberFormatter decimalSeparator] arbeiten
	
	NSCharacterSet *NUMBERS	= [NSCharacterSet characterSetWithCharactersInString:@"0123456789,"];
	
	// Zuerst doppelte Kommas raushauen
    if ([textField.text rangeOfString:@","].length > 0 && [textEntered isEqualToString:@","]) {
        return NO;
    }

	// Mehr als 2 NKS verhindern
	// Kein Backspace & es gibt bereits ein Komma & das Komma ist an 3.letzter Stelle
    if (textEntered.length > 0 && [textField.text rangeOfString:@","].length > 0 && [textField.text rangeOfString:@","].location + 3 == [textField.text length]) {
        return NO;
    }

	// Dann nur Zahlen und Kommas zulassen (Was a loop before, that did not loop...)
    if (textEntered.length > 0) {
		unichar d = [textEntered characterAtIndex:0];
        if (![NUMBERS characterIsMember:d]) {
            return NO;
        } else {
            return YES;
        }
    }

	// Kann jetzt eigentlich nur noch ein Backspace sein
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[self doneTyping:nil];
    return YES;
}

// Dismiss the keyboard when the view outside the text field is touched.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self doneTyping:nil];
    [super touchesBegan:touches withEvent:event];
}

- (void)viewDidDisappear:(BOOL)animated  {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}



@end
