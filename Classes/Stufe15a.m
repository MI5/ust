#import "Stufe15a.h"

@implementation Stufe15a

@synthesize datePickerView;
@synthesize currentButton;
@synthesize date1;
@synthesize date2;
@synthesize years;
@synthesize steuersatz;
@synthesize prozent;

#pragma mark -
#pragma mark IBAction-methods

- (IBAction)changedGebaeude:(id)sender {
	// [self alertWithString:[sender description]];

    if (((UISwitch*)sender).on) {
		self.years = 10;
    } else {
		self.years = 5;
    }

    if (!datePickerView.hidden) {
		[self showDatePicker];
    }

	[self updateRechnung];
}
- (IBAction)clickedDate1:(id)sender {
	// Falls die Tastatur oben ist
	[self doneEditing:nil];

	currentButton = sender;
	// currentButton = sender; //oder würde das reichen? Aber siehe auch bei Dealloc
	[self showDatePicker];
}
- (IBAction)clickedDate2:(id)sender {
	// Falls die Tastatur oben ist
	[self doneEditing:nil];

	currentButton = sender;
	[self showDatePicker];
}

#pragma mark -
#pragma mark Eigene Methoden

- (void)showDatePicker {
	// Hol vom Button das Datum in den Picker
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"dd.MM.yyyy"];

	// Beim allerersten Aufruf steht auf dem Button noch kein Datum
	if (![currentButton.currentTitle isEqualToString:@"Bitte wählen"]) {
		datePickerView.date = [format dateFromString:currentButton.currentTitle];
	} else {
		// Erster Aufruf
		datePickerView.date = [NSDate date]; //today
	}


	if (date2 != nil && currentButton.tag == 1) {
		datePickerView.maximumDate = date2;

		// Wenn date2 schon bekannt ist, maximal 5 bzw. 10 Jahre zurück
		datePickerView.minimumDate = [NSDate dateWithTimeInterval:-60*60*24*365.2*self.years sinceDate:date2];

		if (datePickerView.date.timeIntervalSinceNow < datePickerView.minimumDate.timeIntervalSinceNow)
			[datePickerView setDate:datePickerView.minimumDate animated:YES];

	}
	if (date1 != nil && currentButton.tag == 2) {
		datePickerView.minimumDate = date1;

		// Wenn date1 schon bekannt ist, maximal 5 bzw. 10 Jahre vor
		datePickerView.maximumDate = [NSDate dateWithTimeInterval:60*60*24*365.2*self.years sinceDate:date1];

		if (datePickerView.date.timeIntervalSinceNow > datePickerView.maximumDate.timeIntervalSinceNow)
			[datePickerView setDate:datePickerView.maximumDate animated:YES];
	}

	datePickerView.hidden = NO;

	// provide my own Save button to dismiss the datePicker
    if (self.navigationItem.rightBarButtonItem == nil) { // nur falls der Button nicht schon da ist.
		UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																				  target:self action:@selector(doneTyping:)];
		self.navigationItem.rightBarButtonItem = saveItem;
	}
}

- (void)doneTyping:(id)sender {
	// Hol vom Picker das Datum auf den Button
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"dd.MM.yyyy"];
	NSString *s = [format stringFromDate:datePickerView.date];
	[currentButton setTitle:s forState:UIControlStateNormal];
	[currentButton setTitle:s forState:UIControlStateHighlighted];
	[currentButton setTitle:s forState:UIControlStateDisabled];
	[currentButton setTitle:s forState:UIControlStateSelected];

	// Gewählts Datum zusätzlich zwischenspeichern als NSDate

	// Es funktioniert hier nur mit copy, das hat mich 5 Stunden Fehlersuche gekostet
	if (currentButton.tag == 1) {
		date1 = datePickerView.date.copy;

		// Falls Datum vor dem 1.1.2007 und Steuersatz = 19 %, muss Steuersatz auf 16 % gesetzt werden
																				 // + die Schaltjahre
		NSDate *compareDate = [NSDate dateWithTimeIntervalSince1970:60*60*24*365*37+60*60*24*9];
								// Ich muss 1 Stunde adden, weil wir sonst, warum auch immer, eine Stunde zu weit hinten sind, und somit den falschen Tag haben
		if (steuersatz > 0.15 && [[date1 dateByAddingTimeInterval:60*60] timeIntervalSince1970] < compareDate.timeIntervalSince1970) {
			steuersatz = 0.16;
			// NSLog(@"%@ < %@",date1.description,compareDate.description);
			[self updateSteuersatz];
		} else if (steuersatz > 0.15 && [[date1 dateByAddingTimeInterval:60*60] timeIntervalSince1970] >= compareDate.timeIntervalSince1970) {
			steuersatz = 0.19;
			// NSLog(@"Drin bei 0.19");
			[self updateSteuersatz];
		}
	} else {
		date2 = datePickerView.date.copy;
	}

	datePickerView.hidden = YES;

    self.navigationItem.rightBarButtonItem = nil;   // this will remove the "save" button

	// Schalter deaktivieren, falls Daten mehr als 5 Jahre auseinander				// 1 Stunde Sicherheitsabstand
    if (date2.timeIntervalSinceNow - date1.timeIntervalSinceNow > 60*60*24*365.2*5 + 60*60) {
		schalter.enabled = NO;
    } else {
		schalter.enabled = YES;
    }

	[self updateRechnung];
}

- (void)updateSteuersatz {
	[satz setText:[NSString stringWithFormat:@"Steuersatz: %0.0f %%",steuersatz*100]];
	[vorsteuer setText:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt] * steuersatz]]];
}

- (void)updateRechnung {
    if (date1 == nil || date2 == nil) {
		return;
    }

	[korrektur setText:@"-"];
	[formel setText:@""];

	// Hier kein * prozent, da ich ja von der ursprünglichen Verwendungshöhe ausgehe
	if ([[Data instance] entgelt] * steuersatz <= 1000.0) {
		hinweis.textColor = UIColor.redColor;
		hinweis.text = @"Es ist keine Vorsteuerberichtigung vorzunehmen, da Vorsteuer kleiner oder gleich 1.000 € (§ 44 Abs. 1 UStDV).";
		hinweis.hidden = NO;
		return;
	}

	// § 44 (2) UStDV
	// Muss eigentlich auch noch weiter unten betrachtetet werden, wegen einzelner Kalenderjahrbetrachtung, falls kein volles Jahr
	if (prozent < 0.1 && [[Data instance] entgelt] * steuersatz * prozent / self.years <= 1000.0) {
		hinweis.textColor = UIColor.redColor;
		hinweis.text = @"Keine Berichtigung, da Korrektur jedes Jahr kleiner 1.000 € und Änderung um weniger als 10 Prozentpunkte (§ 44 Abs. 2 UStDV).";
		hinweis.hidden = NO;
		return;
	}

	// NSInteger is not a object
	NSInteger start_tag;
	NSInteger start_monat;
	NSInteger start_jahr;
	NSInteger ende_monat;
	NSInteger ende_jahr;

	NSDateFormatter *format = [[NSDateFormatter alloc] init];

	[format setDateFormat:@"dd"];
	start_tag = [[format stringFromDate:date1] integerValue];
	[format setDateFormat:@"MM"];
	start_monat = [[format stringFromDate:date1] integerValue];
	[format setDateFormat:@"yyyy"];
	start_jahr = [[format stringFromDate:date1] integerValue];
	[format setDateFormat:@"dd"];
	[format setDateFormat:@"MM"];
	ende_monat = [[format stringFromDate:date2] integerValue];
	[format setDateFormat:@"yyyy"];
	ende_jahr = [[format stringFromDate:date2] integerValue];


	NSInteger korrektor = 1;

	// § 45 UStDV und R 216 (6) Beispiel 1 und Beispiel 2
	if (start_tag > 15) {
		// Spezieller Sonderfall, wenn Start- und End-Jahr sowie Monat gleich sind und start_tag > 15
        if (start_tag > 15 && start_monat == ende_monat && start_jahr == ende_jahr) {
			korrektor = 0;
        }

		start_monat++;
		if (start_monat == 13) {
			start_monat = 1;
			start_jahr++;
		}

		//ende_monat++;
		//if (ende_monat == 13)
		//{
		//	ende_monat = 1;
		//	ende_jahr++;
		//}

		// Auf den Endtag innerhalb des Monats kommt es gar nicht an, sondern nur in welchem Monat überhaupt Beginn
		// Berichtigung. Der Monat in dem Änderung auftritt ist komplett zu korrigieren
	}
	NSInteger differenz_monate;
	if (ende_jahr - start_jahr == 0) {
		differenz_monate = ende_monat - start_monat;
	} else {
        if (ende_monat >= start_monat) {
			differenz_monate = ((ende_jahr - start_jahr) * 12) + (ende_monat - start_monat);
        } else {
			differenz_monate = ((ende_jahr - start_jahr) * 12) - (start_monat - ende_monat);
        }
	}

	// wegen des aufrundens bei > 15, ergibt sich bei daten > 15 im gleichen monat ein Wert von -1
    if (differenz_monate == -1) {
		differenz_monate++;
    }

	// korrekte Monate:
	// [self alert:differenz_monate];
	// Zu berichtigende Monate:
	// [self alert:(self.years*12 - differenz_monate)];

	NSNumberFormatter* numberFormatter2 = [[NSNumberFormatter alloc] init];
	[numberFormatter2 setNumberStyle:NSNumberFormatterDecimalStyle];
	[numberFormatter2 setMaximumFractionDigits:0];
	[numberFormatter2 setGroupingSeparator:@""];

	NSString* monate = @"Monate";
    if (self.years*12-differenz_monate == 1) {
		monate = @"Monat";
    }

	// Falls Prozentzahl kleiner 1, dann anzeigen
	NSString* e = @"";
    if (prozent < 1.0) {
		e = [NSString stringWithFormat:@" * %@",[numberFormatter stringFromNumber:[NSNumber numberWithFloat:prozent]]];
    }

	[formel setText:[NSString stringWithFormat:@"%@ Korrektur-%@ / %@ Gesamt-Monate * %@%@ =",
					 [numberFormatter2 stringFromNumber:[NSNumber numberWithFloat:self.years*12-differenz_monate]],
					 monate,
					 [numberFormatter2 stringFromNumber:[NSNumber numberWithFloat:self.years*12]],
					 [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[Data instance] entgelt] * steuersatz]],
					 e
					 ]];
	formel.hidden = NO;

	[korrektur setText:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:((self.years*12) - differenz_monate)/(self.years*12) * ([[Data instance] entgelt] * steuersatz * prozent)]]];


	hinweis.textColor = UIColor.darkTextColor;
	// Hier kein * prozent, da ich ja von der ursprünglichen Verwendungshöhe ausgehe
    // § 44 Abs. 3 UStDV wurde mit Wirkung ab VZ 2012 abgeschafft und gilt nur für angeschaffte Güter bis zu diesem Zeitpunkt
	if (([[Data instance] entgelt] * steuersatz <= 2500.0) && (start_jahr < 2012)) {
		hinweis.text = NSLocalizedString(@"Die Berichtigung ist am Ende des Berichtigungszeitraums vorzunehmen, da Anschaffung vor 2012 (§ 44 Abs. 3 UStDV a. F.).", nil);
		hinweis.hidden = NO;
	} else {
		if ((self.years*12-differenz_monate) > (12-ende_monat)) {
			NSString* zwischenjahr;
			if (start_jahr+self.years - ende_jahr > 1.0) {
				NSString* e = @"";
                if (start_jahr+self.years - ende_jahr > 2.0) {
					e = @"e";
                }

				zwischenjahr = [NSString stringWithFormat:@"Korrektur Zwischenjahr%@: %@ € (12 M.)",
									e,
									[numberFormatter stringFromNumber:[NSNumber numberWithFloat:12/(self.years*12) * ([[Data instance] entgelt] * steuersatz) * prozent]]
									];
			} else {
				zwischenjahr = @"";
			}

			// § 44 (4) Satz 1 UStDV = Wenn kleiner 6000, dann erst am Ende des Jahres und keine Voranmeldung nötig
			NSString* ohne_VAZ1 = @"";
            // Rechnung von unten geklaut
            if ((12-ende_monat+korrektor)/(self.years*12) * ([[Data instance] entgelt] * steuersatz) * prozent <= 6000.0) {
				ohne_VAZ1 = @"Ende ";
            }

			NSString* ohne_VAZ2 = @"";
            // Rechnung von unten geklaut
            if ((start_monat-1)/(self.years*12) * ([[Data instance] entgelt] * steuersatz) * prozent <= 6000.0) {
				ohne_VAZ2 = @"Ende ";
            }
			// Für die Zwischenjahre aus Platzmangel kein Hinweis ob am Ende oder monatlich, aber hier gilt auch die 6.000,-€-Grenze

			hinweis.text = [NSString stringWithFormat:@"Korrektur %@%ld: %@ € (%ld M.)\n%@\nKorrektur %@%@: %@ € (%ld M.)",
							ohne_VAZ1,
							(long)ende_jahr,
							[numberFormatter stringFromNumber:[NSNumber numberWithFloat:(12-ende_monat+korrektor)/(self.years*12) * ([[Data instance] entgelt] * steuersatz) * prozent]],
							(12-ende_monat+korrektor),
							zwischenjahr,
							ohne_VAZ2,
							[numberFormatter2 stringFromNumber:[NSNumber numberWithFloat:start_jahr+self.years]],
							[numberFormatter stringFromNumber:[NSNumber numberWithFloat:(start_monat-1)/(self.years*12) * ([[Data instance] entgelt] * steuersatz) * prozent]],
							(start_monat-1)
							];
			hinweis.hidden = NO;
		} else {
			hinweis.text = NSLocalizedString(@"Die Berichtigung ist am Ende des Berichtigungszeitraums vorzunehmen.", nil);
			hinweis.hidden = NO;
		}
	}
}

#pragma mark -
#pragma mark UIPickerView


// return the picker frame based on its size, positioned at the bottom of the page
- (CGRect)pickerFrameWithSize:(CGSize)size {
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect pickerRect = CGRectMake(	0.0,
								   screenRect.size.height - 44.0 - size.height,
								   size.width,
								   size.height);
	return pickerRect;
}

- (void)createDatePicker {
	datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectZero];
	datePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	datePickerView.datePickerMode = UIDatePickerModeDate;

    // Avoid iOS7-transparency
    datePickerView.backgroundColor = [UIColor whiteColor];

	NSDate *today = [NSDate date];
	datePickerView.date = today;
	//datePickerView.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*365.25*13];
	//datePickerView.minimumDate = [NSDate dateWithTimeIntervalSince1970:60*60*24*365.26*27]; // §27 (8) UStG
	datePickerView.minimumDate = [NSDate dateWithTimeIntervalSince1970:60*60*24*365.26*28+60*60*24*90]; // 1.4.1998 ist besser, ab da 16 %
	datePickerView.maximumDate = today;

	// datePickerView.delegate = self; // Wird leider nicht unterstützt bei DatePickerViews, nur bei anderen Pickern

	// note we are using CGRectZero for the dimensions of our picker view,
	// this is because picker views have a built in optimum size,
	// you just need to set the correct origin in your view.

	// position the picker at the bottom
	CGSize pickerSize = [datePickerView sizeThatFits:CGSizeZero];
	datePickerView.frame = [self pickerFrameWithSize:pickerSize];

	// add this picker to our view controller, initially hidden
	datePickerView.hidden = YES;
	[self.view addSubview:datePickerView];
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	// Vor Aufruf von UpdateSteuersatz initialisieren, weil dort schon numberFormatter benutzt wird
	numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	[numberFormatter setDecimalSeparator:@","];
	[numberFormatter setGroupingSeparator:@"."];

	// Nur hiermit und im Zusammenhang mit dem gesetzten Protokoll in der h-datei funktioniert die Methode shouldChangeCharactersInRange
	prozentsatz.delegate = self;

	self.title = NSLocalizedString(@"Änd. d. Verhältnisse", @"");

	self.years = 5;

	self.prozent = 1;

    if ([[Data instance] steuersatz] == k19Prozent) {
		steuersatz = 0.19;
    } else {
		steuersatz = 0.07;
    }

	[self updateSteuersatz];

	// Objekte erzeugen, sonst kann ich später nicht releasen
	// irgendwie klappt releasen trotzdem, obwohl Objekte nicht garantiert erzeugt werden, trotzdem unten ein @try
	// ich verlasse mich in "showDatePicker" auf anfängliches nicht-erzeugen (nil)
	// date1 = [[NSDate alloc] init];
	// date2 = [[NSDate alloc] init];

	[self createDatePicker];

    if ([[Data instance] entgelt] * steuersatz <= 1000.0) {
		hinweis.hidden = NO;
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

#pragma mark UITextField-delegate-Methode

// sorgt dafür, dass man nur eine bestimmte Anzahl von Stellen eingeben kann
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;

	return (newLength > 2) ? NO : YES;
}

#pragma mark Keyboard Methods

- (void)keyboardWillShow:(NSNotification *)aNotification {
	// provide my own Save button to dismiss the keyboard
    UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																			  target:self action:@selector(doneEditing:)];
    self.navigationItem.rightBarButtonItem = saveItem;
}


- (void)doneEditing:(id)sender {
    // finish typing text/dismiss the keyboard by removing it as the first responder
	[prozentsatz resignFirstResponder];

    self.navigationItem.rightBarButtonItem = nil;   // this will remove the "save" button

	if (prozentsatz.text.length == 0 || [prozentsatz.text isEqualToString:@"0"] || [prozentsatz.text isEqualToString:@"00"] || [prozentsatz.text isEqualToString:@"100"]) {
		[prozentsatz setText:NSLocalizedString(@"100", nil)];

		self.prozent = 1;
	} else {
		// Falls führende 0 diese entfernen, damit nachfolgende if-Abfrage immer funktioniert
		if ([prozentsatz.text characterAtIndex:0] == '0')
			[prozentsatz setText:[prozentsatz.text substringFromIndex:1]];

        if (prozentsatz.text.length == 1) {
			self.prozent = [[NSString stringWithFormat:@"0.0%@",prozentsatz.text] floatValue];
        } else {
			self.prozent = [[NSString stringWithFormat:@"0.%@",prozentsatz.text] floatValue];
        }
	}

	// NSLog(@"%f",self.prozent);

	[self updateRechnung];
}

// Dismiss the keyboard when the view outside the text field is touched.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	// Nur wenn die Tastatur oben ist, nicht wenn der DatePicker oben ist
    if ([prozentsatz isFirstResponder]) {
		[self doneEditing:nil];
    }

    [super touchesBegan:touches withEvent:event];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}



@end
