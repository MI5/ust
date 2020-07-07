#import "IgeResult.h"

@implementation IgeResult

@synthesize textView;

- (NSString*)composeResult
{
	NSMutableString* s = [NSMutableString stringWithCapacity:1024];

	[s setString:@""];

	if ([[[Data instance] steuerbarNach2] isEqualToString:@"?"])
	{
		[s appendString:@"Beginnen sie mit dem Schritt \"Steuerbarkeit\", um die Komplettlösung zu einem Fall zu erhalten."];
		return s;
	}

	[s appendString:@"Es liegt ein steuerbarer innergemeinschaftlicher Erwerb gemäß § 1 Abs. 1 Nr. 5 UStG vor. "];

	if ([[Data instance] bmgTyp] == entgeltlichBMG)
		[s appendString:@"Es handelt sich dabei um den Erwerb eines neuen KFZ durch eine Privatperson nach § 1b UStG. "];
	if ([[Data instance] bmgTyp] == unentgeltlichBMG)
		[s appendString:@"Es handelt sich dabei um einen Erwerb gegen Entgelt nach § 1a Abs. 1 UStG. "];
	if ([[Data instance] bmgTyp] == verbringenBMG)
		[s appendString:@"Es handelt sich dabei um ein Verbringen nach § 1a Abs. 2 UStG (sogenannter fiktiver Erwerb). "];


	[s appendString:@"Der Ort des Umsatzes liegt gemäß § 3d Satz 1 UStG dort, wo die Beförderung oder Versendung endet, und somit im "];
	[s appendString:@"Inland. Der Umsatz ist auch steuerpflichtig, da eine Steuerbefreiung "];
	[s appendString:@"nach § 4b UStG nicht greift.\n\nDie Bemessungsgrundlage richtet sich gemäß "];
	if ([[Data instance] bmgTyp] == verbringenBMG)
		[s appendString:@"§ 10 Abs. 4 Satz 1 Nr. 1 UStG nach den Wiederbeschaffungskosten "];
	else
		[s appendString:@"§ 10 Abs. 1 Satz 4 UStG nach dem Entgelt zzgl. eventueller Verbrauchsteuer "];

	[s appendString:@"und beträgt "];
	[s appendString:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt]]]];
	[s appendString:[self checkIfToAddEndingZero:s]];
	[s appendString:@" €. "];

	[s appendString:@"Gemäß "];

	NSNumber* bruttowert;
	if ([[Data instance] steuersatz] == k19Prozent)
	{
		[s appendString:@"§ 12 Abs. 1 UStG ist der allgemeine Steuersatz von 19"];

		bruttowert = [NSNumber numberWithFloat:[[Data instance] entgelt] * 1.19];
	}
	else
	{
		[s appendString:@"§ 12 Abs. 2 UStG ist der ermäßigte Steuersatz von 7"];

		bruttowert = [NSNumber numberWithFloat:[[Data instance] entgelt] * 1.07];
	}
	[s appendString:@" Prozent anzuwenden. Der Bruttobetrag lautet somit über "];
	[s appendString:[numberFormatter stringFromNumber:bruttowert]];
	[s appendString:[self checkIfToAddEndingZero:s]];
	[s appendString:@" €"];

	// Verbringen
	if ([[Data instance] bmgTyp] == verbringenBMG)
	{
		[s appendString:@" und es ist Erwerbsumsatzsteuer in Höhe von "];
		if ([[Data instance] steuersatz] == k19Prozent)
		{
			bruttowert = [NSNumber numberWithFloat:[bruttowert floatValue] - ([bruttowert floatValue] / 1.19)];
		}
		else
		{
			bruttowert = [NSNumber numberWithFloat:[bruttowert floatValue] - ([bruttowert floatValue] / 1.07)];
		}
		[s appendString:[numberFormatter stringFromNumber:bruttowert]];
		[s appendString:[self checkIfToAddEndingZero:s]];
		[s appendString:@" € fällig. Der Unternehmer hat einen Betrag in Höhe von "];
		[s appendString:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt]]]];
		[s appendString:[self checkIfToAddEndingZero:s]];
		[s appendString:@" € in seiner USt-Erklärung als steuerpflichtigen innergemeinschaftlichen Erwerb zu deklarieren. "];
		[s appendString:@"Der Unternehmer hat die Erwerbsumsatzsteuer für das Verbringen zwar abzuführen, "];
		[s appendString:@"kann diese aber gleichzeitig als Vorsteuer abziehen, soweit er zum Vorsteuerabzug berechtigt ist. "];

		[s appendString:@"Gemäß UStAE 14a.1 Abs. 3 Satz 2 hat der Unternehmer über diesen Vorgang eine "];
		[s appendString:@"sogenannte pro-forma-Rechnung auszustellen."];
	}

	// privater KFZ-Erwerb
	if ([[Data instance] bmgTyp] == entgeltlichBMG)
	{
		[s appendString:@" und es ist Erwerbsumsatzsteuer in Höhe von "];
		if ([[Data instance] steuersatz] == k19Prozent)
		{
			bruttowert = [NSNumber numberWithFloat:[bruttowert floatValue] - ([bruttowert floatValue] / 1.19)];
		}
		else
		{
			bruttowert = [NSNumber numberWithFloat:[bruttowert floatValue] - ([bruttowert floatValue] / 1.07)];
		}
		[s appendString:[numberFormatter stringFromNumber:bruttowert]];
		[s appendString:[self checkIfToAddEndingZero:s]];
		[s appendString:@" € fällig. Der gemäß § 13 Abs. 1 Nr. 7 UStG am Tag des KFZ-Erwerbs entstandene USt-Anspruch ist innerhalb von "];
		[s appendString:@"zehn Tagen durch Abgabe einer Steuererklärung für die Fahrzeugeinzelbesteuerung "];
		[s appendString:@"(§ 16 Abs. 5a UStG i. V. m. § 18 Abs. 5a UStG) beim Wohnsitzfinanzamt (§ 21 Abs. 2 AO) anzumelden und zu zahlen. "];
		[s appendString:@"Es besteht keine Berechtigung zum Vorsteuerabzug."];
	}

	// Normaler i. g. E.-Erwerb
	if ([[Data instance] bmgTyp] == unentgeltlichBMG)
	{
		[s appendString:@". Der Erwerber hat zwar die Erwerbsumsatzsteuer in Höhe von "];
		if ([[Data instance] steuersatz] == k19Prozent)
		{
			bruttowert = [NSNumber numberWithFloat:[bruttowert floatValue] - ([bruttowert floatValue] / 1.19)];
		}
		else
		{
			bruttowert = [NSNumber numberWithFloat:[bruttowert floatValue] - ([bruttowert floatValue] / 1.07)];
		}
		[s appendString:[numberFormatter stringFromNumber:bruttowert]];
		[s appendString:[self checkIfToAddEndingZero:s]];
		[s appendString:@" € abzuführen, kann diese aber gleichzeitig als Vorsteuer abziehen. "];

		[s appendString:@"Entsprechend § 22 Abs. 2 Nr. 7 UStG hat der Unternehmer über die Bemessungsgrundlage und die darauf "];
		[s appendString:@"entfallende Steuer Aufzeichnungen zu machen."];
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
