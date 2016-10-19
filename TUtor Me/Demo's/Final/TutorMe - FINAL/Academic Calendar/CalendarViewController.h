//
//  CalendarViewController.h
//  TutorMe
//
//  Created by James Seales on 11/2/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationCell.h"

@interface CalendarViewController : UITableViewController
{
	ApplicationCell *tmpCell;
    NSArray *data;
    NSString *dataPath;
	
	// referring to our xib-based UITableViewCell ('TutorCell')
	UINib *cellNib;
}

@property (nonatomic, retain) IBOutlet ApplicationCell *tmpCell;
@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) NSString *dataPath;

@property (nonatomic, retain) UINib *cellNib;

@end
