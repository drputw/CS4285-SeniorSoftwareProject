//
//  CategoryObject.h
//  TutorMe
//
//  Created by James Seales on 3/20/12.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryObject : NSObject{
    NSNumber *categoryID;
    NSString *category;
}

- (id) initWithName : (NSString *) newCategory
         categoryID : (NSNumber *) newID;

@property (nonatomic, retain) NSNumber *categoryID;
@property (nonatomic, retain) NSString *category;


@end
