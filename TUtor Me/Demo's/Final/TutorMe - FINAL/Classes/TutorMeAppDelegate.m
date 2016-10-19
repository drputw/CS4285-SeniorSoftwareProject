//
//  TutorMeAppDelegate.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "TutorMeAppDelegate.h"
#import "TutorViewController.h"



@implementation TutorMeAppDelegate

@synthesize window, tutor, academicCalendarEvent, category, study, majors;
@synthesize tabBarController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application
{    
    [window addSubview:tabBarController.view];
    //[window addSubview:viewController.view];
    [window makeKeyAndVisible];

}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    [tabBarController release];
    [window release];
    [tutor release];
    [academicCalendarEvent release];
    [category release];
    [study release];
    [super dealloc];
}

@end

