//
//  ApplicationCellEvent.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ApplicationCellEvent.h"

@implementation ApplicationCellEvent

@synthesize useDarkBackground, icon, number, classname, organizer, month, day;

- (void)setUseDarkBackground:(BOOL)flag
{
    if (flag != useDarkBackground || !self.backgroundView)
    {
        useDarkBackground = flag;
        
        NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:useDarkBackground ? @"DarkBackground" : @"LightBackground" ofType:@"png"];
        UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
        self.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundView.frame = self.bounds;
    }
}

- (void)dealloc
{
    [icon release];
    [number release];
    [classname release];
    [organizer release];
    [month release];
    //[day release];
    
    [super dealloc];
}

@end
