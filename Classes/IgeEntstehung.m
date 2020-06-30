//
//  IgeEntstehung.m
//  USt
//
//  Created by Matthias Blanquett on 28.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "IgeEntstehung.h"


@implementation IgeEntstehung


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Entstehung", nil);

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

	[self.tableView reloadData];

	[self addNextButton:@"Steuerschuld"];
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
    if ([[Data instance] showLaw] && indexPath.section == 1) {
		return 44.0*1.25;
    }

    if ([[Data instance] showLaw] && ([[Data instance] bmgTyp] == unentgeltlichBMG || [[Data instance] bmgTyp] == verbringenBMG)) {
		return 44.0*1.25;
    }

	return 44.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0 && [[Data instance] bmgTyp] != unentgeltlichBMG && [[Data instance] bmgTyp] != verbringenBMG) {
		return NSLocalizedString(@"Erwerb neuer KFZ", nil);
    } else {
		return NSLocalizedString(@"Erwerb sonstiger Gegenstände", nil);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[Data instance] bmgTyp] == undefinedBMG) {
		return 2;
    }

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:CellIdentifier];

	if (indexPath.section == 0 && [[Data instance] bmgTyp] != unentgeltlichBMG && [[Data instance] bmgTyp] != verbringenBMG) {
		cell.textLabel.text = NSLocalizedString(@"Am Tag des Erwerbs", nil);
		if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13 Abs. 1 Nr. 7 UStG", nil);
	} else {
		// Weil abweichendes Zellformat eigener CellIdentifier
        cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:@"CellFont12NOL0"];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.numberOfLines = 0;

		cell.textLabel.text = NSLocalizedString(@"Mit Ausstellung der Rechnung, spätestens jedoch mit Ablauf des Monats, der dem Erwerb folgt.", nil);
		if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 13 Abs. 1 Nr. 6 UStG", nil);
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

@end
