//
//  Tutor.h
//  TutorMe
//
//  Created by James Seales on 3/19/12.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tutor : NSObject{
    NSString *firstName;
    NSString *lastName;
    NSNumber *tutorID;
    NSString *email;
    NSString *phone;
    NSString *rank;
    NSString *major1;
    NSString *major2;
    NSString *major3;
    NSString *major4;
    NSString *description;
    NSString *availability;
}

- (id) initWithName : (NSString *) newFirst
            lastName: (NSString *) newLast
           tutorID : (NSNumber *) newID
            email: (NSString *) newEmail
        phoneNumber : (NSString *) newPhone
               rank: (NSString *) newRank
               major1: (NSString *) newMajor1
              major2: (NSString *) newMajor2
              major3: (NSString *) newMajor3
              major4: (NSString *) newMajor4
    description: (NSString *) newDescription
        availability: (NSString *) newAvailability;

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSNumber *tutorID;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *rank;
@property (nonatomic, retain) NSString *major1;
@property (nonatomic, retain) NSString *major2;
@property (nonatomic, retain) NSString *major3;
@property (nonatomic, retain) NSString *major4;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *availability;

@end
