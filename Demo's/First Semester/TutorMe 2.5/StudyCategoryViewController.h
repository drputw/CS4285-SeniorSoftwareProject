//
//  StudyCategoryViewController.h
//  TutorMe
//
//  Created by James Seales on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudyCategoryViewController : UITableViewController{
    NSArray *data;
    NSArray *dataSpecial;
}
@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) NSArray *dataSpecial;
-(IBAction)addEventHandler:(id)sender;
-(void)addEvent;



@end
