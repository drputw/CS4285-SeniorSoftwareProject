//
//  StudyViewController.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "StudyViewController.h"
#import "StudyDetailViewController.h"
#import "AddStudyEvent.h"
#import "TutorMeAppDelegate.h"
#import "Study.h"


/*
 Predefined colors to alternate the background color of each cell row by row
 (see tableView:cellForRowAtIndexPath: and tableView:willDisplayCell:forRowAtIndexPath:).
 */
#define DARK_BACKGROUND  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0]
#define LIGHT_BACKGROUND [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0]


@implementation StudyViewController

@synthesize tmpCell, cellNib, addButton, filteredListContent, studyList, savedSearchTerm, savedScopeButtonIndex, searchWasActive, queryType, subjectName, rsvp;


#pragma mark -
#pragma mark View controller methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.cellNib = [UINib nibWithNibName:@"StudyCell" bundle:nil];
	
    queryRunning = FALSE;
    myTimer =[NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(checkQueryStatus) userInfo:nil repeats:YES];
    queryRunning = TRUE;
    
	// Configure the table view.
    self.tableView.rowHeight = 73.0;
    self.tableView.backgroundColor = DARK_BACKGROUND;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // create a filtered list that will contain products for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.studyList count]];
    
    // restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
    
    //refresh tableview
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
    
    //add button to navigation bar
/*
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(blah) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 32, 32)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
 */   
   // addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(refreshPropertyList:)];          
    //self.navigationItem.rightBarButtonItem = addButton;
    //[addButton release];
}

- (void) showOKAlert: (NSString *) title withMessage: (NSString *) msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
                                                    message:msg
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}

- (void) queryFinish {
    //do some stuff
    NSLog(@"IN THE CALLBACK");
    //eventually dont need alerts here if query has the loading screen enabled
    int queryState = [query getQueryState];
    switch(queryState) {
        case 97:
            [self showOKAlert:@"Error!" withMessage:@"No query was provided!"];
            break;
        case 98:
            [self showOKAlert:@"Error!" withMessage:@"No team was provided!"];
            break;
        case 99:
            [self showOKAlert:@"Error!" withMessage:@"There was a timeout!"];
            break;
        case 100:
            NSLog(@"Success!");
            studyList = [[NSMutableArray alloc] init];
            resultArray = [query getResultArray];
            int numrows = [query getNumSelectRowsFetched];
            if(numrows == 0)
            {
                [self showOKAlert:@"No Results Found" withMessage:@""];
            }
            NSLog(@"%d", numrows);
            for(int i = 0; i < [query getNumSelectRowsFetched]; i++) {
                NSMutableDictionary *currentDict = [resultArray objectAtIndex:i];
                NSArray *keys = [currentDict allKeys];
                //id aKey = [keys objectAtIndex:1];
                NSLog(@"%@", keys);
                Study *s = [[Study alloc] init];
                s.eventID = [currentDict objectForKey:@"id"];
                s.firstName = [currentDict objectForKey:@"firstname"];
                s.lastName = [currentDict objectForKey:@"lastname"];
                s.email = [currentDict objectForKey:@"email"];
                s.phone = [currentDict objectForKey:@"phone"];
                s.title = [currentDict objectForKey:@"event_Name"];
                s.classNumber = [currentDict objectForKey:@"Course"];
                s.className = [currentDict objectForKey:@"Name"];
                s.location = [currentDict objectForKey:@"location"];
                s.startDate = [currentDict objectForKey:@"date_Start"];
                s.endDate = [currentDict objectForKey:@"date_End"];
                s.description = [currentDict objectForKey:@"details"];
                s.subject = [currentDict objectForKey:@"major"];
                s.rsvp = [currentDict objectForKey:@"count"];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss"];
                
                NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
                [formatter2 setDateStyle:NSDateFormatterLongStyle];
                [formatter2 setTimeStyle:NSDateFormatterLongStyle];
                
                NSDate *start = [formatter dateFromString:s.startDate];
                NSDate *end = [formatter dateFromString:s.endDate];
                NSString *startDate = [formatter2 stringFromDate:start];
                NSString *endDate = [formatter2 stringFromDate:end];
                s.startDate = startDate;
                s.endDate = endDate;
                NSArray *startArray = [startDate componentsSeparatedByString:@" "];
                s.month = [startArray objectAtIndex:0];
                s.day = [startArray objectAtIndex:1];
                s.day = [s.day substringToIndex:[s.day length]-1];
                [studyList addObject: s];
                [s release];
                startArray = nil;
                NSLog(@"%@", s.startDate);
            }

            [self doneLoadingTableViewData];
            [self.tableView reloadData];
            break;
        default:
            NSLog(@"Unknown query state");
    }
}

- (void) startQuery {
	studyList = nil;	
	query = [[TrinityRestQueryView alloc] initVars];
    [query loadingViewInView:[self.view.window.subviews objectAtIndex:0]];
    if([subjectName  isEqualToString:@"All"])
    {
        [query setQuery:@"SELECT COUNT(*) AS count, event.id, user.email, user.phone, user.firstname, user.lastname, course.Course, course.Name, event.event_Name, event.details, event.date_Start, event.date_End, event.date_Created, event.location, subject.major FROM tm_Event AS event LEFT JOIN tm_RSVP AS rsvp ON rsvp.event_ID = event.id INNER JOIN tm_User AS user ON user.id = event.user_id INNER JOIN tm_Major AS subject ON event.subject_id = subject.id LEFT JOIN tm_Courses AS course ON course.id = event.course_id GROUP BY event.id ORDER BY event.event_name Asc" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
    }
    else if([subjectName  isEqualToString:@"Organizer Name"])
    {
        [query setQuery:@"SELECT COUNT(*) AS count, event.id, user.email, user.phone, user.firstname, user.lastname, course.Course, course.Name, event.event_Name, event.details, event.date_Start, event.date_End, event.date_Created, event.location, subject.major FROM tm_Event AS event LEFT JOIN tm_RSVP AS rsvp ON rsvp.event_ID = event.id INNER JOIN tm_User AS user ON user.id = event.user_id INNER JOIN tm_Major AS subject ON event.subject_id = subject.id LEFT JOIN tm_Courses AS course ON course.id = event.course_id GROUP BY event.id ORDER BY user.lastname Asc" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
    }
    else if([subjectName  isEqualToString:@"Recently Added"])
    {
        [query setQuery:@"SELECT COUNT(*) AS count, event.id, user.email, user.phone, user.firstname, user.lastname, course.Course, course.Name, event.event_Name, event.details, event.date_Start, event.date_End, event.date_Created, event.location, subject.major FROM tm_Event AS event LEFT JOIN tm_RSVP AS rsvp ON rsvp.event_ID = event.id INNER JOIN tm_User AS user ON user.id = event.user_id INNER JOIN tm_Major AS subject ON event.subject_id = subject.id LEFT JOIN tm_Courses AS course ON course.id = event.course_id GROUP BY event.id ORDER BY event.event_name Asc" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
    }
    else if([queryType  isEqualToString:@"Events Attending"])
    {
        [query setQuery:@"Select COUNT(*) AS COUNT, event.id, rsvp.id,rsvp.event_ID, user.email, user.phone, user.firstname, user.lastname, event.details, event.date_Start, event.date_End, event.date_Created, event.location, event.event_Name, course.Course, course.name, major.major From tm_RSVP as rsvp Inner Join tm_Event as event On rsvp.event_ID = event.id Inner Join tm_User as user On event.user_ID = user.id Inner Join tm_Major as major ON event.subject_id = major.id Left Join tm_Courses as course On course.ID = event.course_id where rsvp.user_ID = 2 GROUP BY event.id ORDER BY event.event_name Asc" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
    }
    else if([queryType  isEqualToString:@"Organized Events"])
    {
        [query setQuery:@"SELECT COUNT(*) AS count, event.id, user.email, user.phone, user.firstname, user.lastname, course.Course, course.Name, event.event_Name, event.details, event.date_Start, event.date_End, event.date_Created, event.location, subject.major FROM tm_Event AS event LEFT JOIN tm_RSVP AS rsvp ON rsvp.event_ID = event.id INNER JOIN tm_User AS user ON user.id = event.user_id INNER JOIN tm_Major AS subject ON event.subject_id = subject.id LEFT JOIN tm_Courses AS course ON course.id = event.course_id where user.id = 2 GROUP BY event.id ORDER BY event.event_name Asc" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
    }
    else
    {
        [query setQuery:@"SELECT COUNT(*) AS count, user.email, user.phone, user.firstname, user.lastname, course.Course, course.Name, event.event_Name, event.details, event.date_Start, event.date_End, event.date_Created, event.location, subject.major FROM tm_Event AS event LEFT JOIN tm_RSVP AS rsvp ON rsvp.event_ID = event.id INNER JOIN tm_User AS user ON user.id = event.user_id INNER JOIN tm_Major AS subject ON event.subject_id = subject.id LEFT JOIN tm_Courses AS course ON course.id = event.course_id where subject.major = ? GROUP BY event.id ORDER BY event.event_name Asc" withArgs: subjectName teamnumber:11 target:self selector:@selector(queryFinish)];
    }
	//query.showLoadingView = TRUE;
	[query startQuery];
    
}

- (void) checkQueryStatus {
	if(queryRunning) {
		[self startQuery];
		queryRunning = FALSE;
	}
}

- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}

- (void)viewDidUnload
{
	[super viewDidLoad];
	
	self.tmpCell = nil;
	self.cellNib = nil;
    self.filteredListContent = nil;
    self.studyList = nil;
    _refreshHeaderView=nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}


#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
    else 
    {
        return [studyList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplicationCell";
    
    ApplicationCell *cell = (ApplicationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil)
    {
        [self.cellNib instantiateWithOwner:self options:nil];
		cell = tmpCell;
		self.tmpCell = nil;
    }
    
	// Display dark and light background in alternate rows -- see tableView:willDisplayCell:forRowAtIndexPath:.
    cell.useDarkBackground = (indexPath.row % 2 == 0);
	
	// Configure the data for the cell.
    Study *s = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        s  = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else 
    {
        s = [self.studyList objectAtIndex:indexPath.row];
    }

    //cell.icon = [UIImage imageNamed:[dataItem objectForKey:@"Icon"]];
    cell.topText = s.subject;
    cell.title = s.title;
    cell.bottomText = [s.firstName stringByAppendingString:[@" " stringByAppendingString:s.lastName]];
    cell.month = s.month;
    cell.day = s.day;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = ((ApplicationCell *)cell).useDarkBackground ? DARK_BACKGROUND : LIGHT_BACKGROUND;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StudyDetailViewController *vc = [[StudyDetailViewController alloc] initWithNibName:@"StudyDetailViewController" bundle:nil];
    //vc.descTemp = tempDescription;
    //vc.imageNameTemp = tempImageName;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StudyDetailViewController *detail = [[StudyDetailViewController alloc] initWithNibName:@"StudyDetailViewController" bundle:nil];
    
    Study *s = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        s = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
    {
        s = [self.studyList objectAtIndex:indexPath.row];
    }
    

    TutorMeAppDelegate *del = (TutorMeAppDelegate *)[UIApplication sharedApplication].delegate;
    del.study = s;
    detail.title = s.title;
    detail.eventID = s.eventID;
    NSLog(@"%@",s.title);
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}

#pragma mark -
#pragma mark Content Filtering

- (void)searchDisplayController:(UISearchDisplayController *)controller
 willShowSearchResultsTableView:(UITableView *)tableView
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = DARK_BACKGROUND;
    [tableView setRowHeight:[[self tableView] rowHeight]];
    [tableView reloadData];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (Study *s in studyList)
	{
        if ([scope isEqualToString:@"Title"])
        {
            NSComparisonResult result = [s.title compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
            {
                [self.filteredListContent addObject:s];
            }
        }
        else if ([scope isEqualToString:@"Subject"])
        {
            NSComparisonResult result = [s.subject compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
            {
                [self.filteredListContent addObject:s];
            }
        }
        else if ([scope isEqualToString:@"Org. Name"])
        {
            NSComparisonResult result = [s.firstName compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
            {
                [self.filteredListContent addObject:s];
            }
        }
    }
}
#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
    [self startQuery];
	[self.tableView reloadData];
    _reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[tmpCell release];
	[cellNib release];
    [filteredListContent release];
    _refreshHeaderView = nil;
    
    [studyList release];
    if(query != nil)
		[query release];
	
    [super dealloc];
}


@end
