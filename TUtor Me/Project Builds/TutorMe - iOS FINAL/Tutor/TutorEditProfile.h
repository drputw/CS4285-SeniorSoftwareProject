//
//  TutorEditProfile.h
//  TutorMe
//
//  Created by James Seales on 11/3/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrinityRestQueryView.h"

@interface TutorEditProfile : UIViewController <UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    IBOutlet UIScrollView *scrollView;
    bool *queryRunning;
    TrinityRestQueryView *query;
    NSMutableArray *resultArray;
    NSArray *majors;
    NSString *major1;
    NSString *major2;
    NSString *major3;
    NSString *major4;
    NSString *description;
    NSString *availability;
    NSString *phone;
    IBOutlet UITextField *major1TextField;
    IBOutlet UITextField *major2TextField;
    IBOutlet UITextField *major3TextField;
    IBOutlet UITextField *major4TextField;
    IBOutlet UITextView *availabilityTextView;
    IBOutlet UITextView *descriptionTextView;
    IBOutlet UITextField *phoneTextField;
    NSString *saving;
}

- (void) startQuery;
- (void) queryFinish;
- (void) checkQueryStatus;
- (void) showOKAlert: (NSString *) title withMessage: (NSString *) msg;

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *majors;
@property (nonatomic, retain) NSString *major1;
@property (nonatomic, retain) NSString *major2;
@property (nonatomic, retain) NSString *major3;
@property (nonatomic, retain) NSString *major4;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *availability;
@property (nonatomic, retain) IBOutlet UITextField *major1TextField;
@property (nonatomic, retain) IBOutlet UITextField *major2TextField;
@property (nonatomic, retain) IBOutlet UITextField *major3TextField;
@property (nonatomic, retain) IBOutlet UITextField *major4TextField;
@property (nonatomic, retain) IBOutlet UITextView *availabilityTextView;
@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, retain) IBOutlet UITextField *phoneTextField;
@property (nonatomic, retain) NSString *saving;
@property (nonatomic, retain) NSString *phone;


@end