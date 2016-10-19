//
//  PhilosophyViewController.h
//  TutorMe
//
//  Created by James Seales on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhilosophyViewController : UIViewController <UIScrollViewDelegate>{
    IBOutlet UIScrollView *scrollView;
    
}

@property (nonatomic, retain) UIView *scrollView;

@end
