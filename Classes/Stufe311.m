#import "Stufe311.h"


@implementation Stufe311

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Kleinunternehmer", nil);
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
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

	switch ([indexPath indexAtPosition:1]) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Umsätze lfd. Jahr < 50.000 €", nil);
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"Umsätze altes Jahr < 17.500 €", nil);
			break;
		case 2:
			cell.textLabel.text = NSLocalizedString(@"Kein Verzicht auf Regelung", nil);
			break;
	}
	cell.accessoryType = UITableViewCellAccessoryCheckmark;	

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
