//
//  LogicTests.h
//  MovieTable
//
//  Created by Mark Robinson on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  Define USE_APPLICATION_UNIT_TEST to 0 if the unit test code is designed to be linked into an independent test executable.

#define USE_APPLICATION_UNIT_TEST 1

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
//#import "application_headers" as required
#import "TrinityRestQueryGuts.h"


@interface LogicTests : SenTestCase {
	int queryRetVal; //return value from query callback
	int queryNumRows; //# rows selected, updated, deleted
	TrinityRestQueryGuts *guts;
}

#if USE_APPLICATION_UNIT_TEST
- (void) testAppDelegate;       // simple test on application
- (void) queryFinish;
- (void) testTeamNumberFail;
- (void) testNoSQL;

#else
- (void) testMath;              // simple standalone test
#endif

@end
