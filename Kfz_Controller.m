//
//  Kfz_UController.m
//
//  Created by Matthias Blanquett on 06.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Kfz_Controller.h"


@interface Kfz_Controller()
// private Methoden kommen hier rein

@end

@implementation Kfz_Controller

//@synthesize bmg;
//@synthesize bruttolistenpreis;
//@synthesize doppeltehhf;
//@synthesize entfernungskm;
//@synthesize monate;
//@synthesize zwischenwert;
@synthesize fahrtenbuch;
@synthesize viewTyp;

//NIEMALS property/synthesize aufrufen, sonst wird der im IB erstellte VIEW komplett überschrieben und leer erzeugt
//@synthesize view;

#pragma mark -
#pragma mark IBAction-methods

- (IBAction)changedMethod:(id)sender
{
	if ([sender selectedSegmentIndex] == 1)
	{
		fahrtenbuch = TRUE;

		if (viewTyp == kUnternehmer)
			[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:0] setText:@"KFZ-Kosten mit Vorsteuer-Abzug:"];
		else
			[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:0] setText:@"ALLE KFZ-Kosten:"];
		bruttolistenpreis.text = NSLocalizedString(@"10000", nil); // ist objectAtIndex:1
		bruttolistenpreis.placeholder = NSLocalizedString(@"10000", nil);
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:4] setHidden:TRUE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:5] setHidden:TRUE];
		monate.text = NSLocalizedString(@"80", nil); // ist objectAtIndex:6
		monate.placeholder = NSLocalizedString(@"80", nil);
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:7] setText:@"BMG:"];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:8] setHidden:TRUE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:9] setHidden:TRUE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:10] setText:@"Privater Nutzungs-Anteil:"];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:11] setHidden:TRUE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:12] setHidden:TRUE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:13] setHidden:TRUE];
		zwischenwert.text = NSLocalizedString(@"8000", nil); // ist objectAtIndex:15
		entfernungskm.hidden = TRUE; // ist objectAtIndex:16
		doppeltehhf.hidden = TRUE; // ist objectAtIndex:17
		bmg.hidden = TRUE; // ist objectAtIndex:18
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:19] setHidden:TRUE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:20] setHidden:TRUE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:21] setText:@"Heimfahrten = Privatfahrten"];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:22] setHidden:FALSE];
	}
	else
	{
		fahrtenbuch = FALSE;
		
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:0] setText:@"Bruttolistenpreis:"];
		bruttolistenpreis.text = NSLocalizedString(@"50000", nil); // ist objectAtIndex:1
		bruttolistenpreis.placeholder = NSLocalizedString(@"50000", nil);
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:4] setHidden:FALSE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:5] setHidden:FALSE];
		monate.text = NSLocalizedString(@"12", nil); // ist objectAtIndex:6
		monate.placeholder = NSLocalizedString(@"12", nil);
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:7] setText:@"Zwischenwert"];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:8] setHidden:FALSE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:9] setHidden:FALSE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:10] setText:@"Anzahl Monate:"];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:11] setHidden:FALSE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:12] setHidden:FALSE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:13] setHidden:FALSE];
		zwischenwert.text = NSLocalizedString(@"6000", nil); // ist objectAtIndex:15
		entfernungskm.hidden = FALSE; // ist objectAtIndex:16
		doppeltehhf.hidden = FALSE; // ist objectAtIndex:17
		bmg.hidden = FALSE; // ist objectAtIndex:18
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:19] setHidden:FALSE];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:20] setHidden:FALSE];
		if (viewTyp == kUnternehmer)
			[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:21] setText:@"Voraussetzung: Betriebliche Nutzung > 50 %"];
		else
			[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:21] setText:@""];
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:22] setHidden:TRUE];
	}
	[self changedData];
}

- (void)changedData
{
	NSInteger result = 0;
	//[self alert:[[bruttolistenpreis text] integerValue]];
	//[self alert:(floorf([[bruttolistenpreis text] integerValue]/100.0)*100)];

	if (fahrtenbuch)
	{
		if ([[bruttolistenpreis text] integerValue] == 0)
			[bruttolistenpreis setText:NSLocalizedString(@"10000", nil)];
		if ([[monate text] integerValue] == 0)
			[monate setText:NSLocalizedString(@"80", nil)];

		result = lroundf([[bruttolistenpreis text] integerValue] * [[monate text] integerValue] * 0.01);

		zwischenwert.text = [NSString stringWithFormat:@"%ld", (long)result];

		[[Data instance] setEntgelt:[[numberFormatter numberFromString:zwischenwert.text] floatValue]];
	}
	else
	{
		if ([[bruttolistenpreis text] integerValue] == 0)
			[bruttolistenpreis setText:NSLocalizedString(@"50000", nil)];
		if ([[monate text] integerValue] == 0)
			[monate setText:NSLocalizedString(@"12", nil)];


		[bruttolistenpreis setText:[NSString stringWithFormat:@"%ld", lroundf(floorf([[bruttolistenpreis text] integerValue]/100.0)*100)]];
		result = lroundf([[bruttolistenpreis text] integerValue] * [[monate text] integerValue] * 0.01);
		[zwischenwert setText:[NSString stringWithFormat:@"%ld",(long)result]];

		// Weil 1*0.01*0.03 = die geforderten 0.0003 / Analog bei DHH
		if (viewTyp == kUnternehmer)
			result = lroundf((result + entfernungskm.text.integerValue*result*0.03 + doppeltehhf.text.integerValue*result*0.002) * 0.8);
		else
			result = lroundf((result + entfernungskm.text.integerValue*result*0.03 + doppeltehhf.text.integerValue*result*0.002) / 1.19);

		bmg.text = [NSString stringWithFormat:@"%ld", (long)result];

		[[Data instance] setEntgelt:[[numberFormatter numberFromString:bmg.text] floatValue]];
	}
}

#pragma mark -
#pragma mark Load/Unload View

- (void)viewDidLoad
{
	fahrtenbuch = FALSE;

	[super viewDidLoad];	

	// Nötig damit das Keyboard den Fokus verlassen kann, wird jedoch per Linien-zug im IB gelöst
	// self.monate.delegate = self;

	// note: for UITextView, if you don't like autocompletion while typing use:
    // myTextView.autocorrectionType = UITextAutocorrectionTypeNo;
	if (viewTyp == kUnternehmer)
	{
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:21] setText:@"Voraussetzung: Betriebliche Nutzung > 50 %"];
		self.title = NSLocalizedString(@"U. nutzt KFZ", @"");
	}
	else
	{
		[[[[self.view.subviews objectAtIndex:1] subviews] objectAtIndex:11] setText:@"Davon 1/1,19 = BMG ="];
		bmg.text = NSLocalizedString(@"5042", nil);
		self.title = NSLocalizedString(@"AN nutzt KFZ", @"");
	}

    // this will cause automatic vertical resize when the table is resized
    // self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;

	numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setDecimalSeparator:@","];
	[numberFormatter setGroupingSeparator:@"."];

	[[Data instance] setEntgelt:[[numberFormatter numberFromString:bmg.text] floatValue]];
}


// called after the view controller's view is released and set to nil.
// For example, a memory warning which causes the view to be purged. Not invoked as a result of -dealloc.
// So release any properties that are loaded in viewDidLoad or can be recreated lazily.
- (void)viewDidUnload
{
    [super viewDidUnload];

    self.view = nil;
}

#pragma mark -
#pragma mark Load/Unload Observer

- (void)viewWillAppear:(BOOL)animated 
{
	[super viewWillAppear:animated];

	// Observe keyboard hide and show notifications to resize the view appropriately.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

	// Make the keyboard appear when the application launches.
    //[bruttolistenpreis becomeFirstResponder];

	[[Data instance] setKfzUmsatz:TRUE];

	[self addNextButton:@"Steuersatz"];
}

- (void)viewDidDisappear:(BOOL)animated 
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -
#pragma mark Responding to keyboard events

- (void)keyboardWillShow:(NSNotification *)aNotification 
{
	// provide my own Save button to dismiss the keyboard
    UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																			  target:self action:@selector(doneAction:)];
    self.navigationItem.rightBarButtonItem = saveItem;


	// PROBLEM: Method doesn't work so far, don't know. Will make Keyboard shiny instead
	return;
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
	// PROBLEM: Method doesn't work so far, don't know. Will make Keyboard shiny instead
	return;
}


- (void)doneAction:(id)sender
{
    // finish typing text/dismiss the keyboard by removing it as the first responder
	// [[self.view firstResponder] resignFirstResponder]; // is private API
	// Deswegen für jedes UITextField einzeln aufrufen
	[bruttolistenpreis resignFirstResponder];
	[monate resignFirstResponder];
	[entfernungskm resignFirstResponder];
	[doppeltehhf resignFirstResponder];

    self.navigationItem.rightBarButtonItem = nil;   // this will remove the "save" button
	[self addNextButton:@"Steuersatz"]; // Fügt wieder den normalen Button hinzu

	[self changedData]; // Berechnung der BMG ausführen
}


// Dismiss the keyboard when the view outside the text field is touched.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doneAction:nil];
    // Revert the text field to the previous value.
    //monate.text = self.string; 
    [super touchesBegan:touches withEvent:event];
}

#pragma mark -
#pragma mark implementierte Delegate-Methoden

// sorgt dafür, dass man nur eine bestimmte Anzahl von Stellen eingeben kann
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
	if (textField.tag == 2)
		return (newLength > 2) ? NO : YES;
	else  if (textField.tag == 4)
			return (newLength > 4) ? NO : YES;
		else
			return (newLength > 7) ? NO : YES;
}

// wird wohl niemals aufgerufen werden, da ka kein Returnfeld
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
	[self doneAction:nil];
    return YES;
}

#pragma mark -
#pragma mark dealloc

@end
