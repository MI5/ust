#import "StufeFrei.h"
#import "StufeBMG.h"
#import "StufeOption.h"

@implementation StufeFrei

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Steuerbefreiung", nil);
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[Data instance] itIs3_1a]) {
		return NSLocalizedString(@"Steuerfrei", nil);
    }

    if (section == 0) {
		return NSLocalizedString(@"Steuerpflicht", nil);
    }

    if (section == 1) {
		return NSLocalizedString(@"Steuerfrei mit Besteuerungs-Option", nil);
    } else {
		return NSLocalizedString(@"Steuerfrei (Auszug)", nil);
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[Data instance] itIs3_1a]) {
		return 1;
    }

    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
		return 1;
    }

    if (section == 1) {
		return 5;
    } else {
		return 12;
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

	if (indexPath.section == 0) {
		cell.textLabel.text = NSLocalizedString(@"Keine Steuerbefreiung", nil);
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	if (indexPath.section == 1) {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Vermietung & Verpachtung", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Erbbaurechte", nil);
				break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"andere Grundstücksumsätze", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Geld-, Kapital-, Kreditumsätze", nil);
				break;
			case 4:
				cell.textLabel.text = NSLocalizedString(@"Blindenwerkstattumsätze", nil);
				break;
		}
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	if (indexPath.section == 2) {
		cell.accessoryType = UITableViewCellAccessoryNone;
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Ausfuhr (Lief. in das Drittland)", nil);
				break;
			case 1:
				// Weil abweichendes Zellformat eigener CellIdentifier
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellFont120NOL0"];
                cell.textLabel.font = [UIFont systemFontOfSize:12.0];
                cell.textLabel.numberOfLines = 0;

				cell.textLabel.text = NSLocalizedString(@"Innergemeinschaftl. Lieferung an Unternehmer und Erwerb unterliegt beim Abnehmer der USt", nil);
				break;
			case 2:
				// Weil abweichendes Zellformat eigener CellIdentifier
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellFont120NOL0"];
                cell.textLabel.font = [UIFont systemFontOfSize:12.0];
                cell.textLabel.numberOfLines = 0;

				cell.textLabel.text = NSLocalizedString(@"Innergemeinschaftliche Lief. eines Neu-KFZ\nund Erwerb unterliegt beim Abnehmer der USt", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Lieferung in ein USt-Lager", nil);
				break;
			case 4:
				cell.textLabel.text = NSLocalizedString(@"Versicherungsumsätze", nil);
				break;
			case 5:
				cell.textLabel.text = NSLocalizedString(@"Bausparkassenvertreterumsätze", nil);
				break;
			case 6:
				cell.textLabel.text = NSLocalizedString(@"Versicherungsvertreterumsätze", nil);
				break;
			case 7:
				cell.textLabel.text = NSLocalizedString(@"Versicherungsmaklerumsätze", nil);
				break;
			case 8:
				cell.textLabel.text = NSLocalizedString(@"Heilbehandlungen (Humanmed.)", nil);
				break;
			case 9:
				cell.textLabel.text = NSLocalizedString(@"Altenpflege", nil);
				break;
			case 10:
				cell.textLabel.text = NSLocalizedString(@"Theater, Orchester, Museen u.ä.", nil);
				break;
			case 11:
				cell.textLabel.text = NSLocalizedString(@"Ehrenamtliche Tätigkeiten", nil);
				break;
		}
	}

	if ([[Data instance] itIs3_1a]) {
		// Weil abweichendes Zellformat eigener CellIdentifier
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellFont120NOL0"];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.numberOfLines = 0;

		cell.textLabel.text = NSLocalizedString(@"Innergemeinschaftl. Lieferung an Unternehmer und Erwerb unterliegt  beim Abnehmer der USt", nil);
	}

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([[Data instance] itIs3_1a]) {
		[self alertSchema: [NSString stringWithFormat:@"Der Umsatz ist zwar gemäß\n§ 1 Abs. 1 Nr. 1 UStG i. V. m. § 3 Abs. 1a UStG i. V. m. %@ steuerbar, aber gemäß § 4 Nr. 1 b) UStG nicht steuerpflichtig. Der korrespondierende i. g. E. ist im Ausland steuerbar nach jeweiligem Recht (analog § 1a Abs. 2 UStG). Es sind die Aufzeichnungspflichten gemäß UStAE 22.3 Abs. 1 Satz 2 zu beachten.", [[Data instance] steuerbarNach2]]];
		return;
	}

	if (indexPath.section == 0) {
		UITableViewController *nextStep = [[StufeBMG alloc] initWithNibName:@"StufeBMG" bundle:nil];
		[self.navigationController pushViewController:nextStep animated:YES];
	}

	if (indexPath.section == 1) {
		StufeOption *nextStep = [[StufeOption alloc] initWithNibName:@"StufeOption" bundle:nil];
		nextStep.typ = [indexPath indexAtPosition:1];
		[self.navigationController pushViewController:nextStep animated:YES];
	}

	if (indexPath.section == 2 && ![[[Data instance] steuerbarNach2] isEqualToString:@"?"]) {
        if ([[Data instance] bmgTyp] == undefinedBMG) {
			[self alertSchema: [NSString stringWithFormat:@"Der Umsatz ist zwar gemäß\n§ 1 Abs. 1 Nr. 1 UStG i. V. m. %@ steuerbar, aber gemäß § 4 UStG nicht steuerpflichtig.", [[Data instance] steuerbarNach2]]];
        } else {
			[self alertSchema: [NSString stringWithFormat:@"Der Umsatz ist zwar gemäß\n§ 1 Abs. 1 Nr. 1 UStG i. V. m. %@ i. V. m. %@ steuerbar, aber gemäß § 4 UStG nicht steuerpflichtig.", [[Data instance] steuerbarNach1], [[Data instance] steuerbarNach2]]];
        }
	}
}


@end
