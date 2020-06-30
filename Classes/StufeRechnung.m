//
//  StufeRechnung.m
//  USt
//
//  Created by Matthias Blanquett on 22.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StufeRechnung.h"
#import "StufeRechnung1.h"
#import "StufeRechnung2.h"
#import "StufeRechnung3.h"

@implementation StufeRechnung


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Rechnung", nil);
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self.tableView reloadData];
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
    if ([[Data instance] umsatzArt] == kIge) {
		return 2;
    }

    // Return the number of sections.
    return 3;
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	switch (indexPath.section) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Rechnung bis 250,- € brutto", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 33 UStDV", nil);
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"Rechnung größer 250,- €", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 14 Abs. 4 UStG", nil);
			break;
		case 2:
			cell.textLabel.text = NSLocalizedString(@"Fahrausweis", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 34a Abs. 1 UStDV", nil);
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
	UITableViewController *nextStep;

	switch (indexPath.section) {
		case 0:
			nextStep = [[StufeRechnung1 alloc] initWithNibName:@"StufeRechnung1" bundle:nil];
			[self.navigationController pushViewController:nextStep animated:YES];
			break;
		case 1:
			nextStep = [[StufeRechnung2 alloc] initWithNibName:@"StufeRechnung2" bundle:nil];
			[self.navigationController pushViewController:nextStep animated:YES];
			break;
		case 2:
			nextStep = [[StufeRechnung3 alloc] initWithNibName:@"StufeRechnung3" bundle:nil];
			[self.navigationController pushViewController:nextStep animated:YES];
			break;
	}
	//(indexPath.section == kSection1 && [indexPath indexAtPosition:1] == 0)
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

@end
