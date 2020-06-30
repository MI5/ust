#import "StufeLS.h"

@implementation StufeLS

@synthesize onlyShowCountrys;

- (void)viewDidLoad {
    [super viewDidLoad];

    if (onlyShowCountrys) {
		self.title = NSLocalizedString(@"Übriges EU-Gebiet", nil);
    } else {
		self.title = NSLocalizedString(@"Lieferschwelle", nil);
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44.0;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 27;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (onlyShowCountrys) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    } else {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

	cell.textLabel.numberOfLines = 0;

	static NSString *text;
	switch ([indexPath indexAtPosition:1]) {
		case 0:
			text = NSLocalizedString(@"Belgien", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 1:
			text = NSLocalizedString(@"Bulgarien", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"70.000 BGN", nil);
			break;
		case 2:
			text = NSLocalizedString(@"Dänemark", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"280.000 DKK", nil);
			break;
		case 3:
			text = NSLocalizedString(@"Deutschland", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"100.000 €     ", nil);
			break;
		case 4:
			text = NSLocalizedString(@"Estland", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 5:
			text = NSLocalizedString(@"Finnland", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 6:
			text = NSLocalizedString(@"Frankreich", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 7:
			text = NSLocalizedString(@"Griechenland", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 8:
			text = NSLocalizedString(@"Irland", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 9:
			text = NSLocalizedString(@"Italien", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 10:
			text = NSLocalizedString(@"Lettland", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 11:
			text = NSLocalizedString(@"Litauen", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 12:
			text = NSLocalizedString(@"Luxemburg", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"100.000 €     ", nil);
			break;
		case 13:
			text = NSLocalizedString(@"Malta", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 14:
			text = NSLocalizedString(@"Niederlande", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"100.000 €     ", nil);
			break;
		case 15:
			text = NSLocalizedString(@"Österreich", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 16:
			text = NSLocalizedString(@"Polen", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"160.000 PLN", nil);
			break;
		case 17:
			text = NSLocalizedString(@"Portugal", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 18:
			text = NSLocalizedString(@"Rumänien", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"118.000 RON", nil);
			break;
		case 19:
			text = NSLocalizedString(@"Schweden", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"320.000 SEK", nil);
			break;
		case 20:
			text = NSLocalizedString(@"Slowakei", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 21:
			text = NSLocalizedString(@"Slowenien", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 22:
			text = NSLocalizedString(@"Spanien", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
		case 23:
			text = NSLocalizedString(@"Tschechien", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"1.140.000 CZK", nil);
			break;
		case 24:
			text = NSLocalizedString(@"Ungarn", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"8.800.000 HUF", nil);
			break;
		case 25:
			text = NSLocalizedString(@"UK", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"70.000 GBP", nil);
			break;
		case 26:
			text = NSLocalizedString(@"Zypern", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"35.000 €     ", nil);
			break;
	}

	cell.textLabel.text = text;
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end
