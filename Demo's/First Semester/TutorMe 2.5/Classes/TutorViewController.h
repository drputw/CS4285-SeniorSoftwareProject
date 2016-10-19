//
//  TutorViewController.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationCell.h"

@interface TutorViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>
{
	ApplicationCell *tmpCell;
    NSArray *data;
    NSMutableArray	*filteredListContent;	// The content filtered as a result of a search
	
    
	// referring to our xib-based UITableViewCell ('TutorCell')
	UINib *cellNib;
}

@property (nonatomic, retain) IBOutlet ApplicationCell *tmpCell;
@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) NSMutableArray *filteredListContent;

@property (nonatomic, retain) UINib *cellNib;

@end
