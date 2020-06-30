#import "StufeEntstehung.h"
#import "StufeEntstehung2.h"
#import "StufeAntragIst.h"

static const NSInteger kSection0	= 0;
static const NSInteger kSection1	= 1;

@implementation StufeEntstehung

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Entstehung", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self.tableView reloadData];

	[self addNextButton:@"Steuerschuld"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[Data instance] bmgTyp] == unentgeltlichBMG || [indexPath section] == 2) {
		return 44.0*3;
    }

	return 44.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[Data instance] bmgTyp] == unentgeltlichBMG) {
		return 1;
    }

    if ([[Data instance] bmgTyp] == entgeltlichBMG) {
		return 2;
    }

	return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == kSection1) {
		return 2;
    } else {
		return 1;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[Data instance] bmgTyp] == unentgeltlichBMG || section == 2) {
		return NSLocalizedString(@"Bei unentgeltlichen Wertabgaben", nil);
    }

    if (section == kSection0) {
		return NSLocalizedString(@"Berechnung nach vereinbarten Entgelten", nil);
    } else {
		return NSLocalizedString(@"Berechnung nach vereinnahmten Entgelten", nil);
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"CellEntstehung";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.numberOfLines = 0;

	if ([[Data instance] bmgTyp] == unentgeltlichBMG || [indexPath section] == 2) {
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.text = NSLocalizedString(@"Mit Ablauf des Voranmeldungszeitraums, in dem der Gegenstand entnommen bzw. die sonstige Leistung ausgeführt wurde.", nil);
		cell.accessoryType = UITableViewCellAccessoryNone;
		return cell;
	}

	if (indexPath.section == kSection0) {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Sollbesteuerung", nil);
				break;
		}
	} else {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				cell.textLabel.text = NSLocalizedString(@"Auf Antrag:", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Istbesteuerung", nil);
				break;
		}
	}

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[Data instance] bmgTyp] == unentgeltlichBMG  || [indexPath section] == 2) {
		return;
    }

	if (indexPath.section == kSection1 && [indexPath indexAtPosition:1] == 0) {
		UITableViewController *nextStep = [[StufeAntragIst alloc] initWithNibName:@"StufeAntragIst" bundle:nil];
		[self.navigationController pushViewController:nextStep animated:YES];
	} else {
		UITableViewController *nextStep = [[StufeEntstehung2 alloc] initWithNibName:@"StufeEntstehung2" bundle:nil];

        if (indexPath.section == kSection0) {
			[[Data instance] setBesteuerung:kSollBesteuerung];
        } else {
			[[Data instance] setBesteuerung:kIstBesteuerung];
        }

		[self.navigationController pushViewController:nextStep animated:YES];
	}
}



@end
