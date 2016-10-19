//
//  TutorEditProfile.h
//  TutorMe
//
//  Created by James Seales on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorEditProfile : UIViewController<UIScrollViewDelegate>{
    IBOutlet UIScrollView *scrollView;
    
}

@property (nonatomic, retain) UIScrollView *scrollView;
-(void)editTutorDidFinish;
-(IBAction)done;

@end