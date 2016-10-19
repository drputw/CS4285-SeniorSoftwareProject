//
//  CalendarViewController.h
//  TutorMe
//
//  Created by James Seales on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationCellCalendar.h"

@interface CalendarViewController : UITableViewController
{
	ApplicationCellCalendar *tmpCell;
    NSArray *data;
    NSString *dataPath;
	
	// referring to our xib-based UITableViewCell ('TutorCell')
	UINib *cellNib;
}

@property (nonatomic, retain) IBOutlet ApplicationCellCalendar *tmpCell;
@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) NSString *dataPath;

@property (nonatomic, retain) UINib *cellNib;

@end
