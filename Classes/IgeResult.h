//
//  Result.h
//  USt
//
//  Created by Matthias Blanquett on 21.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IgeResult : UIViewController <UITextViewDelegate, UIPrintInteractionControllerDelegate> {
    
	UITextView *textView;
	UIToolbar *toolbar;
	
	NSNumberFormatter *numberFormatter;
}

@property (nonatomic, strong) IBOutlet UITextView *textView;

@end