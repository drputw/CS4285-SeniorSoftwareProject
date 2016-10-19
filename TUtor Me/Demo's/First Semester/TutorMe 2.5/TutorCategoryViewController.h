//
//  TutorCategoryViewController.h
//  TutorMe
//
//  Created by James Seales on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorCategoryViewController : UITableViewController {
     NSArray *data;
    NSArray *dataSpecial;
}
@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) NSArray *dataSpecial;


@end
