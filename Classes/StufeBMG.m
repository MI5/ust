#import "StufeBMG.h"
#import "StartTVController.h"
#import "Kfz_Controller.h"
#import "StufeBMG2.h"


@implementation StufeBMG

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"BMG", nil);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self.tableView reloadData];

	[[Data instance] setKfzUmsatz:FALSE];

	// Kleiner Hack, um bei den ausgeblendeten BMGs den korrekten Abstand herzustellen
	if ([[Data instance] bmgTyp] == unentgeltlichBMG) {
		self.tableView.showsVerticalScrollIndicator = FALSE;
		CGPoint point = self.tableView.contentOffset;
        if ([[[Data instance] steuerbarNach1] isEqualToString:@"§ 3 Abs. 9a UStG"]) {
			point.y = 50;
        } else {
			point.y = 30;
        }

		[self.tableView setContentOffset:point animated:NO];
	}
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
    return 6;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[Data instance] bmgTyp] == entgeltlichBMG && (section == 2 || section == 3 || section == 4)) {
		return 0;
    }

    if ([[Data instance] bmgTyp] == unentgeltlichBMG && (section == 0 || section == 1)) {
		return 0;
    }

    if ([[Data instance] bmgTyp] == unentgeltlichBMG && (section == 3 || section == 4) && [[[Data instance] steuerbarNach1] isEqualToString:@"§ 3 Abs. 1b UStG"]) {
		return 0;
    }

    if ([[Data instance] bmgTyp] == unentgeltlichBMG && section == 2 && [[[Data instance] steuerbarNach1] isEqualToString:@"§ 3 Abs. 9a UStG"]) {
		return 0;
    }

    if (section == 4) {
		return 1;
    }

    if (section == 5) {
		return 5;
    }

    return 2;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		if ([[Data instance] bmgTyp] == unentgeltlichBMG)
			return nil;
		else
			return NSLocalizedString(@"Entgeltliche Lieferung / sonst. L.", nil);
	} else if (section == 1) {
		if ([[Data instance] bmgTyp] == unentgeltlichBMG)
		{
			return nil;
		}
		else
		{
			if ([[Data instance] showLaw])
				return NSLocalizedString(@"Tausch / tauschähnlicher Umsatz\n§ 3 Abs. 12 UStG", nil);
			else
				return NSLocalizedString(@"Tausch / tauschähnlicher Umsatz", nil);
		}
	} else if (section == 2) {
		if ([[Data instance] bmgTyp] == entgeltlichBMG)
			return nil;
		if ([[Data instance] bmgTyp] == unentgeltlichBMG && [[[Data instance] steuerbarNach1] isEqualToString:@"§ 3 Abs. 9a UStG"])
			return nil;

		if ([[Data instance] showLaw])
			return NSLocalizedString(@"Unentgeltliche Lieferung - § 3 (1b)", nil);
		else
			return NSLocalizedString(@"Unentgeltliche Lieferung", nil);
	} else if (section == 3) {
		if ([[Data instance] bmgTyp] == entgeltlichBMG)
			return nil;
		if ([[Data instance] bmgTyp] == unentgeltlichBMG && [[[Data instance] steuerbarNach1] isEqualToString:@"§ 3 Abs. 1b UStG"])
			return nil;

		if ([[Data instance] showLaw])
			return NSLocalizedString(@"Unentgeltliche Verwendung\nvon Gegenständen - § 3 (9a) Nr.1", nil);
		else
			return NSLocalizedString(@"Unentgeltliche Verwendung\nvon Gegenständen", nil);
	} else if (section == 4) {
		if ([[Data instance] bmgTyp] == entgeltlichBMG)
			return nil;
		if ([[Data instance] bmgTyp] == unentgeltlichBMG && [[[Data instance] steuerbarNach1] isEqualToString:@"§ 3 Abs. 1b UStG"])
			return nil;

		if ([[Data instance] showLaw])
			return NSLocalizedString(@"Unentgeltliche andere sonstigen Leistungen - § 3 (9a) Nr.2", nil);
		else
			return NSLocalizedString(@"Unentgeltliche andere sonstigen Leistungen", nil);
	}

	return NSLocalizedString(@"Stets kein Bestandteil der BMG", nil);
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	switch ([indexPath section]) {
		case 0:
			if ([indexPath indexAtPosition:1] == 0)
				cell.textLabel.text = NSLocalizedString(@"Entgelt (Nettobetrag)", nil);
			else
				cell.textLabel.text = NSLocalizedString(@"Mindest-BMG", nil);
			break;
		case 1:
            if ([indexPath indexAtPosition:1] == 0) {
				cell.textLabel.text = NSLocalizedString(@"Gemeiner Wert", nil);
            } else {
				// Weil abweichendes Zellformat eigener CellIdentifier
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellFont120NOL0"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.font = [UIFont systemFontOfSize:12.0];
                cell.textLabel.numberOfLines = 0;

				cell.textLabel.text = NSLocalizedString(@"KFZ-Gestellung an Arbeitnehmer: Anteilige Kosten der Privatfahrten", nil);
			}
			break;
		case 2:
			if ([indexPath indexAtPosition:1] == 0)
				cell.textLabel.text = NSLocalizedString(@"Wiederbeschaffungskosten", nil);
			else
				cell.textLabel.text = NSLocalizedString(@"Selbstkosten", nil);
			break;
		case 3:
			// Weil abweichendes Zellformat eigener CellIdentifier
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellFont120NOL0"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.textLabel.font = [UIFont systemFontOfSize:12.0];
			cell.textLabel.numberOfLines = 0;

			if ([indexPath indexAtPosition:1] == 0)
				cell.textLabel.text = NSLocalizedString(@"Entstandene anteilige Ausgaben, soweit Vorsteuerabzug möglich war", nil);
			else
				cell.textLabel.text = NSLocalizedString(@"U. nutzt KFZ: anteilige Kosten der Privat-fahrten, für die Vorsteuerabzug möglich war", nil);
			break;
		case 4:
			// Weil abweichendes Zellformat eigener CellIdentifier
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellFont12NOL0"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
            cell.textLabel.numberOfLines = 0;

			cell.textLabel.text = NSLocalizedString(@"Entstandene anteilige Ausgaben (Vorsteuerabzug ohne Bedeutung)", nil);
			break;
		case 5:
			switch ([indexPath indexAtPosition:1]) {
				case 0:
					cell.textLabel.text = NSLocalizedString(@"Umsatzsteuer", nil);
					break;
				case 1:
					cell.textLabel.text = NSLocalizedString(@"Durchlaufende Posten", nil);
					break;
				case 2:
					cell.textLabel.text = NSLocalizedString(@"Vertragsstrafen", nil);
					break;
				case 3:
					cell.textLabel.text = NSLocalizedString(@"Verzugszinsen u.ä.", nil);
					break;
				case 4:
					cell.textLabel.text = NSLocalizedString(@"Mahnkosten u.ä.", nil);
					break;
			}
			cell.accessoryType = UITableViewCellAccessoryNone;
			break;
		case 6:
			//[[[[self navigationController] viewControllers] objectAtIndex:0] setBmgTyp:unentgeltlichBMG];
			break;
	}
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 5) {
		// Bei Klicken auf Bestandteile die keine BMG sind, soll man nicht weiterkommen
	} else if (indexPath.section == 3 && [indexPath indexAtPosition:1] == 1) {
		// Für die Lösung
		[[Data instance] setBmgNach:@"§ 10 Abs. 4 Nr. 2 UStG (anteilige Kosten der Privatfahrten, für die Vorsteuerabzug möglich war)"];

		Kfz_Controller *nextStep = [[Kfz_Controller alloc] initWithNibName:@"ViewKFZ" bundle:nil];
        nextStep.edgesForExtendedLayout = UIRectEdgeNone; // So view is not hidden beneath navigation bar
		nextStep.viewTyp = kUnternehmer;

		[self.navigationController pushViewController:nextStep animated:YES];
	} else if (indexPath.section == 1 && [indexPath indexAtPosition:1] == 1) {
		// Für die Lösung
		[[Data instance] setBmgNach:@"§ 10 Abs. 2 Satz 2 UStG (anteilige Kosten der Privatfahrten)"];

		Kfz_Controller *nextStep = [[Kfz_Controller alloc] initWithNibName:@"ViewKFZ" bundle:nil];
        nextStep.edgesForExtendedLayout = UIRectEdgeNone; // So view is not hidden beneath navigation bar
		nextStep.viewTyp = kArbeitnehmer;

		[self.navigationController pushViewController:nextStep animated:YES];
	} else if (indexPath.section == 3 || indexPath.section == 4) {
		// Für die Lösung
		if (indexPath.section == 3)
			[[Data instance] setBmgNach:@"§ 10 Abs. 4 Nr. 2 UStG (entstandene anteilige Ausgaben)"];
		else
			[[Data instance] setBmgNach:@"§ 10 Abs. 4 Nr. 3 UStG (entstandene anteilige Ausgaben)"];

		StufeBMG2 *nextStep = [[StufeBMG2 alloc] initWithNibName:@"StufeBMG2" bundle:nil];
		nextStep.typ = 4; // = Mit Anzeige der zu inkludierenden Afa
		nextStep.title = NSLocalizedString(@"Ausgaben", nil);

		[self.navigationController pushViewController:nextStep animated:YES];
	} else {
		StufeBMG2 *nextStep = [[StufeBMG2 alloc] initWithNibName:@"StufeBMG2" bundle:nil];
		nextStep.typ = 0;
		switch (indexPath.section) {
			case 0:
				if ([indexPath indexAtPosition:1] == 0) {
					nextStep.title = NSLocalizedString(@"Nettobetrag", nil);

					// Für die Lösung
					[[Data instance] setBmgNach:@"§ 10 Abs. 1 UStG"];
				} else {
					nextStep.title = NSLocalizedString(@"Mindest-BMG", nil);
					nextStep.typ = 1;

					// Für die Lösung
					[[Data instance] setBmgNach:@"§ 10 Abs. 5 UStG (Mindest-Bemessungsgrundlage)"];
				}
				break;
			case 1:
				nextStep.title = NSLocalizedString(@"Gemeiner Wert", nil);

				// Für die Lösung
				[[Data instance] setBmgNach:@"§ 10 Abs. 2 Satz 2 UStG (gemeiner Wert)"];
				break;
			case 2:
				if ([indexPath indexAtPosition:1] == 0) {
					nextStep.title = NSLocalizedString(@"Wiederb.-Kosten", nil);
					nextStep.typ = 2;

					// Für die Lösung
					[[Data instance] setBmgNach:@"§ 10 Abs. 4 Nr. 1 erster Halbsatz UStG (Wiederbeschaffungskosten)"];
				} else {
					nextStep.title = NSLocalizedString(@"Selbstkosten", nil);
					nextStep.typ = 3;

					// Für die Lösung
					[[Data instance] setBmgNach:@"§ 10 Abs. 4 Nr. 1 zweiter Halbsatz UStG (Selbstkosten)"];
				}
				break;
		}

		[self.navigationController pushViewController:nextStep animated:YES];
	}
}



@end
