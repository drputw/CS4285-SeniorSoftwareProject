//
//  TrinityRestQueryView.h
//  MovieTable
//
//  Created by Mark Robinson on 2/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrinityRestQueryGuts.h"

@interface TrinityRestQueryView : UIView {
	bool showLoadingView;
	TrinityRestQueryGuts *guts;
	NSInvocation *callback;
}
@property bool showLoadingView;

- (id) initVars;
- (void) setQuery:(NSString *) queryVal withArgs:(NSString *) argVal teamnumber:(int) team target:(id)callbackObj selector:(SEL)selector;
- (void) setQueryText: (NSString *) queryVal withArgs: (NSString *) argVal;
- (void) startQuery;
- (void) finishQuery;
- (NSMutableArray *) getResultArray;
- (int) getNumSelectRowsFetched;
- (void)loadingViewInView:(UIView *)aSuperview;
- (void)removeView;
- (void)cancelbutton_clicked: (id)sender;
- (void)retrybutton_clicked: (id)sender;
- (void) cancelConnection;	
- (int) getQueryState;
- (void) updateProgressMeter;
- (void) showTimeoutButtons;
- (int) getParseState;
- (int) getQueryType;
@end
