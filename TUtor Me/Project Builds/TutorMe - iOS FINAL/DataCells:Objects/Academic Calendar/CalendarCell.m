//
//  CalendarCell.m
//  TutorMe
//
//  Created by James Seales on 11/2/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    dateLabel.backgroundColor = backgroundColor;
    descriptionLabel.backgroundColor = backgroundColor;
}

- (void)setTopText:(NSString *)newDate
{
    [super setTopText:newDate];
    dateLabel.text = newDate;
}

- (void)setBottomText:(NSString *)newDescription
{
    [super setBottomText:newDescription];
    descriptionLabel.text = newDescription;
}



- (void)dealloc
{
    [descriptionLabel release];
    [dateLabel release];
    
    [super dealloc];
}

@end
