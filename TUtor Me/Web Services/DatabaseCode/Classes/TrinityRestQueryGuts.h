//
//  TrinityRestQueryGuts.h
//  MovieTable
//
//  Created by Mark Robinson on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#define TrinityRestQueryType_UNKNOWN 0;
#define TrinityRestQueryType_INSERT 1;
#define TrinityRestQueryType_SELECT 2;
#define TrinityRestQueryType_UPDATE 3;
#define TrinityRestQueryType_DELETE 4;

#define TrinityRestQueryState_INIT 0;
#define TrinityRestQueryState_RUNNING 10;
#define TrinityRestQueryState_RUNNING_200 20;
#define TrinityRestQueryState_PARSE_RUNNING 50;
#define TrinityRestQueryState_BADSTART_NOQUERY 97;
#define TrinityRestQueryState_BADSTART_NOTEAM 98;
#define TrinityRestQueryState_ERROR 99;
#define TrinityRestQueryState_PARSE_FINISH 100;

#import <Foundation/Foundation.h>

@interface TrinityRestQueryGuts : NSObject <NSXMLParserDelegate> {
	int queryType; //0 = init, 1-4 see above
	int queryState; //0 = init, 99 = error
	int teamNumber; //default to team 0
	
	NSString *queryText; //sql for the query
	NSString *argText; //pipe-separated string of args; nil if none
	
	int selectFieldCount; //for allocating the dictionary (a dict is all fields for 1 row)
	int selectRowCount; //# rows to be returned from select query
	int selectRowsFetched;
	
	int parseState; //0 = init, 1 = start ok result, 2 = start row result, 99 = error
	int responseMaxLength;
	bool hasRunBefore; //so we know whether to release NSURLConnection and Request before alloc
	NSString *currentElementName;
	NSMutableString *currentText;
	NSMutableData *responseData;
	NSMutableDictionary *currentDict;
	NSSet *errorTags, *okTags;
	NSURLRequest *request;
	NSURLConnection *connection;
	NSMutableArray *resultArray;
	
	NSInvocation *callback;
	NSInvocation *progressMeterCallback;
	NSInvocation *showTimeoutCallback;
	
	float progress;
	bool showLoadingView;
	
	int debugMode;
}
@property int queryType;
@property int queryState;
@property int teamNumber;
@property float progress;
@property int parseState;
@property int debugMode;

- (id) initVars;
- (void) finishQuery;
- (void) startQuery;
- (NSMutableArray *) getResultArray;
- (int) getNumSelectRows;
- (int) getNumSelectFields;
- (int) getNumSelectRowsFetched;
- (void) cancelConnection;
- (int) getResponseMaxLength;
- (int) getResponseCurrentLength;
- (void) setCallback:(id)callbackObj selector:(SEL)selector;
- (void) initViewInfo: (id)callbackObj progressMeterSelector:(SEL)pmc retryButtonSelector:(SEL)rc;
- (void) setQueryText: (NSString *) queryVal withArgs: (NSString *) argVal;
@end
