//
//  FAQAnswers.h
//  TutorMe
//
//  Created by James Seales on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQAnswers : UIViewController{
    UILabel *ans;
    NSString *answer;
    UILabel *ques;
    NSString *question;
}

@property (nonatomic, retain) IBOutlet UILabel *ans;
@property (nonatomic, retain) NSString *answer;
@property (nonatomic, retain) IBOutlet UILabel *ques;
@property (nonatomic, retain) NSString *question;

@end
