//
//  ApplicationCellEvent.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ApplicationCellEvent : UITableViewCell
{
    BOOL useDarkBackground;
    
    UIImage *icon;
    NSString *number;
    NSString *classname;
    NSString *organizer;
    NSString *month;
    NSInteger day;
    // float rating;
    // NSInteger numRatings;
    //NSString *price;
}

@property BOOL useDarkBackground;

@property(retain) UIImage *icon;
@property(retain) NSString *number;
@property(retain) NSString *classname;
@property(retain) NSString *organizer;
@property(retain) NSString *month;
@property NSInteger day;
//@property float rating;
//@property NSInteger numRatings;
//@property(retain) NSString *price;

@end
