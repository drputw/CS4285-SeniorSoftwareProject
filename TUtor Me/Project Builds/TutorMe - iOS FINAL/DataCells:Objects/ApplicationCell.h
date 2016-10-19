//
//  ApplicationCell.h
//  TutorMe
//
//  Created by James Seales on 11/2/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ApplicationCell : UITableViewCell
{
    BOOL useDarkBackground;

    UIImage *icon;
    NSString *topText;
    NSString *bottomText;
    NSString *title;
    NSString *month;
    NSString *day;
}

@property BOOL useDarkBackground;

@property(retain) UIImage *icon;
@property(retain) NSString *topText;
@property(retain) NSString *title;
@property(retain) NSString *bottomText;
@property(retain) NSString *month;
@property(retain) NSString *day;

@end
