#import "Stufe3200.h"
#import "StufeLS.h"

@implementation Stufe3200

@synthesize typ;

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Ort", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	// Immer in viewWillAppear, sonst wird typeOfNextButton in der Kategorie evtl. überschrieben
    if (typ != 19) { // 19 = Stets nicht steuerbar, somit hier Ende
		[self addNextButton:@"Steuerbefreiung"];
    }

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
    if (indexPath.section == 1) {
		return 44.0;
    }

    if (typ == 4) {
		return 23.0*11;
    }

    return 23.0*7;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (typ == 4) {
		return 2;
	}

    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
		return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell3200";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:CellIdentifier];
    cell.textLabel.numberOfLines = 0;

	static NSString *text;
	switch (typ) {
		case 0:
			text = NSLocalizedString(@"Fiktion: Ort ist im Inland.\n\n\nStets Steuerbar.\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3 Abs. 8 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3 Abs. 8 UStG"];
			break;
		case 1:
			text = NSLocalizedString(@"Wiederverkäufer: Ort des Unternehmens-/Betriebssitz.\nEndverbraucher: Ort des tatsächlichen Verbrauchs (Zählerstandort).\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3g UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3g UStG"];
			break;
		case 2:
			text = NSLocalizedString(@"Lieferung, die der bewegten Lieferung vorausgeht: Wo die bewegte Lieferung beginnt.\nLieferung, die der bewegten Lieferung folgt: Wo die bewegte Lieferung endet.", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3 Abs. 7 Satz 2 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3 Abs. 7 Satz 2 UStG"];
			break;
		case 3:
			text = NSLocalizedString(@"Dort, wo sich der Gegenstand zum Zeitpunkt der Verschaffung der Verfügungsmacht befindet.\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3 Abs. 7 Satz 1 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3 Abs. 7 Satz 1 UStG"];
			break;
		case 4:
			text = NSLocalizedString(@"Dort, wo die Beförderung bzw. Versendung endet.\n\nVoraussetzungen:\n- Überschreiten der Liefer-\n  schwelle durch den Lieferer\n  oder Verzicht auf diese (nicht\n  bei verbrauchsteuer-\n  pflichtigen Waren).\n- Keine Lieferung neuer KFZ.", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3c UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3c UStG"];
			break;
		case 5:
			text = NSLocalizedString(@"Dort, wo die Beförderung bzw. Versendung beginnt.\n\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3 Abs. 6 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3 Abs. 6 UStG"];
			break;
		case 10:
			text = NSLocalizedString(@"Lageort des Grundstücks.\n\n\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3a Abs. 3 Nr. 1 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3a Abs. 3 Nr. 1 UStG"];
			break;
		case 11:
			text = NSLocalizedString(@"Übergabeort des Beförderungsmittels.\n\nKurzfristig: Bei Wasserfahrzeugen 90 Tage, ansonsten 30 Tage.\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3a Abs. 3 Nr. 2 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3a Abs. 3 Nr. 2 UStG"];
			break;
		case 12:
			text = NSLocalizedString(@"Ort, an dem die Veranstaltung tatsächlich stattfindet.\n\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3a Abs. 3 Nr. 5 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3a Abs. 3 Nr. 5 UStG"];
			break;
		case 13:
			text = NSLocalizedString(@"Ort der tatsächlichen Leistungserbringung.\n\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3a Abs. 3 Nr. 3b UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3a Abs. 3 Nr. 3b UStG"];
			break;
		case 14:
			text = NSLocalizedString(@"Ort des vermittelten Umsatzes.\n\n\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3a Abs. 2 (U.) / § 3a Abs. 3 Nr. 4 (Privat)", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3a Abs. 2 (Unternehmer) bzw. § 3a Abs. 3 Nr. 4 (Privat)"];
			break;
		case 15:
			text = NSLocalizedString(@"Ort der Beförderungsstrecke.\n\nBei Grenzüberschreitung evtl. Aufteilung.\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3b Abs. 1 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3b Abs. 1 UStG"];
			break;
		case 16:
			text = NSLocalizedString(@"Leistungsempfängerort.\n\n\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3a Abs. 2 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3a Abs. 2 UStG"];
			break;
		case 17:
			text = NSLocalizedString(@"Ort der tatsächlichen Leistungserbringung.\n\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3a Abs. 3 Nr. 3a UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3a Abs. 3 Nr. 3a UStG"];
			break;
		case 18:
			text = NSLocalizedString(@"Ort der tatsächlichen Leistungserbringung.\n\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3a Abs. 3 Nr. 3c UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3a Abs. 3 Nr. 3c UStG"];
			break;
		case 19:
			text = NSLocalizedString(@"Leistungsempfängerort (Drittland).\n\nStets nicht steuerbar.\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3a Abs. 4 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3a Abs. 4 UStG"];
			break;
		case 20:
			text = NSLocalizedString(@"Leistungsempfängerort.\n\n\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3a Abs. 5 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3a Abs. 5 UStG"];
			break;
		case 21:
			text = NSLocalizedString(@"Dort, wo der Unternehmer sein Unternehmen/seine Betriebsstätte betreibt (Dienstleisterort).\n\n\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3a Abs. 1 UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3a Abs. 1 UStG"];
			break;
		case 33:
			text = NSLocalizedString(@"Dort, wo der Unternehmer sein Unternehmen/seine Betriebsstätte betreibt.\nVoraussetzung:\n- Keine Aufmerksamkeiten\n", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3f UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3f UStG"];
			break;
		default: // 30, 31 und 32
			text = NSLocalizedString(@"Dort, wo der Unternehmer sein Unternehmen/seine Betriebsstätte betreibt.\nVoraussetzungen:\n- Keine Aufmerksamkeiten\n- Voller/teilweiser VorSt-Abzug", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 3f UStG", nil);
			[[Data instance] setSteuerbarNach2:@"§ 3f UStG"];
			break;
	}

	// Einfaches überschreiben des Strings
	if (indexPath.section == 1) {
		text = NSLocalizedString(@"Lieferschwelle", nil);
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"Art. 34 Mehrwertsteuer-Systemrichtlinie", nil);
	}

	cell.textLabel.text = text;
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (typ == 31) {
		[self alertWithString:@"Als Aufmerksamkeiten gelten Geschenke aus besonderem Anlass (z. B. Blumen oder ein Buch zum Geburtstag) bis brutto 60,- €\n (UStAE 1.8 Abs. 3)"];
    }

    if (typ == 32) {
		[self alertWithString:@"Als Geschenke von geringem Wert gelten solche bis netto 35,- € pro Jahr und Empfänger\n (UStAE 3.3 Abs. 10 und 11).\n\nGeschenke an Geschäftsfreunde über 35,- € netto unterliegen NICHT der Besteuerung, weil für sie der Vorsteuerabzug ausgeschlossen ist (UStAE 3.3 Abs. 12). Wenn beim Einkauf oder der Herstellung Vorsteuerabzug in Anspruch genommen wurde, ist eine Korrektur der Vorsteuer nach § 17 UStG durchzuführen (UStAE 15.6 Abs. 5)."];
    }

    if (typ == 19) {
		[self alertSchema:@"Der Umsatz ist nicht steuerbar."];
    }

	if (indexPath.section == 1) {
		StufeLS *nextStep = nil;
		nextStep = [[StufeLS alloc] initWithNibName:@"StufeLS" bundle:nil];
		nextStep.onlyShowCountrys = FALSE;

		[self.navigationController pushViewController:nextStep animated:YES];
	}
}



@end
