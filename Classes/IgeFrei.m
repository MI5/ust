#import "IgeFrei.h"
#import "IgeBMG.h"

@implementation IgeFrei

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Steuerfreie i.g.E.", nil);
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
    if (section == 0) {
		return NSLocalizedString(@"Steuerpflicht", nil);
    } else {
		return NSLocalizedString(@"Steuerfrei (Auszug)", nil);
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([[Data instance] bmgTyp] == entgeltlichBMG) {
		return 1;
    }

    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
		return 1;
    } else {
		return 5;
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
				cell.textLabel.text = NSLocalizedString(@"Wertpapierumsätze", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Menschliche Organe und Blut", nil);
				break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"Muttermilch", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Erdgas, Wärme, Kälte aus Netzen", nil);
				break;
			case 4:
				cell.textLabel.text = NSLocalizedString(@"Elektrizität", nil);
				break;
		}
	}

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		UITableViewController *nextStep = [[IgeBMG alloc] initWithNibName:@"IgeBMG" bundle:nil];
		[self.navigationController pushViewController:nextStep animated:YES];
	}

	if (indexPath.section == 1 && ![[[Data instance] steuerbarNach2] isEqualToString:@"?"]) {
		NSMutableString* s = [NSMutableString stringWithCapacity:12];
        if ([[Data instance] bmgTyp] == entgeltlichBMG) {
			[s setString:@"§ 1b"]; // kann niemals erreicht werden, da § 1 b nie steuerfrei, somit eigentlich sinnlos
        }

        if ([[Data instance] bmgTyp] == unentgeltlichBMG) {
			[s setString:@"§ 1a Abs. 1"];
        }

        if ([[Data instance] bmgTyp] == verbringenBMG) {
			[s setString:@"§ 1a Abs. 2"];
        }

		[self alertSchema: [NSString stringWithFormat:@"Der Umsatz ist zwar gemäß\n§ 1 Abs. 1 Nr. 5 UStG i. V. m. %@ UStG i. V. m. § 3d Satz 1 UStG steuerbar, aber gemäß § 4b UStG nicht steuerpflichtig.",s]];
	}
}



@end
