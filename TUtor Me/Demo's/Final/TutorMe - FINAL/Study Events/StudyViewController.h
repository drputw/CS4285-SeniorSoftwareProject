//
//  StudyViewController.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationCell.h"
#import "TrinityRestQueryView.h"
#import "EGORefreshTableHeaderView.h"

@interface StudyViewController :UITableViewController <EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>
{
	ApplicationCell *tmpCell;
    NSMutableArray *studyList;
    NSMutableArray	*filteredListContent;	// The content filtered as a result of a search
	
	// referring to our xib-based UITableViewCell ('TutorCell')
	UINib *cellNib;
    UIBarButtonItem *addButton;
    
    
    TrinityRestQueryView *query;
	NSMutableArray *resultArray;
    
	NSTimer *myTimer;
	bool queryRunning;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
    
    NSString		*savedSearchTerm;
    NSInteger		savedScopeButtonIndex;
    BOOL			searchWasActive;
    NSString *queryType;
    NSString *subjectName;
    int *rsvp;

}

- (void) showOKAlert: (NSString *) title withMessage: (NSString *) msg;
- (void) startQuery;
- (void) queryFinish;
- (void) checkQueryStatus;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@property (nonatomic, retain) IBOutlet ApplicationCell *tmpCell;
@property (nonatomic, retain) NSMutableArray *studyList;
@property (nonatomic, retain) NSMutableArray *filteredListContent;

@property (nonatomic, retain) UINib *cellNib;
@property (nonatomic, retain) UIBarButtonItem *addButton;


@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;
@property (nonatomic, retain) NSString *queryType;
@property (nonatomic, retain) NSString *subjectName;
@property (nonatomic) int *rsvp;

@end

