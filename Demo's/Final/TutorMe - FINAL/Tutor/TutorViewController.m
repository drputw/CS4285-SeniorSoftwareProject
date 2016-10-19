//
//  TutorViewController.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "TutorViewController.h"
#import "TutorDetailViewController.h"
#import "TutorMeAppDelegate.h"
#import "Tutor.h"


/*
 Predefined colors to alternate the background color of each cell row by row
 (see tableView:cellForRowAtIndexPath: and tableView:willDisplayCell:forRowAtIndexPath:).
 */
#define DARK_BACKGROUND  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0]
#define LIGHT_BACKGROUND [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0]


@implementation TutorViewController

@synthesize tmpCell, cellNib, filteredListContent, tutorList, categoryName, savedSearchTerm, savedScopeButtonIndex, searchWasActive;


#pragma mark -
#pragma mark View controller methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.cellNib = [UINib nibWithNibName:@"TutorCell" bundle:nil];
    
    
    queryRunning = FALSE;
    myTimer =[NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(checkQueryStatus) userInfo:nil repeats:YES];
    queryRunning = TRUE;
	
	// Configure the table view.
    self.tableView.rowHeight = 73.0;
    self.tableView.backgroundColor = DARK_BACKGROUND;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //
    // create a filtered list that will contain products for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.tutorList count]];
    
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
                tutorList = [[NSMutableArray alloc] init];
                resultArray = [query getResultArray];
                int numrows = [query getNumSelectRowsFetched];
                if(numrows == 0)
                {
                    [self showOKAlert:@"No Results Found" withMessage:@""];
                }
                for(int i = 0; i < [query getNumSelectRowsFetched]; i++) {
                    NSMutableDictionary *currentDict = [resultArray objectAtIndex:i];
                    Tutor *t = [[Tutor alloc] init];
                    t.tutorID = [currentDict objectForKey:@"id"];
                    t.firstName = [currentDict objectForKey:@"firstname"];
                    t.lastName = [currentDict objectForKey:@"lastname"];
                    t.email = [currentDict objectForKey:@"email"];
                    t.phone = [currentDict objectForKey:@"phone"];
                    t.rank = [currentDict objectForKey:@"class"];
                    t.major1 = [currentDict objectForKey:@"major"];
                    t.major2 = [currentDict objectForKey:@"major2"];
                    t.major3 = [currentDict objectForKey:@"major3"];
                    t.major4 = [currentDict objectForKey:@"major4"];
                    t.description = [currentDict objectForKey:@"description"];
                    t.availability = [currentDict objectForKey:@"availability"];
                    [tutorList addObject: t];
                    [t release];
                }
                [self doneLoadingTableViewData];
                [self.tableView reloadData];
                break;
            default:
                NSLog(@"Unknown query state");
        }
}

- (void) startQuery {
	tutorList = nil;	
	query = [[TrinityRestQueryView alloc] initVars];
    [query loadingViewInView:[self.view.window.subviews objectAtIndex:0]];
    NSLog(@"%@", categoryName);
    if([categoryName  isEqualToString:@"All"])
        [query setQuery:@"SELECT user.id, user.firstname, user.lastname, user.email, class.class, user.phone, user.description, user.availability, major_1.major, major_2.major2, major_3.major3, major_4.major4 FROM tm_User AS user INNER JOIN tm_Classification AS class ON user.classification = class.id INNER JOIN tm_Major AS major_1 ON major_1.id = user.major_1 LEFT JOIN tm_Major2 AS major_2 ON major_2.id = user.major_2 LEFT JOIN tm_Major3 AS major_3 ON major_3.id = user.major_3 LEFT JOIN tm_Major4 AS major_4 ON major_4.id = user.major_4 WHERE user.isTutor =1 ORDER BY user.lastname ASC" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
    else if([categoryName  isEqualToString:@"Rank"])
        [query setQuery:@"SELECT user.id, user.firstname, user.lastname, user.email, class.class, user.phone, user.description, user.availability, major_1.major, major_2.major2, major_3.major3, major_4.major4 FROM tm_User AS user INNER JOIN tm_Classification AS class ON user.classification = class.id INNER JOIN tm_Major AS major_1 ON major_1.id = user.major_1 LEFT JOIN tm_Major2 AS major_2 ON major_2.id = user.major_2 LEFT JOIN tm_Major3 AS major_3 ON major_3.id = user.major_3 LEFT JOIN tm_Major4 AS major_4 ON major_4.id = user.major_4 WHERE user.isTutor =1 ORDER BY class.id Desc, user.lastname Asc" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
    else if([categoryName  isEqualToString:@"Recently Added"])
        [query setQuery:@"SELECT user.id, user.firstname, user.lastname, user.email, class.class, user.phone, user.description, user.availability, major_1.major, major_2.major2, major_3.major3, major_4.major4 FROM tm_User AS user INNER JOIN tm_Classification AS class ON user.classification = class.id INNER JOIN tm_Major AS major_1 ON major_1.id = user.major_1 LEFT JOIN tm_Major2 AS major_2 ON major_2.id = user.major_2 LEFT JOIN tm_Major3 AS major_3 ON major_3.id = user.major_3 LEFT JOIN tm_Major4 AS major_4 ON major_4.id = user.major_4 WHERE user.isTutor =1 ORDER BY user.lastname ASC" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
    else
    {
        NSString *args = [categoryName stringByAppendingString:[@"|" stringByAppendingString:[categoryName stringByAppendingString:[@"|" stringByAppendingString:[categoryName stringByAppendingString:[@"|" stringByAppendingString:categoryName]]]]]];
        [query setQuery:@"SELECT user.id, user.firstname, user.lastname, user.email, class.class, user.phone, user.description, user.availability, major_1.major, major_2.major2, major_3.major3, major_4.major4 FROM tm_User AS user INNER JOIN tm_Classification AS class ON user.classification = class.id INNER JOIN tm_Major AS major_1 ON major_1.id = user.major_1 LEFT JOIN tm_Major2 AS major_2 ON major_2.id = user.major_2 LEFT JOIN tm_Major3 AS major_3 ON major_3.id = user.major_3 LEFT JOIN tm_Major4 AS major_4 ON major_4.id = user.major_4 WHERE major_1.major = ? OR major_2.major2 =? OR major_3.major3 =? OR major_4.major4 =? AND user.isTutor = 1 ORDER BY user.lastname ASC" withArgs:args teamnumber:11 target:self selector:@selector(queryFinish)];
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
    self.tutorList = nil;
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
        return [tutorList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplicationCell";
    
    ApplicationCell *cell = (ApplicationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    
    if(cell == nil)
    {
        [self.cellNib instantiateWithOwner:self options:nil];
		cell = tmpCell;
		self.tmpCell = nil;
    }
	// Display dark and light background in alternate rows -- see tableView:willDisplayCell:forRowAtIndexPath:.
    cell.useDarkBackground = (indexPath.row % 2 == 0);
	
	// Configure the data for the cell.
    Tutor *t = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        t  = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else 
    {
        t = [self.tutorList objectAtIndex:indexPath.row];
    }
   
    NSString *iconPath = t.major1;
    NSLog(@"%@", iconPath);
    cell.icon = [UIImage imageNamed:iconPath];
    

        if([t.major1 length] != 0 && [t.major2 length] == 0 && [t.major3 length] == 0 && [t.major4 length] == 0)
        {
            cell.topText = t.major1;
        }
        else if([t.major1 length] != 0 && [t.major2 length] != 0 && [t.major3 length] == 0 && [t.major4 length] == 0)
        {
            cell.topText = [t.major1 stringByAppendingString:[@", " stringByAppendingString:t.major2]];
        }
        else if([t.major1 length] != 0 && [t.major2 length] != 0 && [t.major3 length] != 0 && [t.major4 length] == 0)
        {
            cell.topText = [t.major1 stringByAppendingString:[@", " stringByAppendingString:[t.major2 stringByAppendingString:[@", " stringByAppendingString:t.major3]]]];
        }
        else
        {
            cell.topText =[t.major1 stringByAppendingString:[@", " stringByAppendingString:[t.major2 stringByAppendingString:[@", " stringByAppendingString:[t.major3 stringByAppendingString:[@", " stringByAppendingString:t.major4]]]]]];
        }
    cell.title =  [t.firstName stringByAppendingString:[@" " stringByAppendingString:t.lastName]];
    cell.bottomText =  t.rank;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = ((ApplicationCell *)cell).useDarkBackground ? DARK_BACKGROUND : LIGHT_BACKGROUND;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TutorDetailViewController *detail = [[TutorDetailViewController alloc] initWithNibName:@"TutorDetailViewController" bundle:nil];
    
    Tutor *t = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        t = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
    {
        t = [self.tutorList objectAtIndex:indexPath.row];
    }

    TutorMeAppDelegate *del = (TutorMeAppDelegate *)[UIApplication sharedApplication].delegate;
    del.tutor = t;
    detail.title = [t.firstName stringByAppendingString:[@" " stringByAppendingString:t.lastName]];
    
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
	for (Tutor *t in tutorList)
	{
            if ([scope isEqualToString:@"First Name"])
            {
                NSComparisonResult result = [t.firstName compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
                if (result == NSOrderedSame)
                {
                    [self.filteredListContent addObject:t];
                }
            }
            else if ([scope isEqualToString:@"Last Name"])
            {
                NSComparisonResult result = [t.lastName compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
                if (result == NSOrderedSame)
                {
                    [self.filteredListContent addObject:t];
                }
            }
            else if ([scope isEqualToString:@"Major"])
            {
                NSComparisonResult result = [t.major1 compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
                if (result == NSOrderedSame)
                {
                    [self.filteredListContent addObject:t];
                }
            }
            else if ([scope isEqualToString:@"Rank"])
            {
                NSComparisonResult result = [t.rank compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
                if (result == NSOrderedSame)
                {
                    [self.filteredListContent addObject:t];
                }
            }
            
		}
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
    
    [tutorList release];
    if(query != nil)
		[query release];
	
    [super dealloc];
}

@end