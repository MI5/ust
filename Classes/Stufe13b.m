//
//  Stufe13b.m
//  USt
//
//  Created by Matthias Blanquett on 29.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Stufe13b.h"


@implementation Stufe13b

@synthesize typ;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Verlagerung", nil);

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self.tableView reloadData];

	[[Data instance] setFallDes13b:TRUE];

	[self addNextButton:@"Rechnung"];
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
    if ([[Data instance] showLaw]/* && indexPath.section == 0*/) {
		return 44.0*1.5;
    }

	return 44.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (typ == 2) {
		return NSLocalizedString(@"Voraussetzung", nil);
    }

    if (section == 1) {
		return NSLocalizedString(@"Voraussetzung", nil);
    }

    if (typ == 0) {
        return NSLocalizedString(@"Verlagerung (Auszug)", nil);
    }

	return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (typ == 2) {
		return 1;
    }

    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1 || typ == 2) {
		return 1;
    }

    if (typ == 0) {
		return 5;
    } else {
		return 1;
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellStufe13b";

    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle/*UITableViewCellStyleDefault*/ reuseIdentifier:CellIdentifier];
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;

	if (typ == 2 || [indexPath section] == 1) {
		cell.textLabel.text = NSLocalizedString(@"Der leistende Unternehmer ist kein Kleinunternehmer", nil);
		if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13b Abs. 5 Satz 4 UStG", nil);
		return cell;
	}

	if (typ == 0) {
		switch ([indexPath indexAtPosition:1]) {
			case 0:
				// Weil abweichendes Zellformat eigener CellIdentifier
                cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:@"CellFont11NOL0"];
                cell.textLabel.font = [UIFont systemFontOfSize:11.0];
                cell.textLabel.numberOfLines = 0;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;

				cell.textLabel.text = NSLocalizedString(@"Werklieferungen und sonstige Leistungen eines im Ausland ansässigen Unternehmers oder", nil);
				if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13b Abs. 2 Nr. 1 UStG", nil);
				break;
			case 1:
				cell.textLabel.text = NSLocalizedString(@"Lieferungen sicherungs-übereigneter Gegenstände oder", nil);
				if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13b Abs. 2 Nr. 2 UStG", nil);
				break;
			case 2:
				cell.textLabel.text = NSLocalizedString(@"Grundstückskäufe u.ä. oder", nil);
				if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13b Abs. 2 Nr. 3 UStG", nil);
				break;
			case 3:
				cell.textLabel.text = NSLocalizedString(@"Lieferungen von Gas und Elektrizität oder", nil);
				if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13b Abs. 2 Nr. 5 UStG", nil);
				break;
			case 4:
				cell.textLabel.text = NSLocalizedString(@"Übertragung von Emissionszertifikaten", nil);
				if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13b Abs. 2 Nr. 6 UStG", nil);
				break;
		}
	} else if (typ == 1) {
		cell.textLabel.text = NSLocalizedString(@"Außer Planungs- und Überwachungsleistungen", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13b Abs. 2 Nr. 4 Satz 1 UStG", nil);
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

