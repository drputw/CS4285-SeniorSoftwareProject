//
//  SelectableButton.h
//  MovieTable
//
//  Created by Mark Robinson on 2/12/11.
//  Copyright Senior Software Project. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import <UIKit/UIKit.h>

@interface SelectableButton : UIButton {
	bool pressed;
}
//- (id)initWithFrame: (CGRect)frame andTitle: (NSString*)title;
- (id)initWithFrame:(CGRect)frame;
- (id)initCancelWithFrame:(CGRect)frame withTarget:(UIView *) newTarget;
- (id)initRetryWithFrame:(CGRect)frame withTarget:(UIView *) newTarget;
- (bool) hasBeenPressed;
- (void) setNotPressed;
//- (id) initStuff;
//- (id) initRound;
@end
