//
//  StudyCell.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplicationCellEvent.h"

@interface StudyCell : ApplicationCellEvent
{
    IBOutlet UIImageView *iconView;
    IBOutlet UILabel *numberLabel;
    IBOutlet UILabel *organizerLabel;
    IBOutlet UILabel *classnameLabel;
    IBOutlet UILabel *monthLabel;
    IBOutlet UILabel *dayLabel;

}

@end
