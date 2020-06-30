#import "StufeBMG2.h"

@implementation StufeBMG2

@synthesize typ,textField;

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.title == nil) {
		self.title = NSLocalizedString(@"BMG:", nil);
    }

	numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setDecimalSeparator:@","];
	[numberFormatter setGroupingSeparator:@"."];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	// Observe keyboard hide and show notifications to resize the view appropriately.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

	[self addNextButton:@"Steuersatz"];

	[self.tableView reloadData];
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
        if (typ == 1) {
			return 222.0; // 160.0;
        } else {
			return 90.0;
        }
	} else {
		return 44.0;
	}
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (typ > 0) {
		return 2;
    } else {
		return 1;
    }
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		static NSString *kCellIdentifier = @"CellBMG";
		UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.textLabel.numberOfLines = 0;

		switch (typ) {
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Mindest-BMG (Wiederbeschaffungskosten, Selbstkosten oder entstandene Ausgaben) bei Umsätzen von\n- EU an nahestehende Personen\n- U. an AN o. deren Angehörige\n- Gesellschaften an ihre Anteils-\n  eigner, Gesellschafter, Mit-\n  glieder, Teilhaber oder diesen\n  nahestehende Personen", nil);
				break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"Nettokaufpreis zzgl. Nebenkosten zum Zeitpunkt des Umsatzes.", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Zum Zeitpunkt des Umsatzes. Selbstkosten sind z. B. bei eigener Herstellung des Gegenstandes anzusetzen.", nil);
				break;
			case 4:
				cell.textLabel.text = NSLocalizedString(@"Inkl. linearer AFA, verteilt auf 5 (bei Grundstücken 10) Jahre (oder kürzere ND), sofern Anschaffungskosten > 500 €.", nil);
				break;
		}

		return cell;
    } else { //if (indexPath.section == 0)
		static NSString *kCellTextField_ID = @"CellTextField_ID";
		UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:kCellTextField_ID];
        // a new cell needs to be created
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellTextField_ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

		[cell.contentView addSubview:[self getTheTextField]];

		// cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		return cell;
	}
}

#pragma mark TheTextField

- (UITextField *)getTheTextField {
	if (textField == nil) {
		CGRect frame = CGRectMake(20.0, 8.0, 160.0, 30.0);
		textField = [[UITextField alloc] initWithFrame:frame];

		textField.borderStyle = UITextBorderStyleRoundedRect;
		textField.textColor = [UIColor blackColor];
		textField.font = [UIFont systemFontOfSize:17.0];
		// textField.text = @"100,00";
		textField.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt]]];
		textField.clearsOnBeginEditing = TRUE;
		textField.backgroundColor = [UIColor whiteColor];
		textField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
		textField.textAlignment = NSTextAlignmentRight;

		textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		textField.returnKeyType = UIReturnKeyDone;

		// textField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right

		UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 55.0, 20.0)];
		label1.text = NSLocalizedString(@"  BMG:", nil);
		textField.leftView = label1;
		textField.leftViewMode = UITextFieldViewModeAlways;

		UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 22.0, 20.0)];
		label2.text = NSLocalizedString(@"€", nil);
		label2.textAlignment = NSTextAlignmentLeft;
		textField.rightView = label2;
		textField.rightViewMode = UITextFieldViewModeAlways;

		textField.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed

		// Add an accessibility label that describes what the text field is for.
		[textField setAccessibilityLabel:NSLocalizedString(@"RoundedTextField", @"")];
	}
	return textField;
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
	[textField resignFirstResponder];

    self.navigationItem.rightBarButtonItem = nil;   // this will remove the "save" button
	[self addNextButton:@"Steuersatz"]; // Fügt wieder den normalen Button hinzu
}


// Dismiss the keyboard when the view outside the text field is touched.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	// Diese Methode wird iwie nie aufgerufen, also kein Abbruch über einen Klick irgendwo hin möglich
    [self doneTyping:nil];
	//[self alert];
    [super touchesBegan:touches withEvent:event];
}

 
#pragma mark Finish Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];

	// Den eingegebenen Wert global speichern
	//[[Data instance] setEntgelt:[[textField text] floatValue]];
	[[Data instance] setEntgelt:[[numberFormatter numberFromString:[textField text]] floatValue]];
	//[self alertWithString:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt]]]];
}

#pragma mark -
#pragma mark implementierte Delegate-Methoden

- (BOOL) textField:(UITextField*)textFieldIn shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)textEntered {
	// sorgt dafür, dass man nur eine bestimmte Anzahl von Stellen eingeben kann
	NSUInteger newLength = [textFieldIn.text length] + [textEntered length] - range.length;
	if (newLength > 8 && [textFieldIn.text rangeOfString:@","].length > 0) // Bei nem Komma mit drin lassen wir noch eine Stellen mehr zu
		return NO;

    if (newLength > 7 && [textFieldIn.text rangeOfString:@","].length <= 0) {
        return NO;
    }
	// Es gibt leider unsinnige Runden, wenn ich mehr Stellen zulassen würde

	// Ich arbeite hier bewusst mit Kommas, da deutsches Programm, aber man könnte wohl auch mit
	// [numberFormatter decimalSeparator] arbeiten

	NSCharacterSet *NUMBERS	= [NSCharacterSet characterSetWithCharactersInString:@"0123456789,"];

	// Zuerst doppelte Kommas raushauen
    if ([textFieldIn.text rangeOfString:@","].length > 0 && [textEntered isEqualToString:@","]) {
        return NO;
    }

	// Mehr als 2 NKS verhindern
	// Kein Backspace & es gibt bereits ein Komma & das Komma ist an 3.letzter Stelle
    if (textEntered.length > 0 && [textFieldIn.text rangeOfString:@","].length > 0 && [textFieldIn.text rangeOfString:@","].location + 3 == [textFieldIn.text length]) {
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

#pragma mark -
#pragma mark dealloc


@end
