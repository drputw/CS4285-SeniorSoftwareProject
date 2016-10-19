//
//  LogicTests.m
//  MovieTable
//
//  Created by Mark Robinson on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
/*TEST_RESULT_ERROR_BAD_TEAM=1 
 TEST_RESULT_ERROR_NO_SQL=2 
 TEST_RESULT_ERROR_TIMEOUT=3 
 TEST_RESULT_ERROR_AUTH=4 
 TEST_RESULT_ERROR_SQL=5 
 TEST_RESULT_SELECT_NO_ROWS=10 
 TEST_RESULT_SELECT_SUCCESS=11 
 TEST_RESULT_INSERT_NO_ID=20 
 TEST_RESULT_INSERT_SUCCESS=21 
 TEST_RESULT_UPDATE_NO_ROWS=30 
 TEST_RESULT_UPDATE_SUCCESS=31 
 TEST_RESULT_DELETE_NO_ROWS=40 
 TEST_RESULT_DELETE_SUCCESS=41 
 TEST_RESULT_ERROR_UNKNOWN_QUERY_TYPE=500 
 TEST_RESULT_ERROR_UNKNOWN_QUERY_STATE=501
*/
#import "LogicTests.h"

@implementation LogicTests

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application
- (void) testAppDelegate {
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    //STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
	STAssertTrue(TRUE, @"");
}

- (void) queryFinish {
	queryNumRows = 0;
	switch(guts.queryState) {
		case 97:
			queryRetVal = TEST_RESULT_ERROR_NO_SQL;
			break;
		case 98:
			queryRetVal = TEST_RESULT_ERROR_BAD_TEAM;
			break;
		case 99:
			queryRetVal = TEST_RESULT_ERROR_TIMEOUT;
			break;
		case 100:
			if(guts.parseState == 99) {
				//SQL or AUTH error
				NSMutableArray *resultArray = [guts getResultArray];
				NSMutableDictionary *currentDict = [resultArray objectAtIndex:0]; //only 1 element in array for error
				NSString *tempString = [[NSString alloc] initWithFormat: @"%@", [currentDict objectForKey:@"errorcode"]];
				if([tempString isEqualToString:@"AUTH ERROR"]) {
					//[self showLoadingError: NSLocalizedString(@"Authentication Error. Retry?", nil)];
					//STFail(@"Auth Error!");
					queryRetVal = TEST_RESULT_ERROR_AUTH;
				} else {
					//this includes BAD METHOD error
					//[self showLoadingError: NSLocalizedString(@"SQL Error. Retry?", nil)];
					//STFail(@"SQL/Method error!");
					queryRetVal = TEST_RESULT_ERROR_SQL;
				}
				[tempString release];
				[currentDict release];
				[resultArray release];
				return;
			}
			
			if(guts.queryType == 1) { //INSERT
				NSMutableArray *resultArray = [guts getResultArray];
				NSMutableDictionary *currentDict = [resultArray objectAtIndex:0]; //only 1 element in array for error
				NSString *tempString = [[NSString alloc] initWithFormat: @"%@", [currentDict objectForKey:@"okcode"]];
				if([tempString isEqualToString:@"INSERTED_ID"]) {
					queryRetVal = TEST_RESULT_INSERT_SUCCESS;
				} else 
					queryRetVal = TEST_RESULT_INSERT_NO_ID;
				[tempString release];
				[currentDict release];
				[resultArray release];
				return;
			}
			
			if(guts.queryType == 2) { //SELECT
				//if(guts.parseState == 1) {
				int numRows = [guts getNumSelectRowsFetched];
				if(numRows == 0) {
					//STFail(@"No rows found!");
					queryRetVal = TEST_RESULT_SELECT_NO_ROWS;
					return;
				} else {
					queryRetVal = TEST_RESULT_SELECT_SUCCESS;
					queryNumRows = numRows;
					//STAssertTrue(TRUE, @"found rows");
				}
				return;
			} 

			if(guts.queryType == 3) { //UPDATE
				NSMutableArray *resultArray = [guts getResultArray];
				NSMutableDictionary *currentDict = [resultArray objectAtIndex:0]; //only 1 element in array for error
				NSString *tempString = [[NSString alloc] initWithFormat: @"%@", [currentDict objectForKey:@"okcode"]];
				NSString *tempString2 = [[NSString alloc] initWithFormat: @"%@", [currentDict objectForKey:@"oktext"]];
				if([tempString isEqualToString:@"UPDATED"]) {
					queryRetVal = TEST_RESULT_UPDATE_SUCCESS;
					NSLog(@"test 1 %@", tempString2);
					queryNumRows = [tempString2 intValue];
					NSLog(@"test 2 %d", queryNumRows);
				} else 
					queryRetVal = TEST_RESULT_UPDATE_NO_ROWS;
				[tempString2 release];
				[tempString release];
				[currentDict release];
				[resultArray release];
				return;
			}

			if(guts.queryType == 4) { //DELETE
				NSMutableArray *resultArray = [guts getResultArray];
				NSMutableDictionary *currentDict = [resultArray objectAtIndex:0]; //only 1 element in array for error
				NSString *tempString = [[NSString alloc] initWithFormat: @"%@", [currentDict objectForKey:@"okcode"]];
				NSString *tempString2 = [[NSString alloc] initWithFormat: @"%@", [currentDict objectForKey:@"oktext"]];
				if([tempString isEqualToString:@"DELETED"]) {
					queryRetVal = TEST_RESULT_DELETE_SUCCESS;
					NSLog(@"test 1 %@", tempString2);
					queryNumRows = [tempString2 intValue];
					NSLog(@"test 2 %d", queryNumRows);
				} else 
					queryRetVal = TEST_RESULT_DELETE_NO_ROWS;
				[tempString2 release];
				[tempString release];
				[currentDict release];
				[resultArray release];
				return;
			}
			
			//STFail(@"Unknown query type!");
			queryRetVal = TEST_RESULT_ERROR_UNKNOWN_QUERY_TYPE;
			break;
		default:
			//STFail(@"Unknown query state");
			queryRetVal = TEST_RESULT_ERROR_UNKNOWN_QUERY_STATE;
			break;
	}	
}
/*
- (void) test0000Timeout {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"SELECT * FROM test1 WHERE age_indexed = ? and testname like ?" withArgs:@"555|b%"];
	guts.debugMode = 1;
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_ERROR_TIMEOUT)
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"timeout failed: %d", queryRetVal);
}
*/
/*
- (void) test0001Auth {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"SELECT * FROM test1 WHERE age_indexed = ? and testname like ?" withArgs:@"555|b%"];
	guts.debugMode = 2;
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_ERROR_AUTH)
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"auth failed: %d", queryRetVal);
}

- (void) test0010TeamNumberFail {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"SELECT * FROM test1 WHERE age_indexed = ? and testname like ?" withArgs:@"555|b%"];
	guts.teamNumber = 0;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_ERROR_BAD_TEAM)
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testTeamNumberFail failed: %d", queryRetVal);
}

- (void) test0020NoSQL {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"" withArgs:@"555|b%"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_ERROR_NO_SQL) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testNoSQL failed: %d", queryRetVal);
}

- (void) test0030SelectNoRows {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"SELECT * FROM test1 WHERE age_indexed = ? and testname like ?" withArgs:@"555|b%"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_SELECT_NO_ROWS) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testSelectNoRows failed: %d", queryRetVal);
}

- (void) test0040Select1098Rows {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"SELECT * FROM test1 WHERE age_indexed = ? and testname like ?" withArgs:@"55|b%"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_SELECT_SUCCESS && queryNumRows == 1098) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testSelect1098Rows failed: %d", queryRetVal);
}

- (void) test0050SelectPDOError {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"SELECT * FROM test1 WHERE age_indexed = ? and testname like ?" withArgs:@""];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_ERROR_SQL) //PDO ERRORS LOOK LIKE SQL ERRORS
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testSelectPDOError failed: %d", queryRetVal);
}

- (void) test0060SelectUnusedArgs {
	//should ignore the args and succeed
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"SELECT * FROM test2" withArgs:@"55"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_SELECT_SUCCESS)
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testSelectUnusedArgs failed: %d", queryRetVal);
}
*/
- (void) test0070Insert {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"INSERT INTO test2 (testname,age,birthday,age_indexed) VALUES(?,?,?,?)" withArgs:@"Ragnar Ragnar|90|1920-12-04|90"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_INSERT_SUCCESS) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testInsert failed: %d", queryRetVal);
}
- (void) test0071InsertLongName {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"INSERT INTO test2 (testname,age,birthday,age_indexed) VALUES(?,?,?,?)" withArgs:@"Ragnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar RagnarRagnar XXXXXXX|90|1920-12-04|90"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_INSERT_SUCCESS) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testInsertLongName failed: %d", queryRetVal);
}
- (void) test0072InsertBadAge {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"INSERT INTO test2 (testname,age,birthday,age_indexed) VALUES(?,?,?,?)" withArgs:@"Ragnar Ragnar|90x|1920-12-04|90x"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_INSERT_SUCCESS) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testInsertLongName failed: %d", queryRetVal);
}
- (void) test0073InsertBadBirthday {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"INSERT INTO test2 (testname,age,birthday,age_indexed) VALUES(?,?,?,?)" withArgs:@"Ragnar Ragnar|90|XDDWDW|90"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_INSERT_SUCCESS) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testInsertLongName failed: %d", queryRetVal);
}
/*
- (void) test0080Select1Row {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"SELECT * FROM test2 WHERE age_indexed = ? and testname like ?" withArgs:@"90|Ragnar Rag%"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_SELECT_SUCCESS && queryNumRows == 1) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testSelect1Row failed: %d", queryRetVal);
}

- (void) test0090Update1Row {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"UPDATE test2 SET age = ?, age_indexed = ? WHERE age_indexed = ? and testname like ?" withArgs:@"91|91|90|Ragnar Rag%"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_UPDATE_SUCCESS && queryNumRows == 1) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testUpdate1Row failed: %d %d", queryRetVal, queryNumRows);
}


- (void) test0091SelectNoRows2 {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"SELECT * FROM test2 WHERE age_indexed = ? and testname like ?" withArgs:@"90|Ragnar Rag%"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_SELECT_NO_ROWS) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testSelectNoRows2 failed: %d", queryRetVal);
}

- (void) test0092Select1Row2 {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"SELECT * FROM test2 WHERE age_indexed = ? and testname like ?" withArgs:@"91|Ragnar Rag%"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_SELECT_SUCCESS && queryNumRows == 1) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testSelect1Row2 failed: %d", queryRetVal);
}

- (void) test0094Update0Row {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"UPDATE test2 SET age = ?, age_indexed = ? WHERE age_indexed = ? and testname like ?" withArgs:@"91|91|90|Ragnar Rag%"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_UPDATE_NO_ROWS || (queryRetVal = TEST_RESULT_UPDATE_SUCCESS && queryNumRows == 0)) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testUpdate0Row failed: %d", queryRetVal);
}

- (void) test0095Delete1Row {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"DELETE FROM test2 WHERE age_indexed = ? and testname like ?" withArgs:@"91|Ragnar Rag%"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_DELETE_SUCCESS && queryNumRows == 1) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testDelete1Row failed: %d", queryRetVal);
}

- (void) test0096Delete0Row {
	guts = [[TrinityRestQueryGuts alloc] initVars];
	[guts setQueryText:@"DELETE FROM test2 WHERE age_indexed = ? and testname like ?" withArgs:@"91|Ragnar Rag%"];
	guts.teamNumber = 5;		
	[guts setCallback:self selector:@selector(queryFinish)];
	[guts startQuery];
	while(guts.queryState < 97) 
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	if(queryRetVal == TEST_RESULT_DELETE_NO_ROWS || (queryRetVal = TEST_RESULT_DELETE_SUCCESS && queryNumRows == 0)) 
		STAssertTrue(TRUE, @"");
	else 
		STFail(@"testDelete0Row failed: %d", queryRetVal);
}
*/
#else                           // all code under test must be linked into the Unit Test bundle

- (void) testMath {
    
    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );
    
}


#endif


@end
