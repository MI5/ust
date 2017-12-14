#import "Einfuhr.h"
#import "Stufe20.h"
#import "EinfuhrBMG.h"
#import "EinfuhrFrei.h"
#import "StufeSteuersatz.h"
#import "EinfuhrEntstehung.h"
#import "EinfuhrSchuldner.h"
#import "EinfuhrRechnung.h"
#import "EinfuhrVorSt.h"
#import "Einfuhr1.h"
#import "VorStBerichtigung.h"



@implementation Einfuhr

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.title = NSLocalizedString(@"Prüfschema EUSt", nil);
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self.tableView reloadData];

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
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 1 Abs. 1 Nr. 4 UStG", nil);
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"Steuerbefreiung?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 5 UStG", nil);
			break;
		case 2:
			cell.textLabel.text = NSLocalizedString(@"Bemessungsgrundlage?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 11 UStG", nil);
			break;
		case 3:
			cell.textLabel.text = NSLocalizedString(@"Steuersatz?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 12 UStG", nil);
			break;
		case 4:
			cell.textLabel.text = NSLocalizedString(@"Entstehung der Steuer?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"Artikel 201 Abs. 1 Buchstabe a ZK", nil);
			break;
		case 5:
			cell.textLabel.text = NSLocalizedString(@"Steuerschuldnerschaft?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"Artikel 201 Abs. 3 ZK", nil);
			break;
		case 6:
			cell.textLabel.text = NSLocalizedString(@"Rechnungsstellung?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"UStAE 15.11 Abs. 1 Satz 2 Nr. 2", nil);
			break;
		case 7:
			cell.textLabel.text = NSLocalizedString(@"Vorsteuer?", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 Abs. 1 Nr. 2 UStG", nil);
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
			nextStep = [[Einfuhr1 alloc] initWithNibName:@"Einfuhr1" bundle:nil];
			break;
		case 1:
			nextStep = [[EinfuhrFrei alloc] initWithNibName:@"EinfuhrFrei" bundle:nil];
			break;
		case 2:
			nextStep = [[EinfuhrBMG alloc] initWithNibName:@"EinfuhrBMG" bundle:nil];
			break;
		case 3:
			nextStep = [[StufeSteuersatz alloc] initWithNibName:@"StufeSteuersatz" bundle:nil];
			break;
		case 4:
			nextStep = [[EinfuhrEntstehung alloc] initWithNibName:@"EinfuhrEntstehung" bundle:nil];
			break;
		case 5:
			nextStep = [[EinfuhrSchuldner alloc] initWithNibName:@"EinfuhrSchuldner" bundle:nil];
			break;
		case 6:
			nextStep = [[EinfuhrRechnung alloc] initWithNibName:@"EinfuhrRechnung" bundle:nil];
			break;
		case 7:
			nextStep = [[EinfuhrVorSt alloc] initWithNibName:@"EinfuhrVorSt" bundle:nil];
			break;
		case 8:
			nextStep = [[VorStBerichtigung alloc] initWithNibName:@"VorStBerichtigung" bundle:nil];
			break;
	}

	NSAssert(nextStep != nil,@"Switch-Case übergangen!");

	[self.navigationController pushViewController:nextStep animated:YES];
}


@end
