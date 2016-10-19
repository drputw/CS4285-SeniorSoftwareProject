//
//  Study.m
//  TutorMe
//
//  Created by James Seales on 3/20/12.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "Study.h"

@implementation Study

@synthesize eventID, firstName, lastName, email, phone, title, classNumber, location, startDate, endDate, description, subject, className, rsvp, month, day;

- (id) initWithName : (NSString *) newFirst
            lastName: (NSString *) newLast
            eventID : (NSString *) newID
               email: (NSString *) newEmail
               phone: (NSString *) newPhone
               title: (NSString *) newTitle
         classNumber: (NSString *) newClassNumber
           className: (NSString *) newClassName
            location: (NSString *) newLocation
           startDate: (NSString *) newStartDate
             endDate: (NSString *) newEndDate
         description: (NSString *) newDescription
             subject: (NSString *) newSubject
                rsvp: (NSString *) newRsvp
               month: (NSString *) newMonth
                 day: (NSString *) newDay{
    self = [super init];
    if(self != nil) {
        self.firstName = newFirst;
        self.lastName = newLast;
        self.eventID = newID;
        self.email = newEmail;
        self.phone = newPhone;
        self.title = newTitle;
        self.classNumber = newClassNumber;
        self.className = newClassName;
        self.location = newLocation;
        self.startDate = newStartDate;
        self.endDate = newEndDate;
        self.description = newDescription;
        self.subject = newSubject;
        self.rsvp = newRsvp;
        self.month = newMonth;
        self.day = newDay;
    }
    return self;
    
}

-(void) dealloc {
    self.firstName = nil;
    self.lastName = nil;
    self.eventID = nil;
    self.email = nil;
    self.phone = nil;
    self.title = nil;
    self.classNumber = nil;
    self.location = nil;
    self.startDate = nil;
    self.endDate = nil;
    self.description = nil;
    self.subject = nil;
    self.rsvp = nil;
    self.month = nil;
    self.day = nil;
    [super dealloc];
}

@end
