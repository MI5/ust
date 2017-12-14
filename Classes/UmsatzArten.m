//
//  UmsatzArten.m
//  USt
//
//  Created by Matthias Blanquett on 22.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UmsatzArten.h"
#import "StartTVController.h"
#import "Einfuhr.h"
#import "Ige.h"
#import "Info.h"

@implementation UmsatzArten


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self.tableView reloadData];

	// Info-Button hinzufügen
	UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[infoButton addTarget:self action:@selector(showInfoView:) forControlEvents:UIControlEventTouchUpInside];
	//self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:infoButton] autorelease];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
}

- (void) showInfoView:(id)sender {
	UITableViewController *nextStep = nil;
	nextStep = (UITableViewController *)[[Info alloc] initWithNibName:@"Info" bundle:nil];
    nextStep.edgesForExtendedLayout = UIRectEdgeNone; // So view is not hidden beneath navigation bar
	[self.navigationController pushViewController:nextStep animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

	if ([[Data instance] firstTimeStart]) {
		UITableViewController *nextStep = nil;
		nextStep = [[StartTVController alloc] initWithNibName:@"StartTVController" bundle:nil];
		[self.navigationController pushViewController:nextStep animated:YES];

		[[Data instance] setFirstTimeStart:FALSE];
		//self.view.hidden = TRUE;
	}
}

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

	switch ([indexPath section]) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Lieferung / sonstige Leistung", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 1 Abs. 1 Nr. 1 UStG", nil);
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"Einfuhr", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 1 Abs. 1 Nr. 4 UStG", nil);
			break;
		case 2:
			cell.textLabel.text = NSLocalizedString(@"Innergemeinschaftl. Erwerb", nil);
			if ([[Data instance] showLaw]) cell.detailTextLabel.text = NSLocalizedString(@"§ 1 Abs. 1 Nr. 5 UStG", nil);
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
	UITableViewController *nextStep = nil;

	switch ([indexPath section]) {
		case 0:
			nextStep = [[StartTVController alloc] initWithNibName:@"StartTVController" bundle:nil];
			[[Data instance] setUmsatzArt:kLeistung];
			break;
		case 1:
			nextStep = [[Einfuhr alloc] initWithNibName:@"Einfuhr" bundle:nil];
			[[Data instance] setUmsatzArt:kEinfuhr];
			break;
		case 2:
			nextStep = [[Ige alloc] initWithNibName:@"Ige" bundle:nil];
			[[Data instance] setUmsatzArt:kIge];
			break;
	}

	[self.navigationController pushViewController:nextStep animated:YES];
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

