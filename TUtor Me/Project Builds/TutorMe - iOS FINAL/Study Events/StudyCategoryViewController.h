//
//  StudyCategoryViewController.h
//  TutorMe
//
//  Created by James Seales on 11/3/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrinityRestQueryView.h"

@interface StudyCategoryViewController : UITableViewController{
    NSMutableArray *categoryList;
    TrinityRestQueryView *query;
	NSMutableArray *resultArray;
    NSMutableArray *combinedList;
    NSMutableArray *categoryArray;
    NSString *categorytext;
    NSString *subjectName;
    
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
@property (nonatomic, retain)  NSString *subjectName;
-(IBAction)addEventHandler:(id)sender;
-(void)addEvent;



@end
