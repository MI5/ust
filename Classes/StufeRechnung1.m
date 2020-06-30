//
//  StufeRechnung1.m
//  USt
//
//  Created by Matthias Blanquett on 02.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StufeRechnung1.h"


@implementation StufeRechnung1


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.navigationItem.leftBarButtonItem = nil;

	// i. g. E. von KFZ
    if (([[Data instance] umsatzArt] == kIge && [[Data instance] bmgTyp] == entgeltlichBMG)) {
		self.title = NSLocalizedString(@"Rechnung", nil);
    } else {
		self.title = NSLocalizedString(@"kl. Rechnung", nil);
    }
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self.tableView reloadData];

	[self addNextButton:@"VorSt"];
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

	// i. g. E. von KFZ
    if (([[Data instance] umsatzArt] == kIge && [[Data instance] bmgTyp] == entgeltlichBMG)) {
		return 1;
    }
    return 5;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.textLabel.numberOfLines = 0;

	switch ([indexPath indexAtPosition:1]) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Name und Adresse des leistenden Unternehmers", nil);
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"Ausstellungsdatum", nil);
			break;
		case 2:
			cell.textLabel.text = NSLocalizedString(@"Menge / Umfang und Art der erbrachten Leistung", nil);
			break;
		case 3:
			cell.textLabel.text = NSLocalizedString(@"Entgelt und Steuerbetrag in einer Summe (= Bruttobetrag)", nil);
			break;
		case 4:
			cell.textLabel.text = NSLocalizedString(@"Steuersatz oder Hinweis auf Steuerbefreiung", nil);
			break;
	}

	// i. g. E. von KFZ
	if (([[Data instance] umsatzArt] == kIge && [[Data instance] bmgTyp] == entgeltlichBMG)) {
		cell.textLabel.text = NSLocalizedString(@"Kaufvertrag ausreichend (ohne Ausweis USt!)", nil);
		cell.accessoryType = UITableViewCellAccessoryNone;
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
