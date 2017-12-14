#import "StartTVController.h"
#import "Stufe20.h"
#import "StufeBMG.h"
#import "StufeFrei.h"
#import "StufeSteuersatz.h"
#import "StufeEntstehung.h"
#import "StufeSchuldner.h"
#import "StufeRechnung.h"
#import "StufeVorSt.h"
#import "VorStBerichtigung.h"


@implementation StartTVController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = NSLocalizedString(@"Prüfschema USt", nil);
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[self.tableView reloadData];

	[[Data instance] clearData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 9;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";

	// Zellen aus den Cache holen oder erzeugen, wenn nicht vorhanden
	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	switch ([indexPath indexAtPosition:1]) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Steuerbarkeit?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§§ 1, 2, 3 - 3f UStG", nil);
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"Steuerbefreiung?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 4 UStG", nil);
			break;
		case 2:
			cell.textLabel.text = NSLocalizedString(@"Bemessungsgrundlage?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 10 UStG", nil);
			break;
		case 3:
			cell.textLabel.text = NSLocalizedString(@"Steuersatz?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 12 UStG", nil);
			break;
		case 4:
			cell.textLabel.text = NSLocalizedString(@"Entstehung der Steuer?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13 UStG", nil);
			break;
		case 5:
			cell.textLabel.text = NSLocalizedString(@"Steuerschuldnerschaft?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§§ 13a, 13b UStG", nil);
			break;
		case 6:
			cell.textLabel.text = NSLocalizedString(@"Rechnungsstellung?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 14 UStG", nil);
			break;
		case 7:
			cell.textLabel.text = NSLocalizedString(@"Vorsteuer?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 UStG", nil);
			break;
		case 8:
			cell.textLabel.text = NSLocalizedString(@"Vorsteuerberichtigung?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§§ 15a, 17 UStG", nil);
			break;
	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewController *nextStep = nil;

	switch ([indexPath indexAtPosition:1]) {
		case 0:
			nextStep = [[Stufe20 alloc] initWithNibName:@"Stufe20" bundle:nil];
			break;
		case 1:
			nextStep = [[StufeFrei alloc] initWithNibName:@"StufeFrei" bundle:nil];
			break;
		case 2:
			nextStep = [[StufeBMG alloc] initWithNibName:@"StufeBMG" bundle:nil];
			break;
		case 3:
			nextStep = [[StufeSteuersatz alloc] initWithNibName:@"StufeSteuersatz" bundle:nil];
			break;
		case 4:
			nextStep = [[StufeEntstehung alloc] initWithNibName:@"StufeEntstehung" bundle:nil];
			break;
		case 5:
			nextStep = [[StufeSchuldner alloc] initWithNibName:@"StufeSchuldner" bundle:nil];
			break;
		case 6:
			nextStep = [[StufeRechnung alloc] initWithNibName:@"StufeRechnung" bundle:nil];
			break;
		case 7:
			nextStep = [[StufeVorSt alloc] initWithNibName:@"StufeVorSt" bundle:nil];
			break;
		case 8:
			nextStep = [[VorStBerichtigung alloc] initWithNibName:@"VorStBerichtigung" bundle:nil];
			break;
	}

	NSAssert(nextStep != nil,@"Switch-Case übergangen!");

	[self.navigationController pushViewController:nextStep animated:YES];
}


@end
