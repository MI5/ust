#import "Stufe33.h"

static const NSInteger kSection0	= 0;
// static const NSInteger kSection1	= 1;

@implementation Stufe33

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Entgelt?", nil);
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

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    [super viewDidUnload];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == kSection0) {
		return 3;
    } else {
		return 5;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == kSection0) {
		return NSLocalizedString(@"Entgelt = Frage nach der Gegen-leistung (Leistungsaustausch)\n\nGegenleistung in Form von...", nil);
    } else {
		return NSLocalizedString(@"Keine Gegenleistung", nil);
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

	if (indexPath.section == kSection0) {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Geld", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"einer Lieferung (Tausch)", nil);
				break;
			case 2:
				// Weil abweichendes Zellformat eigener CellIdentifier
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellFont140"];
				cell.textLabel.font = [UIFont systemFontOfSize:14.0];

				cell.textLabel.text = NSLocalizedString(@"einer sonstigen Leistung (Tauschähnlich)", nil);
				break;
		}
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Innenumsatz", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"echter Schadensersatz", nil);
				break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"Erbschaft", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"echte Schenkung", nil);
				break;
			case 4:
				cell.textLabel.text = NSLocalizedString(@"echte Mitgliedsbeiträge", nil);
				break;
		}

		//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end
