//
//  StudyCell.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StudyCell.h"

@implementation StudyCell

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    iconView.backgroundColor = backgroundColor;
    numberLabel.backgroundColor = backgroundColor;
    organizerLabel.backgroundColor = backgroundColor;
    classnameLabel.backgroundColor = backgroundColor;
    monthLabel.backgroundColor = backgroundColor;
    dayLabel.backgroundColor = backgroundColor;
    //ratingView.backgroundColor = backgroundColor;
    //numRatingsLabel.backgroundColor = backgroundColor;
    //priceLabel.backgroundColor = backgroundColor;
}

- (void)setIcon:(UIImage *)newIcon
{
    [super setIcon:newIcon];
    iconView.image = newIcon;
}

- (void)setNumber:(NSString *)newNumber
{
    [super setNumber:newNumber];
    numberLabel.text = newNumber;
}

- (void)setClassname:(NSString *)newClassname
{
    [super setClassname:newClassname];
    classnameLabel.text = newClassname;
}

- (void)setOrganizer:(NSString *)newOrganizer
{
    [super setOrganizer:newOrganizer];
    organizerLabel.text = newOrganizer;
}

- (void)setMonth:(NSString *)newMonth
{
    [super setMonth:newMonth];
    monthLabel.text = newMonth;
}

- (void)setDay:(NSInteger)newDay
{
    [super setDay:newDay];
    dayLabel.text = [NSString stringWithFormat:@"%d", newDay];
}
/*
 - (void)setRating:(float)newRating
 {
 [super setRating:newRating];
 ratingView.rating = newRating;
 }
 
 - (void)setNumRatings:(NSInteger)newNumRatings
 {
 [super setNumRatings:newNumRatings];
 numRatingsLabel.text = [NSString stringWithFormat:@"%d Ratings", newNumRatings];
 }
 
 
 
 
 - (void)setPrice:(NSString *)newPrice
 {
 [super setPrice:newPrice];
 priceLabel.text = newPrice;
 }
 */
- (void)dealloc
{
    [iconView release];
    [numberLabel release];
    [classnameLabel release];
    [organizerLabel release];
    [dayLabel release];
    [monthLabel release];
    //    [ratingView release];
    //    [numRatingsLabel release];
    // [priceLabel release];
    
    [super dealloc];
}

@end
