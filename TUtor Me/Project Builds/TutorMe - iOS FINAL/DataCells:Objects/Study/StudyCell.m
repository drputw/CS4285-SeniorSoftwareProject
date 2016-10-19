//
//  StudyCell.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "StudyCell.h"

@implementation StudyCell

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    iconView.backgroundColor = backgroundColor;
    titleLabel.backgroundColor = backgroundColor;
    organizerLabel.backgroundColor = backgroundColor;
    subjectLabel.backgroundColor = backgroundColor;
}

- (void)setIcon:(UIImage *)newIcon
{
    [super setIcon:newIcon];
    iconView.image = newIcon;
}

- (void)setTopText:(NSString *)newTop
{
    [super setTopText:newTop];
    subjectLabel.text = newTop;
}

- (void)setTitle:(NSString *)newTitle
{
    [super setTitle:newTitle];
    titleLabel.text = newTitle;
}

- (void)setBottomText:(NSString *)newBottom
{
    [super setBottomText:newBottom];
    organizerLabel.text = newBottom;
}

- (void)setMonth:(NSString *)newMonth
{
    [super setMonth:newMonth];
    monthLabel.text = newMonth;
}

- (void)setDay:(NSString *)newDay
{
    [super setDay:newDay];
    dayLabel.text = newDay;
}


- (void)dealloc
{
    [iconView release];
    [subjectLabel release];
    [titleLabel release];
    [organizerLabel release];
    [monthLabel release];
    [dayLabel release];
    
    [super dealloc];
}

@end
