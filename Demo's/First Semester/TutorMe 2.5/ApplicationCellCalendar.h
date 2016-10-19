//
//  ApplicationCellCalendar.h
//  TutorMe
//
//  Created by James Seales on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ApplicationCellCalendar : UITableViewCell
{
    BOOL useDarkBackground;
    
    NSString *date;
    NSString *description;
}

@property BOOL useDarkBackground;

@property(retain) NSString *date;
@property(retain) NSString *description;


@end