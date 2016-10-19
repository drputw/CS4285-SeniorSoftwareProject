//
//  Study.h
//  TutorMe
//
//  Created by James Seales on 3/20/12.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Study : NSObject{
    NSString *eventID;
    NSString *firstName;
    NSString *lastName;
    NSString *email;
    NSString *phone;
    NSString *title;
    NSString *classNumber;
    NSString *className;
    NSString *location;
    NSString *startDate;
    NSString *endDate;
    NSString *description;
    NSString *subject;
    NSString *rsvp;
    NSString *month;
    NSString *day;
}

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
                 day: (NSString *) newDay;


@property (nonatomic, retain) NSString *eventID;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *classNumber;
@property (nonatomic, retain) NSString *className;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *startDate;
@property (nonatomic, retain) NSString *endDate;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *rsvp;
@property (nonatomic, retain) NSString *month;
@property (nonatomic, retain) NSString *day;

@end

