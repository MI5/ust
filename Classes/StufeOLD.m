//
//  Stufe2.m
//  USt
//
//  Created by Matthias Blanquett on 13.04.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StufeOLD.h"

static const NSInteger kTextFeldSection		= 0;
static const NSInteger kInhaltFeldSection	= 1;
static const NSInteger kCommandSection		= 2;

static const NSUInteger kTitelRow = 0;
static const NSUInteger kAutorRow = 1;
static const NSUInteger kDatumRow = 2;


@implementation StufeOLD

@synthesize artikel;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Details", nil);

	dateFormatter = [NSDateFormatter new];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
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

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger rowCount = 0;
	if (section == kTextFeldSection)
		rowCount = 3;
	else if (section == kInhaltFeldSection)
		rowCount = 1;
	else if (section == kCommandSection)
		rowCount = 1;

    return rowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return (indexPath.section == kInhaltFeldSection && indexPath.row == 0) ? 100.0 : 44.0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil; // = [tableView dequeueReusableCellWithIdentifier:TextCellIdentifier];

	if (indexPath.section == kTextFeldSection) {
		static NSString *TextCellIdentifier = @"TextCell";

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:TextCellIdentifier];

		if (indexPath.row == kTitelRow) {
			cell.textLabel.text = NSLocalizedString(@"Titel", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"Test", nil);
		} else if (indexPath.row == kAutorRow) {
			cell.textLabel.text = NSLocalizedString(@"Autor", nil);
			cell.detailTextLabel.text = [artikel valueForKey:@"autor"];
		} else if (indexPath.row == kDatumRow) {
			cell.textLabel.text = NSLocalizedString(@"Datum", nil);
			cell.detailTextLabel.text = [dateFormatter stringFromDate:[artikel valueForKey:@"datum"]];
		}

		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	} else if (indexPath.section == kInhaltFeldSection) {
		static NSString *InhaltCellIdentifier = @"InhaltCellIdent";

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InhaltCellIdentifier];
        CGRect frame = cell.contentView.bounds;
        cell.textLabel.frame = frame;

		cell.textLabel.font = [UIFont systemFontOfSize:12.0];
		// oder
		cell.textLabel.font = [UIFont boldSystemFontOfSize:12.0];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.text = [artikel valueForKey:@"inhalt"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else { // if (indexPath.section == kCommandSection)
		static NSString *CommandCellIdentifier = @"CommandCell";

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommandCellIdentifier];

		cell.textLabel.text = NSLocalizedString(@"Artikel veröffentlichen", nil);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
	}

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
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



@end
