//
//  StufeVorSt.m
//  USt
//
//  Created by Matthias Blanquett on 12.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StufeVorSt.h"


@implementation StufeVorSt


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Vorsteuer", nil);
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self.tableView reloadData];

	[self addNextButton:@"Ergebnis"];
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
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
		return 44.0*2.5;
    }

    if ([[Data instance] showLaw] && indexPath.section == 1) {
		return 44.0*1.5;
    }

	return 44.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
		return NSLocalizedString(@"Grundsatzregelung", nil);
    }

	return NSLocalizedString(@"Ausnahmen", nil);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
		return 1;
    }

    return 9;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellVorSteuer";

    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:CellIdentifier];
    cell.textLabel.numberOfLines = 0;

	switch (indexPath.section) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Unternehmer sind im Rahmen ihrer unternehmerischen Tätigkeit zum Vorsteuerabzug berechtigt.", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 Abs. 1 Satz 1 Nr. 1 UStG", nil);
			break;
		case 1:
			switch ([indexPath indexAtPosition:1]) {
			    case 0:
				    cell.textLabel.text = NSLocalizedString(@"Werbegeschenke über 35,- € je Empfänger je Jahr.", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 (1a) UStG i. V. m. § 4 (5) Nr. 1 EStG", nil);
				    break;
			    case 1:
				    // Weil abweichendes Zellformat eigener CellIdentifier
                    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:@"CellFont13NOL0"];
                    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
                    cell.textLabel.numberOfLines = 0;
				    cell.textLabel.text = NSLocalizedString(@"Unangemessene oder nicht ordnungsgemäß nachgewiesene Bewirtungsaufwendungen.", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 (1a) UStG i. V. m. § 4 (5) Nr. 2 EStG", nil);
				    break;
			    case 2:
				    cell.textLabel.text = NSLocalizedString(@"Aufwendungen für Gästehäuser.", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 (1a) UStG i. V. m. § 4 (5) Nr. 3 EStG", nil);
				    break;
			    case 3:
				    cell.textLabel.text = NSLocalizedString(@"Aufwendungen für Jagd, Fischerei und Yachten.", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 (1a) UStG i. V. m. § 4 (5) Nr. 4 EStG", nil);
				    break;
			    case 4:
				    cell.textLabel.text = NSLocalizedString(@"Unangemessene Aufwendungen.", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 (1a) UStG i. V. m. § 4 (5) Nr. 7 EStG", nil);
				    break;
			    case 5:
				    cell.textLabel.text = NSLocalizedString(@"Kosten der Lebensführung.", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 (1a) UStG i. V. m. § 12 Nr. 1 EStG", nil);
				    break;
			    case 6:
				    cell.textLabel.text = NSLocalizedString(@"Bestimmte steuerfreie Umsätze (sog. Ausschlussumsätze).", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 (2) Satz 1 Nr. 1 UStG / UStAE 15.12", nil);
				    break;
			    case 7:
				    // Weil abweichendes Zellformat eigener CellIdentifier
                    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:@"CellFont13NOL0"];
                    cell.textLabel.font = [UIFont systemFontOfSize:13];
                    cell.textLabel.numberOfLines = 0;
				    cell.textLabel.text = NSLocalizedString(@"Bestimmte Umsätze im Ausland, die steuerfrei wären, wenn sie im Inland ausgeführt würden.", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 (2) Satz 1 Nr. 2 UStG / UStAE 15.12", nil);
				    break;
			    case 8:
				    // Weil abweichendes Zellformat eigener CellIdentifier
                    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:@"CellFont13NOL0"];
                    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
                    cell.textLabel.numberOfLines = 0;
				    cell.textLabel.text = NSLocalizedString(@"Kleinunternehmer haben grundsätzlich keine Berechtigung zum Vorsteuer-Abzug.", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 19 Abs. 1 Satz 4 UStG", nil);
				    break;
			}
			break;
	}

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}




@end

