//
//  FAQTest.h
//  TutorMe
//
//  Created by James Seales on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQTest : UITableViewController{
    NSArray *data;
    NSArray *dataSpecial;
    NSString *answer;
    NSString *question;
}
@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) NSArray *dataSpecial;
@property (nonatomic, retain) NSString *answer;
@property (nonatomic, retain) NSString *question;


@end