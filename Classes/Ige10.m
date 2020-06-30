//
//  Einfuhr1.m
//  USt
//
//  Created by Matthias Blanquett on 26.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Ige10.h"
#import "Stufe34.h"
#import "StufeLS.h"
#import "Stufe32.h"

@implementation Ige10


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"i.g.E. g. Entgelt", nil);

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[[Data instance] setShow3dSatz2:TRUE];
	[[Data instance] setBmgTyp:unentgeltlichBMG];

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
    return 11;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIge10";

    UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];

	switch ([indexPath indexAtPosition:1]) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Erwerb eines Gegenstandes...", nil);
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"...gegen Entgelt...", nil);
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			break;
		case 2:
			cell.textLabel.text = NSLocalizedString(@"...durch einen Unternehmer...", nil);
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			break;
		case 3:
			cell.textLabel.text = NSLocalizedString(@"...der zum VorStAbzug-berechtigt ist...", nil);
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			break;
		case 4:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell11NOL0"];
            cell.textLabel.font = [UIFont systemFontOfSize:11];
            cell.textLabel.numberOfLines = 0;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
			cell.textLabel.text = NSLocalizedString(@"...der kein Halbunternehmer ist, der die Erwerbsschwelle von 12.500,- € noch nicht erreicht hat...", nil);
			break;
		case 5:
			cell.textLabel.text = NSLocalizedString(@"...für sein Unternehmen...", nil);
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			break;
		case 6:
			cell.textLabel.text = NSLocalizedString(@"...von einem Unternehmer...", nil);
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			break;
		case 7:
			cell.textLabel.text = NSLocalizedString(@"...der kein Kleinunternehmer ist...", nil);
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			break;
		case 8:
			cell.textLabel.text = NSLocalizedString(@"...im Rahmen seines Unternehmens...", nil);
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 9:
			cell.textLabel.text = NSLocalizedString(@"...aus dem übrigen EU-Gebiet...", nil);
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 10:
			cell.textLabel.text = NSLocalizedString(@"...geliefert in das Inland.", nil);
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
	UITableViewController *nextStep = nil;

	switch ([indexPath indexAtPosition:1]) {
		case 8:
			nextStep = [[Stufe34 alloc] initWithNibName:@"Stufe34" bundle:nil];
			break;
		case 9:
			nextStep = [[StufeLS alloc] initWithNibName:@"StufeLS" bundle:nil];
			[(StufeLS *)nextStep setOnlyShowCountrys:TRUE]; // Cast, weil sonst Compilerwarnung
			break;
		case 10:
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

@end
