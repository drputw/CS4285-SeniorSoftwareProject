//
//  StudyDetailViewController.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "TrinityRestQueryView.h"

@interface StudyDetailViewController : UIViewController <UIScrollViewDelegate, MFMailComposeViewControllerDelegate>{
    TrinityRestQueryView *query;
    NSMutableArray *studyList;
    NSMutableArray *resultArray;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *message;
    IBOutlet UILabel *organizerName;
    IBOutlet UILabel *organizerEmail;
    IBOutlet UILabel *organizerPhone;
    IBOutlet UILabel *organizerClass;
    IBOutlet UILabel *eventSubject;
    IBOutlet UILabel *eventTitle;
    IBOutlet UITextView *eventDescription;
    IBOutlet UILabel *eventLocation;
    IBOutlet UILabel *eventStartDate;
    IBOutlet UILabel *eventEndDate;
    IBOutlet UIImageView *icon;
    IBOutlet UILabel *month;
    IBOutlet UILabel *date;
    NSString *emailRecipient;
    IBOutlet UIButton *callButton;
    IBOutlet UIButton *rsvpButton;
    bool *queryRunning;
    NSString *rsvp;
    NSString *eventID;
    int rsvpCount;
    
    
}

- (void) showOKAlert: (NSString *) title withMessage: (NSString *) msg;
- (void) startQuery;
- (void) queryFinish;
- (void) checkQueryStatus;

@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, retain) NSMutableArray *studyList;
@property (nonatomic, retain) IBOutlet UILabel *message;
@property (nonatomic, retain) IBOutlet UILabel *organizerName;
@property (nonatomic, retain) IBOutlet UILabel *organizerEmail;
@property (nonatomic, retain) IBOutlet UILabel *organizerPhone;
@property (nonatomic, retain) IBOutlet UILabel *organizerClass;
@property (nonatomic, retain) IBOutlet UILabel *eventTitle;
@property (nonatomic, retain) IBOutlet UITextView *eventDescription;
@property (nonatomic, retain) IBOutlet UILabel *eventLocation;
@property (nonatomic, retain) IBOutlet UILabel *eventStartDate;
@property (nonatomic, retain) IBOutlet UILabel *eventEndDate;
@property (nonatomic, retain) IBOutlet UILabel *eventSubject;
@property (nonatomic, retain) IBOutlet UIImageView *icon;
@property (nonatomic, retain) IBOutlet UILabel *month;
@property (nonatomic, retain) IBOutlet UILabel *date;
@property (nonatomic, retain) NSString *emailRecipient;
@property (nonatomic, retain) IBOutlet UIButton *callButton;
@property (nonatomic, retain) IBOutlet UIButton *rsvpButton;
@property (nonatomic, retain) NSString *eventID;
@property (nonatomic, retain) NSString *rsvp;
@property (nonatomic) int rsvpCount;

-(IBAction)showPicker:(id)sender;
-(void)displayComposerSheet;

@end
