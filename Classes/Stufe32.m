#import "Stufe32.h"
#import "Stufe320.h"

static const NSInteger kSection0	= 0;


@implementation Stufe32

@synthesize inlandBeiIGE;

- (void)viewDidLoad {
    [super viewDidLoad];

    if (inlandBeiIGE) {
		self.title = NSLocalizedString(@"Inland beim i. g. E.?", nil);
    } else {
		self.title = NSLocalizedString(@"Inland?", nil);
    }
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
		if (inlandBeiIGE)
			return 3;
		else
			return 1;
	} else {
		if (inlandBeiIGE)
			return 3;
		else
			return 5;
	}
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == kSection0) {
		if (inlandBeiIGE)
			return NSLocalizedString(@"\"Inland\" im i. g. E.-Sinne", nil);
		else
			return NSLocalizedString(@"Inland", nil);
	} else {
		return NSLocalizedString(@"Kein Inland", nil);
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
				cell.textLabel.text = NSLocalizedString(@"Gebiet der BRD außer s. u.", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Freihäfen (CUX- u. HB-haven)", nil);
				break;
			case 2:
				// Weil abweichendes Zellformat eigener CellIdentifier
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NOL0"];
                cell.textLabel.numberOfLines = 0;
				cell.textLabel.text = NSLocalizedString(@"Gewässer & Watten entlang der Hoheitsgrenze", nil);
				break;
		}
	} else {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Büsingen", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Helgoland", nil);
				break;
			case 2:
				// Weil abweichendes Zellformat eigener CellIdentifier
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NOL0"];
                cell.textLabel.numberOfLines = 0;
				cell.textLabel.text = NSLocalizedString(@"Deutsche Schiffe und deutsche Flugzeuge in keinem Zollgebiet", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Freihäfen (CUX- u. HB-haven)", nil);
				break;
			case 4:
				// Weil abweichendes Zellformat eigener CellIdentifier
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NOL0"];
                cell.textLabel.numberOfLines = 0;
				cell.textLabel.text = NSLocalizedString(@"Gewässer & Watten entlang der Hoheitsgrenze", nil);
				break;
		}

		//cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Inlandsauswahl deaktiviert, es bricht einfach zu viel an anderen Stellen und verwirrt den User evtl.
	return;

/***** added comment to avoid compiler warning
    if (inlandBeiIGE) {
		return;
    }

	if (indexPath.section == kSection0) {
		[[Data instance] setLeistungsArt:kUndefined];

		UITableViewController *nextStep = nil;

		nextStep = [[Stufe320 alloc] initWithNibName:@"Stufe320" bundle:nil];

		[self.navigationController pushViewController:nextStep animated:YES];
	}
 *****/
}



@end
