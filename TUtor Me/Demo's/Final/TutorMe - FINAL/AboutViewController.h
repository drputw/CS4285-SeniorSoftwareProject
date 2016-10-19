//
//  AboutViewController.h
//  TutorMe
//
//  Created by James Seales on 11/1/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate>{
    IBOutlet UILabel *message;
}
@property (nonatomic, retain) IBOutlet UILabel *message;



-(IBAction)showPicker:(id)sender;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;


@end