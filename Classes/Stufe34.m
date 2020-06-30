#import "Stufe34.h"

static const NSInteger kSection0	= 0;
// static const NSInteger kSection1	= 1;

@implementation Stufe34

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Im Rahmen des U.?", nil);
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
    if (section == kSection0) {
		return 3;
    } else {
		return 1;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == kSection0) {
		return NSLocalizedString(@"Im Rahmen des Unternehmens", nil);
    } else {
		return NSLocalizedString(@"Nicht im Rahmen des Unternehmens", nil);
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"CellFont16bold";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

	if (indexPath.section == kSection0) {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Hauptgeschäfte", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Hilfsgeschäfte", nil);
				break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"Nebengeschäfte", nil);
				break;
		}
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Privatgeschäfte", nil);
				break;
		}
		//cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end
