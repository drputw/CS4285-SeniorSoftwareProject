//
//  CalendarCell.m
//  TutorMe
//
//  Created by James Seales on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    dateLabel.backgroundColor = backgroundColor;
    descriptionLabel.backgroundColor = backgroundColor;
}

- (void)setDate:(NSString *)newDate
{
    [super setDate:newDate];
    dateLabel.text = newDate;
}

- (void)setDescription:(NSString *)newDescription
{
    [super setDescription:newDescription];
    descriptionLabel.text = newDescription;
}



- (void)dealloc
{
    [descriptionLabel release];
    [dateLabel release];
    
    [super dealloc];
}

@end
