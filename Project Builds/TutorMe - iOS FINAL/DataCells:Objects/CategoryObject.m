//
//  CategoryObject.m
//  TutorMe
//
//  Created by James Seales on 3/20/12.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "CategoryObject.h"

@implementation CategoryObject
@synthesize categoryID, category; 

- (id) initWithName : (NSString *) newCategory
            tutorID : (NSNumber *) newID{
    self = [super init];
    if(self != nil)
        self.categoryID = newID;
        self.category = newCategory;
    return self;
    
}

-(void) dealloc {
    self.category = nil;
    self.categoryID = nil;
    [super dealloc];
}

@end
