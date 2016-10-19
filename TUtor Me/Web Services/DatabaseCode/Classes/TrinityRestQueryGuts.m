//
//  TrinityRestQueryGuts.m
//  MovieTable
//
//  Created by Mark Robinson on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#define ERROR_TAG_NAMES @"errorcode", @"errortext", nil
#define OK_TAG_NAMES @"okcode", @"oktext", nil

#import "TrinityRestQueryGuts.h"
#import <CommonCrypto/CommonDigest.h>

@implementation TrinityRestQueryGuts

@synthesize queryState;
@synthesize teamNumber;
@synthesize progress;
@synthesize queryType;
@synthesize parseState;
@synthesize debugMode;

NSString * md5( NSString *str ) {
	const char *cStr = [str UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	
	CC_MD5( cStr, strlen(cStr), result );
	
	return [NSString 
			stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1],
			result[2], result[3],
			result[4], result[5],
			result[6], result[7],
			result[8], result[9],
			result[10], result[11],
			result[12], result[13],
			result[14], result[15] ];
	
}

- (id) initVars {
	debugMode = 0; //0 = no debug, 1 = force timeout in finish, 2 = force auth error
	showLoadingView = FALSE;
	teamNumber = 0;
	selectFieldCount = 0;
	selectRowCount = 0;
	selectRowsFetched = 0;
	parseState = 0;
	responseMaxLength = 0;
	errorTags = [[NSSet alloc] initWithObjects: ERROR_TAG_NAMES];
	okTags = [[NSSet alloc] initWithObjects: OK_TAG_NAMES];
	hasRunBefore = FALSE;	
	queryText = nil;
	argText = nil;
	progress = 0;
	return self;
}

- (void) initViewInfo: (id)callbackObj progressMeterSelector:(SEL)pmc retryButtonSelector:(SEL)rc {
	showLoadingView = TRUE;
	NSMethodSignature *sig = [[callbackObj class] instanceMethodSignatureForSelector:pmc];
	progressMeterCallback = [NSInvocation invocationWithMethodSignature:sig];
	[progressMeterCallback setTarget:callbackObj];
	[progressMeterCallback setSelector:pmc];
	[progressMeterCallback retain];

	sig = [[callbackObj class] instanceMethodSignatureForSelector:rc];
	showTimeoutCallback = [NSInvocation invocationWithMethodSignature:sig];
	[showTimeoutCallback setTarget:callbackObj];
	[showTimeoutCallback setSelector:rc];
	[showTimeoutCallback retain];
}

- (void) setCallback:(id)callbackObj selector:(SEL)selector {
	NSMethodSignature *sig = [[callbackObj class] instanceMethodSignatureForSelector:selector];
	callback = [NSInvocation invocationWithMethodSignature:sig];
	[callback setTarget:callbackObj];
	[callback setSelector:selector];
	[callback retain];
}

- (void) setQueryText: (NSString *) queryVal withArgs: (NSString *) argVal {
	if(queryVal != nil) {
		queryText = [[NSString alloc] initWithString: queryVal];
		//try to automatically determine if it is insert,select,update,or delete
		//and set queryType
		//query.queryType = 1; //1=insert,2=select,3=update,4=delete
		NSArray *_splitItems = [queryVal componentsSeparatedByString:@" "];
		NSMutableArray *_mutableSplitItems = [NSMutableArray arrayWithCapacity:[_splitItems count]]; 
		[_mutableSplitItems addObjectsFromArray:_splitItems];
		NSString *phrase1 = [(NSString *) [_mutableSplitItems objectAtIndex:0] uppercaseString];
		if([phrase1 isEqualToString:@"INSERT"])
			queryType = 1;
		else if([phrase1 isEqualToString:@"SELECT"])
			queryType = 2;
		else if([phrase1 isEqualToString:@"UPDATE"])
			queryType = 3;
		else if([phrase1 isEqualToString:@"DELETE"])
			queryType = 4;
	}
	if(argVal != nil)
		argText = [[NSString alloc] initWithString: argVal];
	else 
		argText = [NSString stringWithFormat:@""];
}

- (void) finishQuery {
	[callback invoke];
	return;
}

- (void) startQuery {
	//[target performSelector:returnFromQuery];
	if(teamNumber == 0) {
		queryState = TrinityRestQueryState_BADSTART_NOTEAM;
		[self finishQuery];
		return;
	}
	if(queryText == nil || [queryText length] == 0) {
		queryState = TrinityRestQueryState_BADSTART_NOQUERY;
		[self finishQuery];
		return;
	}
	//assemble the URL and send it off
	NSMutableString *argsCleaned = [[NSMutableString alloc] initWithString: @""];
	for (int i=0; i<[argText length]; i++) {
		//        if (isdigit([args characterAtIndex:i])) {
		if([argText characterAtIndex:i] != '|') {
			[argsCleaned appendFormat:@"%c",[argText characterAtIndex:i]];
		}
	}
	NSString *payLoad = [NSString stringWithFormat:@"%d%@%@", teamNumber, queryText, argsCleaned];
	//NSLog(@"Payload: %@", payLoad);
	
	NSString *saltTeam = nil;
	if(debugMode == 2)
		saltTeam = [[NSString alloc] initWithString:@"THIS IS NOT A REAL SALT $-AEI55$XKYXn$8U)AHT-Q$DNuIOsaGZPGeYBZFYkewDLuY6vfPlv6o-rwEPDKpTRArSZxr-HT3S4SPqxfHZcwP9ZTPcd)vu)S3K5lAC)4V#MkW05ePXGfXfyn+IYj&J$wTxOUz9OBzblCRhgh)n2J8rw*zAViJDLd#ZxgY2hET9Glhn8SG1cFjE1OENxOQ,r7OVdnN0rh-y8XR7pX,8dXCVmHiQWzE3wSOG)c7d-+H,KZ)#xuy"];
	else {
//		switch(teamNumber) {
//			case 1:
				saltTeam = [[NSString alloc] initWithString:@"i,JhN73EA7S1$-AEI55$XKYXn$8U)AHT-Q$DNuIOsaGZPGeYBZFYkewDLuY6vfPlv6o-rwEPDKpTRArSZxr-HT3S4SPqxfHZcwP9ZTPcd)vu)S3K5lAC)4V#MkW05ePXGfXfyn+IYj&J$wTxOUz9OBzblCRhgh)n2J8rw*zAViJDLd#ZxgY2hET9Glhn8SG1cFjE1OENxOQ,r7OVdnN0rh-y8XR7pX,8dXCVmHiQWzE3wSOG)c7d-+H,KZ)#xuy"];
//				break;
//		}
	}			
	int lenPW = [payLoad length];
	if(lenPW > 200) {
		payLoad = [payLoad substringToIndex:200];
		lenPW = 200;
	}
	int lenSalt = 255 - lenPW;
	payLoad = [NSString stringWithFormat:@"%@%@", payLoad, [saltTeam substringToIndex:lenSalt]];
	NSLog(@"Calculating digest for paylod of [START]%@[END]", payLoad);
	NSString *digest = md5(payLoad);
	//for(int i = 0; i < 8101; i++)
	//	digest = md5(digest);
	//NSString* escapedUrlString = [[NSString stringWithFormat:@"%@%d%@%@%@%@%@%@", @"http://devsoap.fulgentcorp.com/trinityrestserver.php?teamnumber=", teamNumber, @"&querypart=", queryText, @"&argpart=", argText, @"&hash=", digest] stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
	NSString *escapedQueryPart = (NSString *)CFURLCreateStringByAddingPercentEscapes( NULL,	 (CFStringRef)queryText,	 NULL,	 (CFStringRef)@"!’\"();:@&=+$,/?%#[]% ", kCFStringEncodingISOLatin1);
	NSString *escapedArgPart = (NSString *)CFURLCreateStringByAddingPercentEscapes( NULL,	 (CFStringRef)argText,	 NULL,	 (CFStringRef)@"!’\"();:@&=+$,/?%#[]% ", kCFStringEncodingISOLatin1);
	NSString *escapedUrlString = [NSString stringWithFormat:@"%@%d%@%@%@%@%@%@", @"https://devsoap.fulgentcorp.com/trinityrestserver.php?teamnumber=", teamNumber, @"&querypart=", escapedQueryPart, @"&argpart=", escapedArgPart, @"&hash=", digest];
	//NSString *escapedUrlString = [NSString stringWithFormat:@"%@%d%@%@%@%@%@%@", @"http://www.fulgentcorp.com/trinityrestserver.php?teamnumber=", teamNumber, @"&querypart=", escapedQueryPart, @"&argpart=", escapedArgPart, @"&hash=", digest];
	[escapedQueryPart release];
	[escapedArgPart release];
	if(debugMode == 1) {
		[escapedUrlString release];
		escapedUrlString = [[NSString stringWithFormat:@"%@%d%@%@%@%@%@%@", @"http://badserver.fulgentcorp.com/trinityrestserver.php?teamnumber=", teamNumber, @"&querypart=", queryText, @"&argpart=", argText, @"&hash=", digest] stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
	}
	NSLog(@"in startQuery with URL %@", escapedUrlString);
	NSURL *url = [NSURL URLWithString:escapedUrlString];
	if(hasRunBefore) {
		[responseData release];
		[connection release];
		[request release];
	}
	resultArray = [[NSMutableArray alloc] initWithObjects:nil];
	responseData = [[NSMutableData alloc] init];
	request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	hasRunBefore = TRUE;
	queryState = TrinityRestQueryState_RUNNING;
	//[connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	//[connection start];
}

- (NSMutableArray *) getResultArray {
	return resultArray;
}

- (int) getNumSelectRows {
	return selectRowCount;
}

- (int) getNumSelectFields {
	return selectFieldCount;
}

- (int) getNumSelectRowsFetched {
	return selectRowsFetched;
}

- (void) cancelConnection {
	[connection cancel];
}

- (int) getResponseMaxLength {
	return responseMaxLength;
}

- (int) getResponseCurrentLength {
	return [responseData length];
}

//************************************
//CONNECTION AND PARSER DELEGATE STUFF
//************************************

- (void)connection: (NSURLConnection*) connection didReceiveResponse: (NSHTTPURLResponse*) response {
    if ([response statusCode] == 200) {
		responseMaxLength = [response expectedContentLength];
		queryState = TrinityRestQueryState_RUNNING_200;
    }
}

- (void) connection:(NSURLConnection *) connection didReceiveData: (NSData *) data {
	[responseData appendData: data];
	if(showLoadingView) {
		progress = (float) [responseData length] / (float) responseMaxLength;
		[progressMeterCallback invoke];
	}
		//{
		//UIProgressView *pv = (UIProgressView *) [self viewWithTag:100];
		//pv.progress = (float) [responseData length] / (float) responseMaxLength;
	//}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Connection Error %@", [error localizedDescription]);
	queryState = TrinityRestQueryState_ERROR;
	//[self finishQuery];
	[self cancelConnection];
	//allow a retry
	if(showLoadingView) {
		[showTimeoutCallback invoke];
	} else {
		//process callbacks since no view can do this for us by hitting cancel button
		[self finishQuery];
	}

}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
	if(showLoadingView) {
		progress = (float) 1;
		[progressMeterCallback invoke];
	}
	queryState = TrinityRestQueryState_PARSE_RUNNING;
	//NSLog(@"PARSE RUNNING 1");
	
	NSXMLParser *soapParser = [[NSXMLParser alloc] initWithData: responseData];
	//NSLog(@"Raw results data %@", resultsData);
	soapParser.delegate = self;
	[soapParser parse];
	[soapParser release];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qualifiedName 
	 attributes:(NSDictionary *)attributeDict {
	if([elementName isEqualToString:@"errorcode"]) {
		[currentDict release];
		currentDict = [[NSMutableDictionary alloc] initWithCapacity: [errorTags count]];
		parseState = 99;
		currentElementName = elementName;
		currentText = [[NSMutableString alloc] init];
	} else if([elementName isEqualToString:@"okcode"]) {
		[currentDict release];
		currentDict = [[NSMutableDictionary alloc] initWithCapacity: [okTags count]];
		parseState = 1;
		currentElementName = elementName;
		currentText = [[NSMutableString alloc] init];
	} else if([elementName isEqualToString:@"row"]) {
		parseState = 2;
		[currentDict release];
		currentDict = [[NSMutableDictionary alloc] initWithCapacity: selectFieldCount]; //passed in select response as <fieldcount>x</fieldcount>
	} else if(parseState == 2) {
		currentElementName = elementName;
		currentText = [[NSMutableString alloc] init];
	} else if([errorTags containsObject:elementName]) {
		currentElementName = elementName;
		currentText = [[NSMutableString alloc] init];
	} else if([okTags containsObject:elementName]) {
		currentElementName = elementName;
		currentText = [[NSMutableString alloc] init];
	} else if([elementName isEqualToString:@"fieldcount"]) {
		parseState = 3;
		currentElementName = elementName;
		currentText = [[NSMutableString alloc] init];
	} else if([elementName isEqualToString:@"rowcount"]) {
		parseState = 4;
		currentElementName = elementName;
		currentText = [[NSMutableString alloc] init];
	}
	//NSLog(@"parse state %d", parseState);
}
- (void) parserDidStartDocument:(NSXMLParser *)parser {
	queryState = TrinityRestQueryState_PARSE_RUNNING;
	//NSLog(@"PARSE RUNNING 2");
	
	//NSLog(@"parser start doc");
	//alloc 4KB
	currentElementName = nil;
	currentText = nil;
	parseState = 0;
	selectFieldCount = 0;
	selectRowCount = 0;
	selectRowsFetched = 0;
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *) string{
	[currentText appendString: string];
	//NSLog(@"currentText %@", currentText);
}

- (void) parser:(NSXMLParser *)parser didEndElement: (NSString *) elementName
   namespaceURI: (NSString *) namespaceURI 
  qualifiedName: (NSString *) qName {
	if(parseState == 3 && [elementName isEqualToString:@"fieldcount"]) {
		selectFieldCount = [currentText intValue];
		NSLog(@"# FIELDS %d", selectFieldCount);
		return;
	}
	if(parseState == 4 && [elementName isEqualToString:@"rowcount"]) {
		selectRowCount = [currentText intValue];
		NSLog(@"# ROWS %d", selectRowCount);
		return;
	}
	if([elementName isEqualToString:currentElementName]) {
		[currentDict setValue: currentText forKey: currentElementName];
	} else if([elementName isEqualToString:@"row"]) {
		[resultArray addObject:currentDict];
		//for(id key in currentDict) {
		//id value = [currentDict objectForKey:key];
		//[soapResponseString appendFormat:@"%@: %@\n", key, value];
		//push the row stored in the currentDict onto the row array
		//NSLog(@"%@: %@\n", key, value);
		//}
		selectRowsFetched++;
	}
	if(parseState == 1 && [elementName isEqualToString:@"oktext"]) {
		//[soapResponseString appendFormat:@"%@: %@\n", [currentDict valueForKey:@"okcode"], [currentDict valueForKey:@"oktext"]];
		[resultArray addObject:currentDict];
	} else if(parseState == 99 && [elementName isEqualToString:@"errortext"]) {
		[resultArray addObject:currentDict];
		//[soapResponseString appendFormat:@"%@: %@\n", [currentDict valueForKey:@"errorcode"], [currentDict valueForKey:@"errortext"]];
	}
	[currentText release];
	currentText = nil;
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
	//textView.text = soapResponseString;
	//[textView flashScrollIndicators];
	queryState = TrinityRestQueryState_PARSE_FINISH;
	[self finishQuery];
}

- (void) dealloc {
	if(queryText != nil)
		[queryText release];
	if(argText != nil)
		[argText release];
	[errorTags release];
	[okTags release];
	if(hasRunBefore) {
		[resultArray release];
		[responseData release];
		[connection release];
		[request release];
	}
	[callback release];
	if(showLoadingView) {
		[progressMeterCallback release];
		[showTimeoutCallback release];
	}
	[super dealloc];
}

@end
