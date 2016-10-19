//
//  TutorMeAppDelegate.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "Tutor.h"
#import "AcademicCalendarEvent.h"
#import "CategoryObject.h"
#import "Study.h"

@interface TutorMeAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    UITabBarController *tabBarController;
    //UIViewController *viewController;
    NSMutableArray *majors;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
//@property (nonatomic, retain) IBOutlet UIViewController *viewController;
@property (nonatomic, retain) NSArray *majors;

@property (nonatomic, retain) Tutor *tutor;
@property (nonatomic, retain) AcademicCalendarEvent *academicCalendarEvent;
@property (nonatomic, retain) CategoryObject *category;
@property (nonatomic, retain) Study *study;


@end

