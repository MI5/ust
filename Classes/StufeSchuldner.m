//
//  StufeSchuldner.m
//  USt
//
//  Created by Matthias Blanquett on 29.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StufeSchuldner.h"
#import "Stufe13b.h"

@implementation StufeSchuldner


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Schuldner", nil);

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self.tableView reloadData];

	[[Data instance] setFallDes13b:FALSE];

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
    if (indexPath.section == 3 && ([indexPath indexAtPosition:1] == 1 || [indexPath indexAtPosition:1] == 2)) {
		return 44.0*2;
    }

	return 44.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
		return NSLocalizedString(@"Grundsatzregelung", nil);
    }

    if (section == 1) {
        return NSLocalizedString(@"Falsche Angaben des Abnehmers bei innergemeinschaftl. Lieferung", nil);
    }

    if (section == 2) {
		return NSLocalizedString(@"Unberechtigt ausgewiesene USt", nil);
    }

	return NSLocalizedString(@"Verlagerung auf den Käufer", nil);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[Data instance] bmgTyp] == unentgeltlichBMG) {
		return 1;
    }

	return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
		return 3;
    }

	return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:CellIdentifier];

	switch (indexPath.section) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Der leistende Unternehmer", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13a Abs. 1 Nr. 1 UStG", nil);
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"Der Abnehmer", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13a Abs. 1 Nr. 3 UStG", nil);
			break;
		case 2:
			cell.textLabel.text = NSLocalizedString(@"Der Aussteller der Rechnung", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13a Abs. 1 Nr. 4 UStG", nil);
			break;
		case 3:
			switch ([indexPath indexAtPosition:1]) {
				case 0:
					cell.textLabel.text = NSLocalizedString(@"Käufer ist Unternehmer", nil);
					if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13b Abs. 5 UStG", nil);
					break;
				case 1:
					// Weil abweichendes Zellformat eigener CellIdentifier
                    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:@"NOL0"];
                    cell.textLabel.numberOfLines = 0;
					cell.textLabel.text = NSLocalizedString(@"Käufer ist \"Bauleister\", der von einem anderen \"Bauleister\" Bauleistungen bezieht", nil);
					if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13b Abs. 5 i. V. m. Abs. 2 Nr. 4 UStG", nil);
					break;
				case 2:
					// Weil abweichendes Zellformat eigener CellIdentifier
                    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:@"CellFont16NOL0"];
                    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
                    cell.textLabel.numberOfLines = 0;
					cell.textLabel.text = NSLocalizedString(@"Käufer ist \"Gebäudereiniger\", der von einem anderen \"Gebäudereiniger\" Reinigungsleistungen bezieht", nil);
					if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13b Abs. 5 i. V. m. Abs. 2 Nr. 8 UStG", nil);
					break;
			}

			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
	if (indexPath.section == 3) {
		Stufe13b *nextStep = [[Stufe13b alloc] initWithNibName:@"Stufe13b" bundle:nil];

        if ([indexPath indexAtPosition:1] == 0) {
			[nextStep setTyp:0];
        } else if ([indexPath indexAtPosition:1] == 1) {
			[nextStep setTyp:1];
        } else {
			[nextStep setTyp:2];
        }

		[self.navigationController pushViewController:nextStep animated:YES];
	}
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
