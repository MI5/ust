#import "StufeOption.h"
#import "StufeBMG.h"

@implementation StufeOption

@synthesize typ;

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Option", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self addNextButton:@"BMG"];

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
	return NSLocalizedString(@"Voraussetzungen", nil);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath indexAtPosition:1] == 2) {
		return 44.0*2;
    } else {
		return 44.0;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (typ == 0 || typ == 1 || typ == 2)
	{
		return 3;
	}

	return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"CellOption";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.textLabel.numberOfLines = 0;

	static NSString *text;
	switch ([indexPath indexAtPosition:1]) {
		case 0:
			text = NSLocalizedString(@"An einen Unternehmer", nil);
			break;
		case 1:
			text = NSLocalizedString(@"Für dessen Unternehmen", nil);
			break;
		case 2:
			if (typ == 2)
				text = NSLocalizedString(@"Notarielle Beurkundung (außer bei Zwangsversteigerung)", nil);
			else
				text = NSLocalizedString(@"Nutzung für nicht den Vorsteuerabzug ausschließende Umsätze", nil);
			break;
	}

	cell.textLabel.text = text;

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Nehmen wir wieder raus: Ein Druck auf die Zelle selber, soll uns nicht weitergführen. Es geht weiter über den oberen Button
	//UITableViewController *nextStep = nil;
	//nextStep = [[StufeBMG alloc] initWithNibName:@"StufeBMG" bundle:nil];

	//[self.navigationController pushViewController:nextStep animated:YES];
	//[nextStep release];
}



@end
