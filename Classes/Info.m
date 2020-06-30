//
//  Info.m
//  USt
//
//  Created by Matthias Blanquett on 26.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Info.h"


@implementation Info

- (IBAction)openSafari:(id)sender {
	NSURL *url = [[ NSURL alloc ] initWithString: @"http://www.umsatzsteuerapp.de/faq.html" ];
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)openSafariWithUStG:(id)sender {
	NSURL *url = [[ NSURL alloc ] initWithString: @"http://www.umsatzsteuerapp.de/wl_ustg.html" ];
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)openSafariWithUStDV:(id)sender {
	NSURL *url = [[ NSURL alloc ] initWithString: @"http://www.umsatzsteuerapp.de/wl_ustdv.html" ];
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)openSafariWithUStAE:(id)sender {
	NSURL *url = [[ NSURL alloc ] initWithString: @"http://www.umsatzsteuerapp.de/wl_ustae.html" ];
	[[UIApplication sharedApplication] openURL:url];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = NSLocalizedString(@"Info", nil);
}

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

@end
