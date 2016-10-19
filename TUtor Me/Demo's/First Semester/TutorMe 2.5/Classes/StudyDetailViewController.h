//
//  StudyDetailViewController.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface StudyDetailViewController : UIViewController <UIScrollViewDelegate, MFMailComposeViewControllerDelegate>{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *message;
}

@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *message;

-(IBAction)showPicker:(id)sender;
-(void)displayComposerSheet;

@end
