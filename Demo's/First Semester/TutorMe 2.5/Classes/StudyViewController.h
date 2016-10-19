//
//  StudyViewController.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationCellEvent.h"

@interface StudyViewController : UITableViewController
{
	ApplicationCellEvent *tmpCell;
    NSArray *data;
	
	// referring to our xib-based UITableViewCell ('TutorCell')
	UINib *cellNib;
    UIBarButtonItem *addButton;
    NSString *dataPath;
}

@property (nonatomic, retain) IBOutlet ApplicationCellEvent *tmpCell;
@property (nonatomic, retain) NSArray *data;

@property (nonatomic, retain) UINib *cellNib;
@property (nonatomic, retain) UIBarButtonItem *addButton;
@property (nonatomic, retain) NSString *dataPath;


@end

