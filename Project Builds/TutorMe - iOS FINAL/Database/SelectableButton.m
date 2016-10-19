//
//  SelectableButton.m
//  MovieTable
//
//  Created by Mark Robinson on 2/12/11.
//  Copyright Senior Software Project. All rights reserved.
//

#import "SelectableButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation SelectableButton

+ (id)SelectableButton:(CGRect)frame {
	//return [UIButton buttonWithType:UIButtonTypeRoundedRect];
	return [[[self alloc] initWithFrame:frame] autorelease];
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		//[self 
		//[self setTitleColor: [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1] forState: UIControlStateNormal];
		[[self layer] setCornerRadius:8.0f];
		
		[[self layer] setMasksToBounds:YES];
		[[self layer] setBorderWidth:1.0f];
		//[[self layer] setBackgroundColor:[[UIColor whiteColor] CGColor]];
		// UIView way
		[self setBackgroundColor:[UIColor whiteColor]];
		[self setTitleColor: [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1] forState: UIControlStateNormal];
		pressed = FALSE;
		[self addTarget: self action: @selector(button_clicked:) forControlEvents: UIControlEventTouchUpInside];
	}
	return self;
}

- (id)initCancelWithFrame:(CGRect)frame withTarget:(UIView *) newTarget {
	if (self = [super initWithFrame:frame]) {
		//[self 
		//[self setTitleColor: [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1] forState: UIControlStateNormal];
		[[self layer] setCornerRadius:8.0f];
		
		[[self layer] setMasksToBounds:YES];
		[[self layer] setBorderWidth:1.0f];
		//[[self layer] setBackgroundColor:[[UIColor whiteColor] CGColor]];
		// UIView way
		[self setBackgroundColor:[UIColor whiteColor]];
		[self setTitleColor: [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1] forState: UIControlStateNormal];
		pressed = FALSE;
		[self addTarget: newTarget action: @selector(cancelbutton_clicked:) forControlEvents: UIControlEventTouchUpInside];
	}
	return self;
}

- (id)initRetryWithFrame:(CGRect)frame withTarget:(UIView *) newTarget {
	if (self = [super initWithFrame:frame]) {
		//[self 
		//[self setTitleColor: [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1] forState: UIControlStateNormal];
		[[self layer] setCornerRadius:8.0f];
		
		[[self layer] setMasksToBounds:YES];
		[[self layer] setBorderWidth:1.0f];
		//[[self layer] setBackgroundColor:[[UIColor whiteColor] CGColor]];
		// UIView way
		[self setBackgroundColor:[UIColor whiteColor]];
		[self setTitleColor: [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1] forState: UIControlStateNormal];
		pressed = FALSE;
		[self addTarget: newTarget action: @selector(retrybutton_clicked:) forControlEvents: UIControlEventTouchUpInside];
	}
	return self;
}
/*
 - (id) initRound {
 self = [UIButton alloc];
 pressed = FALSE;
 return self;
 }
 
 - (id) initStuff {
 self = [super init];
 pressed = FALSE;
 UIImage* normalImage = [UIImage imageNamed: @"ToggleButtonNormal.png"];
 UIImage* downImage = [UIImage imageNamed: @"ToggleButtonDown.png"];
 UIImage* selectedImage = [UIImage imageNamed: @"ToggleButtonSelected.png"];
 [self setTitleColor: [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1] forState: UIControlStateNormal];
 [self setBackgroundImage: normalImage forState: UIControlStateNormal];
 [self setBackgroundImage: downImage forState: UIControlStateHighlighted];
 [self setBackgroundImage: selectedImage forState: UIControlStateSelected];
 [self addTarget: self action: @selector(button_clicked:) forControlEvents: UIControlEventTouchUpInside];
 return self;
 }
 
 - (id)initWithFrame: (CGRect)frame andTitle: (NSString*)title {
 if (self = [super initWithFrame: frame]) {
 pressed = FALSE;
 //[UIButton buttonWithType:UIButtonTypeRoundedRect]
 // Create images for button
 UIImage* normalImage = [UIImage imageNamed: @"ToggleButtonNormal.png"];
 UIImage* downImage = [UIImage imageNamed: @"ToggleButtonDown.png"];
 UIImage* selectedImage = [UIImage imageNamed: @"ToggleButtonSelected.png"];
 
 // Set up button
 [self setTitle: title forState: UIControlStateNormal];	// Will be used for all states
 [self setTitleColor: [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1] forState: UIControlStateNormal];
 [self setBackgroundImage: normalImage forState: UIControlStateNormal];
 [self setBackgroundImage: downImage forState: UIControlStateHighlighted];
 [self setBackgroundImage: selectedImage forState: UIControlStateSelected];
 [self addTarget: self action: @selector(button_clicked:) forControlEvents: UIControlEventTouchUpInside];
 }
 return self;
 }
 */

- (void) setNotPressed {
	pressed = FALSE;
}

- (bool) hasBeenPressed {
	return pressed;
}

- (void)button_clicked: (id)sender {
	self.selected = !self.selected;
	pressed = TRUE;
}
@end
