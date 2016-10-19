//
//  TrinityRestQueryView.m
//  MovieTable
//
//  Created by Mark Robinson on 2/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TrinityRestQueryView.h"
#import "TrinityRestQueryGuts.h"
#import <QuartzCore/QuartzCore.h>
#import "SelectableButton.h"

@implementation TrinityRestQueryView

@synthesize showLoadingView;

- (void)cancelbutton_clicked: (id)sender {
	//NSLog(@"cancel pressed");
	[self cancelConnection];
	[self finishQuery];
}

- (void)retrybutton_clicked: (id)sender {
	//NSLog(@"retry pressed");
	[self startQuery];
	SelectableButton *retryButton = (SelectableButton *)[self viewWithTag:210];
	retryButton.hidden = TRUE;
	SelectableButton *cancelButton = (SelectableButton *)[self viewWithTag:200];
	CGRect cancelRect = cancelButton.frame;
	cancelRect.origin.x = (0.5 * self.frame.size.width) - 50;
	cancelButton.frame = cancelRect;
	UIActivityIndicatorView *spinner = (UIActivityIndicatorView *) [self viewWithTag:50];
	[spinner startAnimating];
	UIProgressView *pv = (UIProgressView *) [self viewWithTag:100];
	pv.progress = 0;
	UILabel *loadingLabel = (UILabel *) [self viewWithTag:25];
	loadingLabel.text = NSLocalizedString(@"Working...", nil);
}

CGPathRef NewPathWithRoundRect(CGRect rect, CGFloat cornerRadius) {
	//
	// Create the boundary path
	//
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL,
					  rect.origin.x,
					  rect.origin.y + rect.size.height - cornerRadius);
	
	// Top left corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x,
						rect.origin.y,
						rect.origin.x + rect.size.width,
						rect.origin.y,
						cornerRadius);
	
	// Top right corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x + rect.size.width,
						rect.origin.y,
						rect.origin.x + rect.size.width,
						rect.origin.y + rect.size.height,
						cornerRadius);
	
	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x + rect.size.width,
						rect.origin.y + rect.size.height,
						rect.origin.x,
						rect.origin.y + rect.size.height,
						cornerRadius);
	
	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x,
						rect.origin.y + rect.size.height,
						rect.origin.x,
						rect.origin.y,
						cornerRadius);
	
	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
	
	return path;
}


- (id) initVars {
	showLoadingView = FALSE;
	//init guts
	guts = [[TrinityRestQueryGuts alloc] initVars];
	return self;
}

- (void) loadingViewInView:(UIView *)aSuperview {
	showLoadingView = TRUE;
	[self initWithFrame:[aSuperview bounds]];
	self.opaque = NO;
	self.autoresizingMask =
	UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[aSuperview addSubview:self];
	
	const CGFloat DEFAULT_LABEL_WIDTH = 280.0;
	const CGFloat DEFAULT_LABEL_HEIGHT = 50.0;
	CGRect labelFrame = CGRectMake(0, 0, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
	UILabel *loadingLabel =
	[[[UILabel alloc]
	  initWithFrame:labelFrame]
	 autorelease];
	loadingLabel.tag = 25;
	loadingLabel.text = NSLocalizedString(@"Working...", nil);
	loadingLabel.textColor = [UIColor whiteColor];
	loadingLabel.backgroundColor = [UIColor clearColor];
	loadingLabel.textAlignment = UITextAlignmentCenter;
	loadingLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
	loadingLabel.autoresizingMask =
	UIViewAutoresizingFlexibleLeftMargin |
	UIViewAutoresizingFlexibleRightMargin |
	UIViewAutoresizingFlexibleTopMargin |
	UIViewAutoresizingFlexibleBottomMargin;
	
	[self addSubview:loadingLabel];
	
	UIActivityIndicatorView *activityIndicatorView =
	[[[UIActivityIndicatorView alloc]
	  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]
	 autorelease];
	activityIndicatorView.tag = 50;
	
	[self addSubview:activityIndicatorView];
	activityIndicatorView.autoresizingMask =
	UIViewAutoresizingFlexibleLeftMargin |
	UIViewAutoresizingFlexibleRightMargin |
	UIViewAutoresizingFlexibleTopMargin |
	UIViewAutoresizingFlexibleBottomMargin;
	[activityIndicatorView startAnimating];
	
	CGFloat totalHeight =
	loadingLabel.frame.size.height +
	activityIndicatorView.frame.size.height;
	labelFrame.origin.x = floor(0.5 * (self.frame.size.width - DEFAULT_LABEL_WIDTH));
	labelFrame.origin.y = floor(0.5 * (self.frame.size.height - totalHeight));
	loadingLabel.frame = labelFrame;
	
	CGRect activityIndicatorRect = activityIndicatorView.frame;
	activityIndicatorRect.origin.x =
	0.5 * (self.frame.size.width - activityIndicatorRect.size.width);
	activityIndicatorRect.origin.y =
	loadingLabel.frame.origin.y + loadingLabel.frame.size.height;
	activityIndicatorView.frame = activityIndicatorRect;
	
	//add progress bar
	UIProgressView *pv = [[[UIProgressView alloc] initWithFrame:CGRectMake(50, activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height + 20, self.frame.size.width - 100, 50)] autorelease];
	pv.tag = 100;
	pv.autoresizingMask =
	UIViewAutoresizingFlexibleLeftMargin |
	UIViewAutoresizingFlexibleRightMargin |
	UIViewAutoresizingFlexibleTopMargin |
	UIViewAutoresizingFlexibleBottomMargin;
	[self addSubview: pv];
	
	//add cancel button
	CGRect rect = CGRectMake((0.5 * self.frame.size.width) - 50, pv.frame.origin.y + pv.frame.size.height + 20, 100, 40);
	SelectableButton *myButton = [[SelectableButton alloc] initCancelWithFrame:rect withTarget: self];
    [myButton setTitle:@"Cancel" forState:UIControlStateNormal];
	myButton.tag = 200;
    // add to a view
	[self addSubview: myButton];
	
	//add retry button
	//cancelRect.origin.x = (.5 * loadingView.frame.size.width) + 10; //- cancelRect.size.width;
	CGRect retryRect = CGRectMake(40 , pv.frame.origin.y + pv.frame.size.height + 20, 100, 40);
	SelectableButton *myRetryButton = [[SelectableButton alloc] initRetryWithFrame:retryRect withTarget: self];
	retryRect = myRetryButton.frame;
	retryRect.origin.x = (.5 * self.frame.size.width) - 10 - retryRect.size.width;
	myRetryButton.frame = retryRect;
    [myRetryButton setTitle:@"Retry" forState:UIControlStateNormal];
	myRetryButton.tag = 210;
	myRetryButton.hidden = TRUE;
    // add to a view
	[self addSubview: myRetryButton];
	
	// Set up the fade-in animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
	
	//return loadingView;
}

- (void)removeView {
	UIView *aSuperview = [self superview];
	[super removeFromSuperview];
	
	// Set up the animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
}

- (void) setQuery:(NSString *) queryVal withArgs:(NSString *) argVal teamnumber:(int) team target:(id)callbackObj selector:(SEL)selector {
	//if(self=[super init]) {
	[guts setQueryText:queryVal withArgs:argVal];
	guts.teamNumber = team;
	
	NSMethodSignature *sig = [[callbackObj class] instanceMethodSignatureForSelector:selector];
	callback = [NSInvocation invocationWithMethodSignature:sig];
	[callback setTarget:callbackObj];
	[callback setSelector:selector];
	[callback retain];
	
	//set query for guts object
	[guts setCallback:self selector:@selector(finishQuery)];
	
	//only need to do this if creating within view object
	[guts initViewInfo:self progressMeterSelector:@selector(updateProgressMeter) retryButtonSelector:@selector(showTimeoutButtons)];
}

- (void) finishQuery {
	if(showLoadingView)
		[self removeView];
	[callback invoke];
	return;
}

- (void) startQuery {
	[guts startQuery];
}

- (NSMutableArray *) getResultArray {
	return [guts getResultArray];
}

- (int) getNumSelectRows {
	return [guts getNumSelectRows];
}

- (int) getNumSelectFields {
	return [guts getNumSelectFields];
}

- (int) getNumSelectRowsFetched {
	return [guts getNumSelectRowsFetched];
}

- (void) cancelConnection {
	[guts cancelConnection];
}

- (int) getResponseMaxLength {
	return [guts getResponseMaxLength];
}

- (int) getResponseCurrentLength {
	return [guts getResponseCurrentLength];
}

- (int) getQueryState {
	return guts.queryState;
}

- (int) getParseState {
	return guts.parseState;
}

- (int) getQueryType {
	return guts.queryType;
}

- (void) updateProgressMeter {
	UIProgressView *pv = (UIProgressView *) [self viewWithTag:100];
	pv.progress = guts.progress;
}

- (void) showTimeoutButtons {
	SelectableButton *retryButton = (SelectableButton *)[self viewWithTag:210];
	retryButton.hidden = FALSE;
	[retryButton setNotPressed];
	SelectableButton *cancelButton = (SelectableButton *)[self viewWithTag:200];
	CGRect cancelRect = cancelButton.frame;
	cancelRect.origin.x = (.5 * self.frame.size.width) + 10; //- cancelRect.size.width;
	cancelButton.frame = cancelRect;
	[cancelButton setNotPressed];
	UIActivityIndicatorView *spinner = (UIActivityIndicatorView *) [self viewWithTag:50];
	[spinner stopAnimating];
	UILabel *loadingLabel = (UILabel *) [self viewWithTag:25];
	//NSLocalizedString
	loadingLabel.text = @"The query timed out. Retry?";
}
	 
- (void)drawRect:(CGRect)rect {
	rect.size.height -= 1;
	rect.size.width -= 1;
	
	const CGFloat RECT_PADDING = 8.0;
	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
	
	const CGFloat ROUND_RECT_CORNER_RADIUS = 5.0;
	CGPathRef roundRectPath = NewPathWithRoundRect(rect, ROUND_RECT_CORNER_RADIUS);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	const CGFloat BACKGROUND_OPACITY = 0.55;
	CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextFillPath(context);
	
	const CGFloat STROKE_OPACITY = 0.25;
	CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextStrokePath(context);
	
	CGPathRelease(roundRectPath);
}

- (void) dealloc {
	[guts release];
	[callback release];
	[super dealloc];
}
@end
