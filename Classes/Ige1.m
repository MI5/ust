//
//  Einfuhr1.m
//  USt
//
//  Created by Matthias Blanquett on 26.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Ige1.h"
#import "Ige10.h"
#import "Ige11.h"
#import "Ige12.h"

@implementation Ige1


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Steuerbarkeit", nil);

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self.tableView reloadData];

	// Um zu markieren, dass die Lösung angezeigt werden kann
	[[Data instance] setSteuerbarNach2:@"!"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:self.getCellStyle reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	switch ([indexPath indexAtPosition:1]) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"i. g. E. gegen Entgelt", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 1a Abs. 1 UStG", nil);
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"i. g. Verbringen (Fiktiver Erw.)", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 1a Abs. 2 UStG", nil);
			break;
		case 2:
			cell.textLabel.text = NSLocalizedString(@"i. g. E. neuer KFZ", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 1b UStG", nil);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewController *detailViewController = nil;
	switch ([indexPath indexAtPosition:1]) {
		case 0:
			detailViewController = [[Ige10 alloc] initWithNibName:@"Ige10" bundle:nil];
			break;
		case 1:
			detailViewController = [[Ige11 alloc] initWithNibName:@"Ige11" bundle:nil];
			break;
		case 2:
			detailViewController = [[Ige12 alloc] initWithNibName:@"Ige12" bundle:nil];
			break;
	}

	[self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

@end
