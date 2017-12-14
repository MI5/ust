//
//  Stufe2.h
//  USt
//
//  Created by Matthias Blanquett on 13.04.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//



// this class is not in use, may be deleted

#import <UIKit/UIKit.h>


@interface StufeOLD : UITableViewController
{
	NSManagedObject *artikel;
	NSDateFormatter *dateFormatter;
}
@property (nonatomic, strong) NSManagedObject *artikel;

@end
