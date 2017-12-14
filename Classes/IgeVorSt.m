//
//  StufeVorSt.m
//  USt
//
//  Created by Matthias Blanquett on 12.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "IgeVorSt.h"


@implementation IgeVorSt


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
		return 44.0*1.5;
    }

    if (indexPath.section == 1 && [indexPath indexAtPosition:1] == 1) {
		return 44.0*3;
    }

    if (indexPath.section == 1 && [indexPath indexAtPosition:1] == 2) {
		return 44.0;
    }

	return 44.0*1.5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
		return NSLocalizedString(@"Grundsatzregelung", nil);
    }

	return NSLocalizedString(@"Voraussetzungen", nil);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// i. g. E. von KFZ
    if (([[Data instance] umsatzArt] == kIge && [[Data instance] bmgTyp] == entgeltlichBMG)) {
		return 1;
    }

    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
		return 1;
    }

    return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellVorSteuer";

    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:CellIdentifier];
    cell.textLabel.numberOfLines = 0;

	switch (indexPath.section) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Die USt für den i. g. E. kann als Vorsteuer abgezogen werden.", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 Abs. 1 Satz 1 Nr. 3 UStG", nil);
			break;
		case 1:
			switch ([indexPath indexAtPosition:1]) {
			    case 0:
				    cell.textLabel.text = NSLocalizedString(@"Der Gegenstand wurde für das Unternehmen bezogen.", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 15 Abs. 1 Satz 1 Nr. 3 UStG", nil);
				    break;
			    case 1:
				    cell.textLabel.text = NSLocalizedString(@"Der Gegenstand wird zur Ausführung von Umsätzen verwendet, die den Vorsteuerabzug nicht ausschließen.", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"UStAE 15.9 Abs. 1", nil);
				    break;
			    case 2:
				    cell.textLabel.text = NSLocalizedString(@"Kein Kleinunternehmer.", nil);
				    if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 19 Abs. 1 Satz 4 UStG", nil);
				    break;
			    }

            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
	}

	// i. g. E. von KFZ
	if (([[Data instance] umsatzArt] == kIge && [[Data instance] bmgTyp] == entgeltlichBMG)) {
		cell.textLabel.text = NSLocalizedString(@"Keine Berechtigung zum VorSt- Abzug für private KFZ-Erwerber.", nil);
		if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"UStAE 16.3 Abs. 1 Satz 4", nil);
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

