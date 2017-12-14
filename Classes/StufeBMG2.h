//
//  StufeBMG2.h
//  USt
//
//  Created by Matthias Blanquett on 14.06.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StufeBMG2 : UITableViewController <UITextFieldDelegate>
{
    NSInteger typ;

	UITextField	*textField;

	NSNumberFormatter *numberFormatter;
}

@property (nonatomic) NSInteger typ;
@property (nonatomic, strong, readonly) UITextField	*textField;

- (UITextField *)getTheTextField;
- (void)doneTyping:(id)sender;

@end