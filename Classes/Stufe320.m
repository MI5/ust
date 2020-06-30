#import "Stufe320.h"
#import "Stufe3200.h"

static const NSInteger kSection0	= 0;
// static const NSInteger kSection1	= 1;


@implementation Stufe320

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Ort?", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[Data instance] leistungsArt] == kUndefined) {
		return 2;
    } else {
		return 1;
    }
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[Data instance] itIs3_1a]) {
		return 1;
    }

	if ([[Data instance] leistungsArt] == kUndefined) {
        if (section == kSection0) {
			return 6;
        } else {
			return 12;
        }
	}

    if ([[Data instance] leistungsArt] == kLieferung) {
		return 6;
    } else {
		return 12; //leistungsArt == kSonstLeistung
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[Data instance] itIs3_1a]) {
		return NSLocalizedString(@"Ort der Lieferung", nil);
    }

	if ([[Data instance] leistungsArt] == kUndefined) {
        if (section == kSection0) {
            return NSLocalizedString(@"Prüfung von oben nach unten\n\nOrt der Lieferung", nil);
        } else {
            return NSLocalizedString(@"Ort der sonstigen Leistung", nil);
        }
	}

    if ([[Data instance] leistungsArt] == kLieferung) {
		return NSLocalizedString(@"Prüfung von oben nach unten\n\nOrt der Lieferung", nil);
    } else {
        // leistungsArt == kSonstLeistung
		return NSLocalizedString(@"Prüfung von oben nach unten\n\nOrt der sonstigen Leistung", nil);
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell320";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.numberOfLines = 0;

	if (indexPath.section == kSection0 && [[Data instance] leistungsArt] != kSonstLeistung) {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Lieferung aus dem Drittland und Lieferer ist Schulder der EUSt", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Lieferung von Gas, Wärme oder Kälte über Netze oder Elektrizität", nil);
				break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"Ruhende Lieferung beim Reihengeschäft", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Lieferung ohne Bewegung", nil);
				break;
			case 4:
				cell.textLabel.text = NSLocalizedString(@"Innergemeinschaftlicher Versand- handel an Priv./Halbunternehmer", nil);
				break;
			case 5:
				cell.textLabel.text = NSLocalizedString(@"Beförderungs-/ Versendungslieferung", nil);
				break;
		}
	} else {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Leistungen im Zusammenhang mit einem Grundstück", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Kurzfristige Vermietung eines Beförderungsmittels", nil);
				break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"Eintrittsberechtigung für Veranstaltungsleistungen an U.", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Restaurationsleistungen", nil);
				break;
			case 4:
				cell.textLabel.text = NSLocalizedString(@"Vermittlungsleistungen", nil);
				break;
			case 5:
				cell.textLabel.text = NSLocalizedString(@"Personenbeförderungen", nil);
				break;
			case 6:
				cell.textLabel.text = NSLocalizedString(@"Übrige Leistungen an Unternehmer (B2B)", nil);
				break;
			case 7:
				cell.textLabel.text = NSLocalizedString(@"Veranstaltungsleistungen an Privat", nil);
				break;
			case 8:
				cell.textLabel.text = NSLocalizedString(@"Arbeiten an bewegl. Gegenständ./ Begutachtung dieser für Privat", nil);
				break;
			case 9:
				cell.textLabel.text = NSLocalizedString(@"Leistung des Leistungskatalog an Private mit Sitz im Drittland", nil);
				break;
			case 10:
				cell.textLabel.text = NSLocalizedString(@"Digitale Leistung aus Drittland an Private mit Sitz im EU-Gebiet", nil);
				break;
			case 11:
				cell.textLabel.text = NSLocalizedString(@"Alle übrigen sonstigen Leistungen an Privat (B2C)", nil);
				break;
			case 12: // ToDo: § 3a Absatz 6
				cell.textLabel.text = NSLocalizedString(@"13", nil);
				break;
		}
	}

    if ([[Data instance] itIs3_1a]) {
		cell.textLabel.text = NSLocalizedString(@"Beförderungs-/ Versendungslieferung", nil);
    }

	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Stufe3200 *nextStep = nil;

	nextStep = [[Stufe3200 alloc] initWithNibName:@"Stufe3200" bundle:nil];

    if (indexPath.section == kSection0  && [[Data instance] leistungsArt] != kSonstLeistung) {
		nextStep.typ = [indexPath indexAtPosition:1];
    } else {
		nextStep.typ = 10+[indexPath indexAtPosition:1];
    }

    if ([[Data instance] itIs3_1a]) {
		nextStep.typ = 5;
    }

	[self.navigationController pushViewController:nextStep animated:YES];
}



@end
