//
//  TutorDetailViewController.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface TutorDetailViewController : UIViewController <UIScrollViewDelegate, MFMailComposeViewControllerDelegate>{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *message;
    
    IBOutlet UILabel *tutorName;
    IBOutlet UITextView *tutorMajor;
    IBOutlet UILabel *tutorMajorTop;
    IBOutlet UILabel *tutorClass;
    IBOutlet UILabel *tutorEmail;
    IBOutlet UILabel *tutorPhone;
    IBOutlet UITextView *tutorDescription;
    IBOutlet UITextView *tutorAvailability;
    NSString *emailRecipient;
    IBOutlet UIImageView *iconView;
    IBOutlet UIButton *callButton;
}

@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *message;
@property (nonatomic, retain) IBOutlet UILabel *tutorName;
@property (nonatomic, retain) IBOutlet UITextView *tutorMajor;
@property (nonatomic, retain) IBOutlet UILabel *tutorMajorTop;
@property (nonatomic, retain) IBOutlet UILabel *tutorClass;
@property (nonatomic, retain) IBOutlet UILabel *tutorEmail;
@property (nonatomic, retain) IBOutlet UILabel *tutorPhone;
@property (nonatomic, retain) IBOutlet UITextView *tutorDescription;
@property (nonatomic, retain) IBOutlet UITextView *tutorAvailability;
@property (nonatomic, retain) NSString *emailRecipient;
@property (nonatomic, retain) IBOutlet UIImageView *iconView;
@property (nonatomic, retain)  IBOutlet UIButton *callButton;

-(IBAction)showPicker:(id)sender;
-(void)displayComposerSheet;

@end
