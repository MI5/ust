#import "StufeSteuersatz.h"
#import "StufeEntstehung.h"
#import "IgeEntstehung.h"
#import "EinfuhrEntstehung.h"

static const NSInteger kSection0	= 0;
// static const NSInteger kSection1	= 1;

@implementation StufeSteuersatz

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Steuersatz", nil);
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
	// i. g. E. von KFZ oder KFZ-Umsatz
    if (([[Data instance] umsatzArt] == kIge && [[Data instance] bmgTyp] == entgeltlichBMG) || [[Data instance] kfzUmsatz]) {
		return 1;
    }

    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// i. g. E. von KFZ oder KFZ-Umsatz
    if (([[Data instance] umsatzArt] == kIge && [[Data instance] bmgTyp] == entgeltlichBMG) || [[Data instance] kfzUmsatz]) {
		return 1;
    }

    if (section == kSection0) {
		return 10;
    } else {
		return 4;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	// i. g. E. von KFZ oder KFZ-Umsatz
    if (([[Data instance] umsatzArt] == kIge && [[Data instance] bmgTyp] == entgeltlichBMG) || [[Data instance] kfzUmsatz]) {
		return NSLocalizedString(@"Allgemeiner Steuersatz - 19 %", nil);
    }

    if (section == kSection0) {
		return NSLocalizedString(@"Ermäßigter Steuersatz - 7 % (Auszug)", nil);
    } else {
		return NSLocalizedString(@"Allgemeiner Steuersatz - 19 %", nil);
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"CellFont16";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];

	// i. g. E. von KFZ oder KFZ-Umsatz
	if (([[Data instance] umsatzArt] == kIge && [[Data instance] bmgTyp] == entgeltlichBMG) || [[Data instance] kfzUmsatz]) {
		cell.textLabel.text = NSLocalizedString(@"KFZ", nil);
		return cell;
	}

	if (indexPath.section == kSection0) {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Lebensmittel", nil);
				break;
            case 1:
                cell.textLabel.text = NSLocalizedString(@"Frauenhygieneartikel", nil);
                break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"Bestimmte lebende Tiere", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Holz", nil);
				break;
			case 4:
				cell.textLabel.text = NSLocalizedString(@"Presseerzeugnisse, E-Books, E-Papers", nil);
				break;
			case 5:
				cell.textLabel.text = NSLocalizedString(@"Kunstgegenstände", nil);
				break;
            case 6:
                cell.textLabel.text = NSLocalizedString(@"Bahnfahrten im Nah- und Fernverkehr", nil);
                break;
			case 7:
				cell.textLabel.text = NSLocalizedString(@"Bus- und Taxifahrten im Nahverkehr (innerorts o. < 50 km)", nil);
				break;
			case 8:
				cell.textLabel.text = NSLocalizedString(@"Hotelübernachtungen", nil);
				break;
            case 9:
                cell.textLabel.text = NSLocalizedString(@"Abgabe von Speisen (Restaurations- / Bewirtungs- und Verpflegungsleistungen) Befristet vom 01.07.2020 - 30.06.2021", nil);
                cell.textLabel.font = [UIFont systemFontOfSize:12.0];
                break;
		}
	} else {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Luxuslebensmittel (Kaviar, Hummer, Austern, Schnecken...)", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Lebensmittel zum Verzehr an Ort und Stelle (= sonstige Leistung)", nil);
				break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"Getränke (Mineralwasser, Limo...)", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Alle sonstigen Umsätze", nil);
				break;
		}
	}

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewController *nextStep;

	if ([[Data instance] umsatzArt] == kIge) {
		nextStep = [[IgeEntstehung alloc] initWithNibName:@"IgeEntstehung" bundle:nil];
    } else if ([[Data instance] umsatzArt] == kEinfuhr) {
		nextStep = [[EinfuhrEntstehung alloc] initWithNibName:@"EinfuhrEntstehung" bundle:nil];
    } else { // if ([[Data instance] umsatzArt] == kLeistung)
		nextStep = [[StufeEntstehung alloc] initWithNibName:@"StufeEntstehung" bundle:nil];
    }

	// NSAssert(nextStep != nil,@"To-Take-At-Least-One-If-Abfrage übergangen!");

    if (indexPath.section == kSection0) {
		[[Data instance] setSteuersatz:k7Prozent];
    } else {
		[[Data instance] setSteuersatz:k19Prozent];
    }

	// i. g. E. von KFZ oder KFZ-Umsatz
    if (([[Data instance] umsatzArt] == kIge && [[Data instance] bmgTyp] == entgeltlichBMG) || [[Data instance] kfzUmsatz]) {
		[[Data instance] setSteuersatz:k19Prozent];
    }

	[self.navigationController pushViewController:nextStep animated:YES];
}

@end
