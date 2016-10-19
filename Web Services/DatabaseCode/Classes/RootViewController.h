//
//  RootViewController.h
//  MovieTable
//
//  Created by Mark Robinson on 2/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MovieEditorViewController.h"
#import "TrinityRestQueryView.h"

@interface RootViewController : UITableViewController {
	NSMutableArray *moviesArray;

	IBOutlet MovieEditorViewController *movieEditor;

	Movie *editingMovie;
	UITableViewCell *nibLoadedCell;
	UISegmentedControl *sortControl;
	
	//this should be it for processing the rest query
	TrinityRestQueryView *query;
	NSMutableArray *resultArray;

	NSTimer *myTimer;
	bool queryRunning;
}
@property (nonatomic, retain) IBOutlet MovieEditorViewController *movieEditor;

@property (nonatomic, retain) IBOutlet UITableViewCell *nibLoadedCell;
@property (nonatomic, retain) IBOutlet UISegmentedControl *sortControl;

-(IBAction) handleAddTapped;
-(IBAction) handleSortChanged;
- (void) startQuery;
- (void) queryFinish;
@end