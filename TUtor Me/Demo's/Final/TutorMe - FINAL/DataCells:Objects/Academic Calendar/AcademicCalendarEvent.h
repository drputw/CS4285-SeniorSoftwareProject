//
//  AcademicCalendarEvent.h
//  TutorMe
//
//  Created by James Seales on 3/20/12.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcademicCalendarEvent : NSObject{
    NSNumber *eventID;
    NSString *month;
    NSString *startDay;
    NSString *endDay;
    NSString *description;
    
}

- (id) initWithName : (NSString *) newMonth
            startDay: (NSString *) newStart
             endDay : (NSString *) newEnd
         description: (NSString *) newDescription
             eventID: (NSNumber *) newID;

@property (nonatomic, retain) NSString *month;
@property (nonatomic, retain) NSString *startDay;
@property (nonatomic, retain) NSString *endDay;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSNumber *eventID;
@end