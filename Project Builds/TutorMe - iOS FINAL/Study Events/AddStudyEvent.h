//
//  AddStudyEvent.h
//  TutorMe
//
//  Created by James Seales on 11/3/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddStudyEvent : UIViewController <UIScrollViewDelegate>{
    IBOutlet UIScrollView *scrollView;
    
}

@property (nonatomic, retain) UIView *scrollView;
-(void)addEventDidFinish;
-(IBAction)done;

@end