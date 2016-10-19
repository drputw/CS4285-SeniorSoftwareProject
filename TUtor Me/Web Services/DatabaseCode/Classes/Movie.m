//
//  Movie.m
//  movie
//
//  Created by Mark Robinson on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Movie.h"


@implementation Movie

@synthesize title;
@synthesize boxOfficeGross;
@synthesize summary;

- (id) initWithTitle:(NSString *)newTitle 
	  boxOfficeGross:(NSNumber *)newBoxOfficeGross 
			 summary:(NSString *)newSummary {
	self = [super init];
	if(self != nil) {
		self.title = newTitle;
		self.boxOfficeGross = newBoxOfficeGross;
		self.summary = newSummary;
	}
	return self;
}

- (void) dealloc {
	self.title = nil;
	self.boxOfficeGross = nil;
	self.summary = nil;
	[super dealloc];
}
@end
