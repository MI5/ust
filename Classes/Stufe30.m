#import "Stufe30.h"
#import "Stufe320.h"
#import "Stufe3200.h"
#import "StartTVController.h"

static const NSInteger kSection0	= 0;
static const NSInteger kSection1	= 1;
static const NSInteger kSection2	= 2;
// static const NSInteger kSection3	= 3;

@implementation Stufe30

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Lieferung/sonstige Leistung?", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self.tableView reloadData];

	// Falls User zurückkommt diese Variable zurücksetzen. Aber nur diese, deswegen kein Aufruf von clearData
	[[Data instance] setItIs3_1a:FALSE];
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
    if ([[Data instance] entgeltlich]) {
		return 4;
    } else {
		return 2;
    }
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == kSection0) {
		if ([[Data instance] entgeltlich])
			return 2;
		else
			return 3;
    }

	if (section == kSection1) {
		if ([[Data instance] entgeltlich])
			return 1;
		else
			return 2;
    } else {
        return 1;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == kSection0) {
		if ([[Data instance] entgeltlich])
			if ([[Data instance] showLaw])
				return NSLocalizedString(@"Lieferung - § 3 Abs. 1 und Abs. 1a", nil);
			else
				return NSLocalizedString(@"Lieferung", nil);
		else
			if ([[Data instance] showLaw])
				return NSLocalizedString(@"Lieferung ohne Entgelt -\n§ 3 Abs. 1b", nil);
			else
				return NSLocalizedString(@"Lieferung ohne Entgelt", nil);
    }

	if (section == kSection1) {
		if ([[Data instance] entgeltlich])
			if ([[Data instance] showLaw])
				return NSLocalizedString(@"Sonstige Leistung - § 3 Abs. 9", nil);
			else
				return NSLocalizedString(@"Sonstige Leistung", nil);
		else
			if ([[Data instance] showLaw])
				return NSLocalizedString(@"Sonstige Leistung ohne Entgelt -\n§ 3 Abs. 9a", nil);
			else
				return NSLocalizedString(@"Sonstige Leistung ohne Entgelt", nil);
    }

	if (section == kSection2)
		if ([[Data instance] showLaw])
			return NSLocalizedString(@"Werklieferung - § 3 Abs. 4", nil);
		else
			return NSLocalizedString(@"Werklieferung", nil);
	else
		if ([[Data instance] showLaw])
			return NSLocalizedString(@"Werkleistung - § 3 Abs. 10", nil);
		else
			return NSLocalizedString(@"Werkleistung", nil);
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:@"CellFont12NOL0"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellFont12NOL0"];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    cell.textLabel.numberOfLines = 0;

	if (indexPath.section == kSection0) {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				if ([[Data instance] entgeltlich])
					cell.textLabel.text = NSLocalizedString(@"Verschaffung der Verfügungsmacht über einen Gegenstand oder" , nil);
				else
					cell.textLabel.text = NSLocalizedString(@"Entnahme von Gegenständen für private Zwecke oder", nil);
				break;
			case 1:
				if ([[Data instance] entgeltlich])
					cell.textLabel.text = NSLocalizedString(@"Verbringen eines Gegenstands aus dem Inland in das EU-Gebiet durch einen Unternehmer.", nil);
				else
					cell.textLabel.text = NSLocalizedString(@"Sachzuwendungen an das Personal für dessen privaten Bedarf oder", nil);
				break;
			case 2:
					cell.textLabel.text = NSLocalizedString(@"andere Zuwendungen (aus unternehmerischen Gründen!).", nil);
				break;
		}
	} else if (indexPath.section == kSection1) {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				if ([[Data instance] entgeltlich]) {
					cell.textLabel.text = NSLocalizedString(@"Leistung, die keine Lieferung ist, z. B. Dienst-leistung, Vermietung oder Beförderung.", nil);
				} else {
					cell.textLabel.text = NSLocalizedString(@"Nutzung von Gegenständen des Unternehmens für private Zwecke oder den privaten Bedarf des Personals oder", nil);
				}
				break;
			case 1:
				if ([[Data instance] entgeltlich]) {
					// Nicht implementiert
					cell.textLabel.text = NSLocalizedString(@"Vermittlungsleistung", nil);
				} else {
					cell.textLabel.text = NSLocalizedString(@"Erbringung einer Dienstleistung des Unternehmers für private Zwecke oder den privaten Bedarf des Personals.", nil);
				}
				break;
		}
    } else if (indexPath.section == kSection2) {
		cell.textLabel.text = NSLocalizedString(@"Herstellung eines Werkes unter Verwendung von selbst beschafften Hauptstoffen.", nil);
    } else {
		cell.textLabel.text = NSLocalizedString(@"Herstellung eines Werkes unter Verwendung von zur Verfügung gestellten Hauptstoffen.", nil);
    }

	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (![[Data instance] entgeltlich]) {
		// Für die Lösung und für die spezifischere Auswahl bei BMG
		if (indexPath.section == 0) {
			[[Data instance] setLeistungsArt:kLieferung];
			[[Data instance] setSteuerbarNach1:@"§ 3 Abs. 1b UStG"];
		} else {
			[[Data instance] setLeistungsArt:kSonstLeistung];
			[[Data instance] setSteuerbarNach1:@"§ 3 Abs. 9a UStG"];
		}

		Stufe3200 *nextStep = [[Stufe3200 alloc] initWithNibName:@"Stufe3200" bundle:nil];

		if (indexPath.section == 1 && [indexPath indexAtPosition:1] == 1)
			nextStep.typ = 33;
		else if (indexPath.section == 0 && [indexPath indexAtPosition:1] == 1)
			nextStep.typ = 31;
		else if (indexPath.section == 0 && [indexPath indexAtPosition:1] == 2)
			nextStep.typ = 32;
		else
			nextStep.typ = 30;

		[self.navigationController pushViewController:nextStep animated:YES];
	} else {
		// nur für die Lösung
		if (indexPath.section == 0)
			[[Data instance] setSteuerbarNach1:@"§ 3 Abs. 1 UStG"];
		if (indexPath.section == 1)
			[[Data instance] setSteuerbarNach1:@"§ 3 Abs. 9 UStG"];
		if (indexPath.section == 2)
			[[Data instance] setSteuerbarNach1:@"§ 3 Abs. 4 UStG (Werklieferung)"];
		if (indexPath.section == 3)
			[[Data instance] setSteuerbarNach1:@"§ 3 Abs. 10 UStG (Werkleistung)"];

		// Für die Lösung und für die Auswahl im nächsten Fenster
		if (indexPath.section == 0 || indexPath.section == 2)
			[[Data instance] setLeistungsArt:kLieferung];
		else
			[[Data instance] setLeistungsArt:kSonstLeistung];

		if (indexPath.section == 0 && [indexPath indexAtPosition:1] == 1)
			[[Data instance] setItIs3_1a:TRUE];

		Stufe320 *nextStep = [[Stufe320 alloc] initWithNibName:@"Stufe320" bundle:nil];

		[self.navigationController pushViewController:nextStep animated:YES];
	}
}



@end
