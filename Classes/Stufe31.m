#import "Stufe31.h"
#import "Stufe310.h"
#import "Stufe311.h"

static const NSInteger kSection0	= 0;
static const NSInteger kSection1	= 1;
static const NSInteger kSection2	= 2;

@implementation Stufe31

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Unternehmer?", nil);
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
    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == kSection0) {
		return 4;
    } else if (section == kSection1) {
		return 1;
    } else {
		return 2;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == kSection0) {
		return NSLocalizedString(@"Unternehmereigenschaft", nil);
    } else if (section == kSection1) {
		return NSLocalizedString(@"Unternehmereigenschaft mit KFZ", nil);
    } else {
		return NSLocalizedString(@"Keine Unternehmereigenschaft", nil);
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
				cell.textLabel.text = NSLocalizedString(@"Gewerbliche oder berufl. Tätigkeit", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Selbstständig", nil);
				break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"Nachhaltig", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Einnahmeerzielungsabsicht", nil);
				break;
		}

		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else if (indexPath.section == kSection1) {
		cell.textLabel.text = NSLocalizedString(@"KFZ-Lieferung in übrige EU", nil);
		if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 2a UStG", nil);

        cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Organschaft", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Kleinunternehmer", nil);
				break;
		}

		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == kSection2 && [indexPath indexAtPosition:1] == 0) {
		UITableViewController *nextStep = [[Stufe310 alloc] initWithNibName:@"Stufe310" bundle:nil];
		[self.navigationController pushViewController:nextStep animated:YES];
	}

	if (indexPath.section == kSection2 && [indexPath indexAtPosition:1] == 1) {
		UITableViewController *nextStep = [[Stufe311 alloc] initWithNibName:@"Stufe311" bundle:nil];
		[self.navigationController pushViewController:nextStep animated:YES];
	}
}



@end
