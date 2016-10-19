//
//  SettingsViewController.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrinityRestQueryView.h"

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	//IBOutlet UITableView *tblSimpleTable;
	NSArray *arryTutorProfileSection;
	NSArray *arryEventsSection;
    NSArray *arryAboutSection;
    UISwitch *tutorSwitch;
    NSTimer *myTimer;
    bool *queryRunning;
    TrinityRestQueryView *query;
}
- (void) tutorSwitchChanged;
- (void) startQuery;
- (void) queryFinish;
- (void) checkQueryStatus;
- (void) showOKAlert: (NSString *) title withMessage: (NSString *) msg;

@property (nonatomic, retain) IBOutlet UISwitch *tutorSwitch;

@end