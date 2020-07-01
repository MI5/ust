#import "Result.h"

@implementation Result

@synthesize textView;

- (NSString*)composeResult
{
	NSMutableString* s = [NSMutableString stringWithCapacity:1024];

	[s setString:@""];

	if ([[[Data instance] steuerbarNach2] isEqualToString:@"?"])
	{
		[s appendString:@"Beginnen sie mit dem Schritt \"Steuerbarkeit\" und dann \"Leistung\", um die Komplettlösung zu einem Fall zu erhalten."];
		return s;
	}

	if ([[Data instance] bmgTyp] == entgeltlichBMG)
		[s appendString:@"Es liegt ein Umsatz im Rahmen des Unternehmens gegen Entgelt vor. "];
	if ([[Data instance] bmgTyp] == unentgeltlichBMG)
		[s appendString:@"Es liegt ein Umsatz im Rahmen des Unternehmens ohne Entgelt vor. "];


	if ([[Data instance] leistungsArt] == kLieferung)
	{
		[s appendString:@"Es handelt sich um eine Lieferung gemäß § 1 Abs. 1 Nr. 1 UStG i. V. m. "];
		[s appendString:[[Data instance] steuerbarNach1]];
		[s appendString:@". "];
	}
	if ([[Data instance] leistungsArt] == kSonstLeistung)
	{
		[s appendString:@"Es handelt sich um eine sonstige Leistung gemäß § 1 Abs. 1 Nr. 1 UStG i. V. m. "];
		[s appendString:[[Data instance] steuerbarNach1]];
		[s appendString:@". "];
	}


	[s appendString:@"Der Umsatz liegt nach "];
	[s appendString:[[Data instance] steuerbarNach2]];
	[s appendString:@" im Inland und ist somit steuerbar. Der Umsatz ist auch steuerpflichtig, da eine Steuerbefreiung "];
	[s appendString:@"nach § 4 UStG nicht greift.\n\nDie Bemessungsgrundlage richtet sich nach "];
	[s appendString:[[Data instance] bmgNach]];
	[s appendString:@" und beträgt "];
	[s appendString:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt]]]];
	[s appendString:[self checkIfToAddEndingZero:s]];
	[s appendString:@" €. "];

	[s appendString:@"Gemäß "];

	NSNumber* bruttowert;
	if ([[Data instance] steuersatz] == k19Prozent)
	{
		[s appendString:@"§ 12 Abs. 1 UStG ist der allgemeine Steuersatz von 16"];

		bruttowert = [NSNumber numberWithFloat:[[Data instance] entgelt] * 1.16];
	}
	else
	{
		[s appendString:@"§ 12 Abs. 2 UStG ist der ermäßigte Steuersatz von 5"];

		bruttowert = [NSNumber numberWithFloat:[[Data instance] entgelt] * 1.05];
	}
	[s appendString:@" Prozent anzuwenden. Der Bruttobetrag lautet somit über "];
	[s appendString:[numberFormatter stringFromNumber:bruttowert]];
	[s appendString:[self checkIfToAddEndingZero:s]];
	[s appendString:@" € und es ist Umsatzsteuer in Höhe von "];

	if ([[Data instance] steuersatz] == k19Prozent)
	{
		bruttowert = [NSNumber numberWithFloat:[bruttowert floatValue] - ([bruttowert floatValue] / 1.16)];
	}
	else
	{
		bruttowert = [NSNumber numberWithFloat:[bruttowert floatValue] - ([bruttowert floatValue] / 1.05)];
	}
	[s appendString:[numberFormatter stringFromNumber:bruttowert]];
	[s appendString:[self checkIfToAddEndingZero:s]];
	[s appendString:@" € fällig. "];

	if ([[Data instance] bmgTyp] == unentgeltlichBMG)
	{
		[s appendString:@"Der Unternehmer hat einen Betrag in Höhe von "];
		[s appendString:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt]]]];
		[s appendString:[self checkIfToAddEndingZero:s]];
		[s appendString:@" € in seiner USt-Erklärung als unentgeltliche Wertabgabe zu deklarieren. Er hat für mit diesem unentgeltlichen "];
		[s appendString:@"Umsatz zusammenhängende Ausgaben den Vorsteuerabzug, sofern keine Ausnahme vorliegt."];
	}
	else
	{
		if ([bruttowert floatValue] > 250.0)
			[s appendString:@"Es ist demnach eine normale Rechnung erforderlich. "];
		else
			[s appendString:@"Es ist demnach eine Kleinbetragsrechnung ausreichend. "];

		[s appendString:@"Wurde diese den Vorgaben des "];

		if ([bruttowert floatValue] > 250.0)
			[s appendString:@"§ 14 Abs. 4 UStG"];
		else
			[s appendString:@"§ 33 UStDV"];
	
		[s appendString:@" entsprechend ausgestellt, und handelt es sich beim Erwerber um einen Unternehmer, ist dieser zum Vorsteuerabzug in Höhe von "];
		[s appendString:[numberFormatter stringFromNumber:bruttowert]];
		[s appendString:[self checkIfToAddEndingZero:s]];
		[s appendString:@" € berechtigt. Auch der leistende "];

		[s appendString:@"Unternehmer hat für mit diesem Umsatz zusammenhängende Ausgaben den Vorsteuerabzug, sofern keine Ausnahme vorliegt.\n\n"];

		if ([[Data instance] fallDes13b])
			[s appendString:@"Es liegt ein Fall des § 13b UStG vor, die Steuerschuldnerschaft geht somit auf den Käufer über. Er muss einen Betrag in Höhe von "];
		else
			[s appendString:@"Ein Fall des § 13b UStG liegt nicht vor, somit ist der leistende Unternehmer gemäß § 13a Abs. 1 Nr. 1 UStG Steuerschuldner. Er muss einen Betrag in Höhe von "];
		[s appendString:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt]]]];
		[s appendString:[self checkIfToAddEndingZero:s]];
		[s appendString:@" € in seiner USt-Erklärung deklarieren."];

		if ([[Data instance] fallDes13b])
			[s appendString:@" Da der leistende Unternehmer nicht mehr Steuerschuldner ist, darf er auf seiner Rechnung auch keine Umsatzsteuer ausweisen."];
	}

	[s appendString:@"\n\n(Ergebnis kann editiert werden, Änderungen werden jedoch nicht gespeichert, bitte vorher Text kopieren.)\n\n"];

	return s;
}

- (void)setupTextView
{
	self.textView = [[UITextView alloc] initWithFrame:self.view.frame];
	self.textView.textColor = [UIColor blackColor];
	self.textView.font = [UIFont fontWithName:@"Arial" size:18];
	self.textView.delegate = self;
	self.textView.backgroundColor = [UIColor whiteColor];

	self.textView.text = self.composeResult;

	self.textView.returnKeyType = UIReturnKeyDefault;
	self.textView.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
	self.textView.scrollEnabled = YES;
	
	// this will cause automatic vertical resize when the table is resized
	self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	
	// note: for UITextView, if you don't like autocompletion while typing use:
	self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
	
	[self.view addSubview: self.textView];
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[numberFormatter setMaximumFractionDigits:2];
	// Gelöst über die Kategorie-Methode "checkIfToAddEndingZero", sonst würde aus 7 € immer 7,00 € werden, was ich unschön fand
	// [numberFormatter setMinimumFractionDigits:2];
	[numberFormatter setDecimalSeparator:@","];
	[numberFormatter setGroupingSeparator:@"."];

	self.title = NSLocalizedString(@"Ergebnis", @"");
	[self setupTextView];
}

- (void) print:(id)sender
{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
	pic.delegate = self;

    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    // printInfo.jobName = self.documentName;
	printInfo.jobName = NSLocalizedString(@"Lösung USt-Fall", nil);
	printInfo.duplex = UIPrintInfoDuplexNone;
	// printInfo.orientation = UIPrintInfoOrientationLandscape;
    pic.printInfo = printInfo;

	NSString * s = [NSString stringWithString:self.textView.text];

	if ([s rangeOfString:@"(Ergebnis kann editiert werden"].length != 0)
		s = [s substringToIndex:[s rangeOfString:@"(Ergebnis kann editiert werden"].location];
	s = [s stringByAppendingString:@"\nGedruckt mit www.umsatzsteuerapp.de"];

	UISimpleTextPrintFormatter *txtFormatter = [[UISimpleTextPrintFormatter alloc] initWithText:s];

    txtFormatter.startPage = 0;
    txtFormatter.contentInsets = UIEdgeInsetsMake(72.0, 72.0, 72.0, 72.0); // 1 inch margins
    txtFormatter.maximumContentWidth = 6 * 72.0;	
    pic.printFormatter = txtFormatter;
    pic.showsPageRange = YES;

    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
	^(UIPrintInteractionController *printController, BOOL completed, NSError *error)
	{
		if (!completed && error)
			NSLog(@"Printing could not complete because of error: %@", error);	
	};

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		[pic presentFromBarButtonItem:sender animated:YES completionHandler:completionHandler];
	else
		[pic presentAnimated:YES completionHandler:completionHandler];
}

- (void)viewWillAppear:(BOOL)animated 
{
    // listen for keyboard hide/show notifications so we can properly adjust the table's height
	[super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
	[self addNextButton:@"VorSt-B."];


	// Added Printer-Support
	
	// http://www.marco.org/1648550153 -> check for a class’ availability at runtime
	// Your project’s Base SDK must be iOS 4.2 (or greater in the future).
	// Your project’s Deployment Target must be iOS 3.1 or greater. (So you need to give up pre-3.1 iPhone compatibility.)
	// Your project’s C/C++ Compiler Version must be LLVM GCC 4.2 (if you need support for pre-4.0 iOS)
	// Due to this code Application should work on iOS-Devices down to iOS 3.1
	if ([UIPrintInteractionController class] == nil)
		return; 	//if (NSClassFromString(@"UIPrintInteractionController")) würde wohl auch klappen
	
	// Nur wenn eine Lösung angezeigt wird, Druckoption anbieten
	if (self.textView.text.length <= 120)
		return;
	
	if ([UIPrintInteractionController isPrintingAvailable])
	{
		// Initialize the toolbar
		toolbar = [[UIToolbar alloc] init];
		toolbar.barStyle = UIBarStyleDefault; // UIBarStyleBlack
		[toolbar sizeToFit]; // fit the width of the app
		CGFloat toolbarHeight = [toolbar frame].size.height; // Calculate the height of the toolbar
		CGRect rootViewBounds = self.parentViewController.view.bounds; // Get the bounds of the parent view
		CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds); // Get the height of the parent view
		CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds); // Get the width of the parent view
		CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight); // create a rectangle for the toolbar
		[toolbar setFrame:rectArea]; // Reposition and resize the receiver
		
		// Create spacers
		UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		UIBarButtonItem *flexibleSpaceRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		// Create Print-Button
		//UIBarButtonItem *printButton = [[UIBarButtonItem alloc] initWithTitle:@"Druck" style:UIBarButtonItemStyleBordered target:self action:@selector(print:)];
		UIBarButtonItem *printButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(print:)];
		
		// Add Spaces and Print-Button to toolbar
		[toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, printButton, flexibleSpaceRight, nil]];
		
		// Add the toolbar as a subview to the navigation controller
		[self.navigationController.view addSubview:toolbar];
		
		// Release all objects
	}	
}

- (void)viewDidDisappear:(BOOL)animated 
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];

	// Nicht ganz sauber, aber ich remove die Superview einfach IMMER, auch wenn sie gar nicht da ist (< iOS 4.2)
	[toolbar removeFromSuperview];
	// Nur falls wir die toolbar auch hinzugefügt haben, diese entfernen
	// Dieser check funktioniert leider nicht, ka
	// if ([self.navigationController.view.subviews indexOfObjectIdenticalTo:toolbar] != NSNotFound) { [self alert]; }
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
	// the keyboard is showing so resize the table's height
	CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    NSTimeInterval animationDuration =
	[[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.size.height -= keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    // the keyboard is hiding so reset the table's height

	CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    NSTimeInterval animationDuration =
	[[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.size.height += keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}


#pragma mark -
#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	// provide my own Save button to dismiss the keyboard
	UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																			  target:self action:@selector(saveAction:)];
	self.navigationItem.rightBarButtonItem = saveItem;
}

- (void)saveAction:(id)sender
{
	// finish typing text/dismiss the keyboard by removing it as the first responder
	[self.textView resignFirstResponder];

	// this will remove the "save" button
	self.navigationItem.rightBarButtonItem = nil;

	// Fügt wieder den normalen Button hinzu
	[self addNextButton:@"VorSt-B."];
}

#pragma mark -
#pragma mark dealloc


@end
