//
//  AcademicCalendarEvent.m
//  TutorMe
//
//  Created by James Seales on 3/20/12.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "AcademicCalendarEvent.h"

@implementation AcademicCalendarEvent

@synthesize month, startDay, endDay, description, eventID;

- (id) initWithName : (NSString *) newMonth
            startDay: (NSString *) newStart
             endDay : (NSString *) newEnd
         description: (NSString *) newDescription
             eventID: (NSNumber *) newID{
    self = [super init];
    if(self != nil) {
        self.month = newMonth;
        self.startDay = newStart;
        self.endDay = newEnd;
        self.description = newDescription;
        self.eventID = newID;
    }
    return self;
    
}

-(void) dealloc {
    self.month = nil;
    self.startDay = nil;
    self.endDay = nil;
    self.description = nil;
    self.eventID = nil;
    [super dealloc];
}

@end
