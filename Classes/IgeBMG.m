#import "IgeBMG.h"
#import "StufeBMG2.h"


@implementation IgeBMG

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.title = NSLocalizedString(@"BMG", nil);
}

- (void)viewWillAppear:(BOOL)animated
{
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
    if ([[Data instance] bmgTyp] == undefinedBMG) {
		return 2;
    }

	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ([[Data instance] bmgTyp] == undefinedBMG) {
        if (section == 0) {
			return NSLocalizedString(@"Innergemeinschaftlicher Erwerb", nil);
        } else {
			return NSLocalizedString(@"i. g. Verbringen (Fiktiver Erwerb)", nil);
        }
	}

    if ([[Data instance] bmgTyp] == verbringenBMG) {
		return NSLocalizedString(@"i. g. Verbringen (Fiktiver Erwerb)", nil);
    } else {
		return NSLocalizedString(@"Innergemeinschaftlicher Erwerb", nil);
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	if ([indexPath section] == 0 && [[Data instance] bmgTyp] != verbringenBMG) {
		cell.textLabel.text = NSLocalizedString(@"Entgelt zzgl. Verbrauchsteuer", nil);
		if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 10 Abs. 1 Satz 4 UStG", nil);
	} else {
		cell.textLabel.text = NSLocalizedString(@"Wiederbeschaffungskosten", nil);
		if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 10 Abs. 4 Satz 1 Nr. 1 UStG", nil);
	}

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	StufeBMG2 *nextStep = [[StufeBMG2 alloc] initWithNibName:@"StufeBMG2" bundle:nil];
	nextStep.typ = 0;

    if ([indexPath section] == 0 && [[Data instance] bmgTyp] != verbringenBMG) {
		nextStep.title = NSLocalizedString(@"Entgelt + VerbrSt", nil);
    } else {
		nextStep.title = NSLocalizedString(@"Wiederb.-Kosten", nil);
    }

	[self.navigationController pushViewController:nextStep animated:YES];
}



@end
