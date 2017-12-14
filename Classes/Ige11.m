//
//  Einfuhr1.m
//  USt
//
//  Created by Matthias Blanquett on 26.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Ige11.h"
#import "StufeLS.h"
#import "Stufe32.h"

@implementation Ige11


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"i.g. Verbringen", nil);

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[[Data instance] setShow3dSatz2:FALSE];
	[[Data instance] setBmgTyp:verbringenBMG];

	[self.tableView reloadData];

	// Immer in viewWillAppear, sonst wird typeOfNextButton in der Kategorie evtl. überschrieben
	[self addNextButton:@"Ort"];
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
    return 6;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    cell.accessoryType = UITableViewCellAccessoryCheckmark;

	switch ([indexPath indexAtPosition:1]) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Nicht nur vorübergehendes...", nil);
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"...verbringen eines Gegenstandes...", nil);
			break;
		case 2:
			cell.textLabel.text = NSLocalizedString(@"...aus dem übrigen EU-Gebiet...", nil);
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 3:
			cell.textLabel.text = NSLocalizedString(@"...in das Inland...", nil);
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 4:
			cell.textLabel.text = NSLocalizedString(@"...durch einen Unternehmer...", nil);
			break;
		case 5:
			cell.textLabel.text = NSLocalizedString(@"...zu seiner EIGENEN Verfügung.", nil);
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

	switch ([indexPath indexAtPosition:1]) {
		case 2:
			nextStep = [[StufeLS alloc] initWithNibName:@"StufeLS" bundle:nil];
			[(StufeLS *)nextStep setOnlyShowCountrys:TRUE]; // Cast, weil sonst Compilerwarnung
			break;
		case 3:
			nextStep = [[Stufe32 alloc] initWithNibName:@"Stufe32" bundle:nil];
			[(Stufe32 *)nextStep setInlandBeiIGE:TRUE]; // Cast, weil sonst Compilerwarnung
			break;
	}

	// Pass the selected object to the new view controller.
    if (nextStep != nil) {
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
