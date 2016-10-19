//
//  Tutor.m
//  TutorMe
//
//  Created by James Seales on 3/19/12.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "Tutor.h"

@implementation Tutor

@synthesize firstName, lastName, tutorID, email, phone, rank, major1, major2, major3, major4, description, availability;

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
        availability: (NSString *) newAvailability{
    self = [super init];
    if(self != nil) {
        self.firstName = newFirst;
        self.lastName = newLast;
        self.tutorID = newID;
        self.email = newEmail;
        self.phone = newPhone;
        self.rank = newRank;
        self.major1 = newMajor1;
        self.major2 = newMajor2;
        self.major3 = newMajor3;
        self.major4 = newMajor4;
        self.description = newDescription;
        self.availability = newAvailability;
    }
    return self;

}

-(void) dealloc {
    self.firstName = nil;
    self.lastName = nil;
    self.tutorID = nil;
    self.email = nil;
    self.phone = nil;
    self.rank = nil;
    self.major1 = nil;
    self.major2 = nil;
    self.major3 = nil;
    self.major4 = nil;
    self.description = nil;
    self.availability = nil;
    [super dealloc];
}

@end
