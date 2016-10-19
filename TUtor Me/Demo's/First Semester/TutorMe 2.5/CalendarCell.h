//
//  CalendarCell.h
//  TutorMe
//
//  Created by James Seales on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplicationCellCalendar.h"

@interface CalendarCell : ApplicationCellCalendar
{
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *descriptionLabel;
}

@end
