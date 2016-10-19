//
//  TutorMeAppDelegate.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TutorMeAppDelegate.h"
#import "TutorViewController.h"


@implementation TutorMeAppDelegate

@synthesize window;
//@synthesize navigationController;
@synthesize tabBarController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application
{    
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

