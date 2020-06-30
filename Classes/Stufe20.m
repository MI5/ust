#import "Stufe20.h"
#import "Stufe20a.h"
#import "Stufe31.h"
#import "Stufe32.h"
#import "Stufe33.h"
#import "Stufe34.h"


@implementation Stufe20

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Steuerbarkeit", nil);
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
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
		return 1;
    } else {
		return 4;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
		return NSLocalizedString(@"Prüfschema wird fortgesetzt", nil);
    } else {
		return NSLocalizedString(@"Prüfschema wird nicht fortgesetzt", nil);
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:CellIdentifier];

	if (indexPath.section == 0) {
		cell.textLabel.text = NSLocalizedString(@"Leistung?", nil);
		if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3 UStG", nil);
	} else {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Unternehmer?", nil);
				if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 2 UStG", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Inland?", nil);
				if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 1 Abs. 2 UStG", nil);
				break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"Entgelt?", nil);
				if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"UStAE 1.1 bis 1.4", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Rahmen des Unternehmens?", nil);
				if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"UStAE 2.7 Abs. 2", nil);
				break;
		}
	}

	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewController *nextStep = nil;

	if (indexPath.section == 0) {
		nextStep = [[Stufe20a alloc] initWithNibName:@"Stufe20a" bundle:nil];
	} else {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				nextStep = [[Stufe31 alloc] initWithNibName:@"Stufe31" bundle:nil];
				break;
			case 1:
				nextStep = [[Stufe32 alloc] initWithNibName:@"Stufe32" bundle:nil];
				((Stufe32 *)nextStep).inlandBeiIGE = FALSE; // Cast, weil sonst Compilerwarnung
				break;
			case 2:
				nextStep = [[Stufe33 alloc] initWithNibName:@"Stufe33" bundle:nil];
				break;
			case 3:
				nextStep = [[Stufe34 alloc] initWithNibName:@"Stufe34" bundle:nil];
				break;
		}
	}

	NSAssert(nextStep != nil,@"Switch-Case übergangen!");

	[self.navigationController pushViewController:nextStep animated:YES];
}



@end
