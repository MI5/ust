//
//  Stufe15a.h
//  USt
//
//  Created by Matthias Blanquett on 11.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Stufe15a : UIViewController <UITextFieldDelegate>
{
	IBOutlet UITextField *vorsteuer;
    IBOutlet UITextField *korrektur;
    IBOutlet UITextField *prozentsatz;
	IBOutlet UILabel *hinweis;
	IBOutlet UILabel *formel;
	IBOutlet UILabel *satz;
	IBOutlet UISwitch *schalter;

	UIDatePicker	*datePickerView;
	UIButton		*currentButton; // der aktuell ausgewählte Button

	NSDate			*date1;
	NSDate			*date2;

	float			years; // float, sonst klappt geteilt-Rechnung nicht
	float			steuersatz;
	float			prozent;

	NSNumberFormatter *numberFormatter;
}

@property (nonatomic, strong) UIDatePicker *datePickerView;
@property (nonatomic, strong) UIButton *currentButton;
@property (nonatomic, strong) NSDate *date1;
@property (nonatomic, strong) NSDate *date2;
@property float years; //No Memory management policies (only for object properties)
@property float steuersatz;
@property float prozent;

- (IBAction)changedGebaeude:(id)sender;
- (IBAction)clickedDate1:(id)sender;
- (IBAction)clickedDate2:(id)sender;

- (void)showDatePicker;
- (void)updateRechnung;
- (void)updateSteuersatz;

- (void)doneEditing:(id)sender;
@end