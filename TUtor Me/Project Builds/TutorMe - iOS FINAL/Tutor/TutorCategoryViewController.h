//
//  TutorCategoryViewController.h
//  TutorMe
//
//  Created by James Seales on 11/2/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrinityRestQueryView.h"
#import "TrinityOAuth2WSAppUser.h"

@interface TutorCategoryViewController : UITableViewController {
    
    NSMutableArray *categoryList;
    //TrinityRestQueryView *query;
	NSMutableArray *resultArray;
    NSMutableArray *combinedList;
    NSMutableArray *categoryArray;
    NSString *categorytext;
    NSString *categoryName;
    Guts2 *guts;
    TrinityOAuth2WSAppUser *authUser;
    
	NSTimer *myTimer;
	bool queryRunning;
}

- (void) showOKAlert: (NSString *) title withMessage: (NSString *) msg;
- (void) startQuery;
- (void) queryFinish;
- (void) checkQueryStatus;

@property (nonatomic, retain) NSMutableArray *categoryList;
@property (nonatomic, retain) NSMutableArray *combinedList;
@property (nonatomic, retain) NSMutableArray *categoryArray;
@property (nonatomic, retain)  NSString *categorytext;
@property (nonatomic, retain)  NSString *categoryName;
@property (nonatomic, retain)  NSString *loggingin;


@end
