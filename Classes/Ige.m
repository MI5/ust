#import "Ige.h"
#import "Stufe20.h"
#import "IgeBMG.h"
#import "IgeFrei.h"
#import "StufeSteuersatz.h"
#import "IgeEntstehung.h"
#import "IgeSchuldner.h"
#import "IgeRechnung.h"
#import "IgeVorSt.h"
#import "Ige1.h"
#import "VorStBerichtigung.h"


@implementation Ige

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.title = NSLocalizedString(@"Prüfschema i.g.E.", nil);
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self.tableView reloadData];

	//[[Data instance] setBmgTyp:undefinedBMG];
	[[Data instance] clearData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 9;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";

	// Zellen aus den Cache holen oder erzeugen, wenn nicht vorhanden
	UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	switch ([indexPath indexAtPosition:1]) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Steuerbarkeit?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§§ 1a, 1b UStG", nil);
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"Steuerbefreiung?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 4b UStG", nil);
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
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13 Abs. 1 UStG", nil);
			break;
		case 5:
			cell.textLabel.text = NSLocalizedString(@"Steuerschuldnerschaft?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13a Abs. 1 Nr. 2 UStG", nil);
			break;
		case 6:
			cell.textLabel.text = NSLocalizedString(@"Rechnungsstellung?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 14 UStG", nil);
			break;
		case 7:
			cell.textLabel.text = NSLocalizedString(@"Vorsteuer?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 Abs. 1 Nr. 3 UStG", nil);
			break;
		case 8:
			cell.textLabel.text = NSLocalizedString(@"Vorsteuerberichtigung?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§§ 15a, 17 UStG", nil);
			break;
	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewController *nextStep = nil;

	switch ([indexPath indexAtPosition:1]) {
		case 0:
			nextStep = [[Ige1 alloc] initWithNibName:@"Ige1" bundle:nil];
			break;
		case 1:
			nextStep = [[IgeFrei alloc] initWithNibName:@"IgeFrei" bundle:nil];
			break;
		case 2:
			nextStep = [[IgeBMG alloc] initWithNibName:@"IgeBMG" bundle:nil];
			break;
		case 3:
			nextStep = [[StufeSteuersatz alloc] initWithNibName:@"StufeSteuersatz" bundle:nil];
			break;
		case 4:
			nextStep = [[IgeEntstehung alloc] initWithNibName:@"IgeEntstehung" bundle:nil];
			break;
		case 5:
			nextStep = [[IgeSchuldner alloc] initWithNibName:@"IgeSchuldner" bundle:nil];
			break;
		case 6:
			nextStep = [[IgeRechnung alloc] initWithNibName:@"IgeRechnung" bundle:nil];
			break;
		case 7:
			nextStep = [[IgeVorSt alloc] initWithNibName:@"IgeVorSt" bundle:nil];
			break;
		case 8:
			nextStep = [[VorStBerichtigung alloc] initWithNibName:@"VorStBerichtigung" bundle:nil];
			break;
	}
	NSAssert(nextStep != nil,@"Switch-Case übergangen!");

	[self.navigationController pushViewController:nextStep animated:YES];
}


@end
