//
//  PhilosophyViewController.h
//  TutorMe
//
//  Created by James Seales on 10/31/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhilosophyViewController : UIViewController <UIScrollViewDelegate>{
    IBOutlet UIScrollView *scrollView;
    
}

@property (nonatomic, retain) UIView *scrollView;

@end
