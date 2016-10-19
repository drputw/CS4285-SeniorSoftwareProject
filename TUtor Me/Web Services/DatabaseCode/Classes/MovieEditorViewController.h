//
//  MovieEditorViewController.h
//  movie
//
//  Created by Mark Robinson on 10/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface MovieEditorViewController : UIViewController <UITextFieldDelegate> {
	UITextField *titleField;
	UITextField *boxOfficeGrossField;
	UITextField *summaryField;
	Movie *movie;
}

@property (nonatomic, retain) IBOutlet UITextField *titleField;
@property (nonatomic, retain) IBOutlet UITextField *boxOfficeGrossField;
@property (nonatomic, retain) IBOutlet UITextField *summaryField;
@property (nonatomic, retain) Movie *movie;

- (IBAction) done;

@end
