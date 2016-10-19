//
//  CalendarCell.h
//  TutorMe
//
//  Created by James Seales on 11/2/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplicationCell.h"

@interface CalendarCell : ApplicationCell
{
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *descriptionLabel;
}

@end
