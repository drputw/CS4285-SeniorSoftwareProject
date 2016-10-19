//
//  TutorCategoryViewController.m
//  TutorMe
//
//  Created by James Seales on 11/2/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "TutorCategoryViewController.h"
#import "TutorViewController.h"
#import "CategoryObject.h"
#import "TutorMeAppDelegate.h"
#import "Guts2.h"

@implementation TutorCategoryViewController
@synthesize categoryList, combinedList,categoryArray, categorytext, categoryName, loggingin;

static NSString *const appClientName = @"912324548806.apps.googleusercontent.com";
static NSString *const appClientSecret = @"jFJQx5j_QI7jCBwhvuYZ-doX";

/*
 Predefined colors to alternate the background color of each cell row by row
 (see tableView:cellForRowAtIndexPath: and tableView:willDisplayCell:forRowAtIndexPath:).
 */
#define DARK_BACKGROUND  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0]
#define LIGHT_BACKGROUND [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0]

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    authUser = [[TrinityOAuth2WSAppUser alloc] initVars];
	[authUser setAuthSource:@"google" withClientId:appClientName withClientSecret:appClientSecret];
    
    queryRunning = NO;
	guts = nil;
    [self startQuery];
    
    //queryRunning = FALSE;
    //myTimer =[NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(checkQueryStatus) userInfo:nil repeats:YES];
    //queryRunning = TRUE;
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
    int numRows = [guts getNumSelectRowsFetched];
    resultArray = [guts getResultArray];
    NSLog(@"%d", numRows);
        if (numRows > 0) {
            NSLog(@"Success!");
            categoryList = [[NSMutableArray alloc] init];
            
            categoryArray = [[NSMutableArray alloc] init];
            for(int i = 0; i < [guts getNumSelectRowsFetched]; i++) {
                NSMutableDictionary *currentDict = [resultArray objectAtIndex:i];
                CategoryObject *category = [[CategoryObject alloc] init];
                category.categoryID = [currentDict objectForKey:@"id"];
                category.category = [currentDict objectForKey:@"major"];
                categorytext = category.category;
                [categoryArray addObject:categorytext];
                [categoryList addObject: category];
                [categorytext release];
                [category release];
            }
            NSLog(@"%d",[categoryArray count]);
            //TutorMeAppDelegate *appDelegate = (TutorMeAppDelegate *)[[UIApplication sharedApplication] delegate];
            //appDelegate.majors = [[NSMutableArray alloc] initWithObjects:categoryArray, nil];
            NSArray *firstSection = [NSArray arrayWithObjects:@"All", @"Rank", @"Recently Added",nil];
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:firstSection, categoryArray, nil];
            [self setCombinedList:array];
            [array release], array = nil;
            [self.tableView reloadData];
    }
}

- (void) startQuery {
	categoryList = nil;	
	//query = [[TrinityRestQueryView alloc] initVars];
    //[query loadingViewInView:[self.view.window.subviews objectAtIndex:0]];
    //[query setQuery:@"SELECT * FROM tm_Major ORDER BY major Asc" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
    if(queryRunning) 
        [guts cancelConnection];
    guts = [[Guts2 alloc] initVars];
    //[guts setSalt:[authUser getWSAccessToken]];
    //[guts setAccessToken:[authUser getUserAccessToken]];
    [guts setSalt:[authUser getWSAccessToken]];
    [guts setAccessToken:[authUser getUserAccessToken]];
    [guts setQueryText:@"SELECT * FROM tm_Major ORDER BY major Asc" withArgs:@""];		
    [guts setCallback:self selector:@selector(queryFinish)];
    [guts startQuery];
    queryRunning = YES;
    
    
	//query.showLoadingView = TRUE;
	//[query startQuery];
    
}

- (void) checkQueryStatus {
	if(queryRunning) {
		[self startQuery];
		queryRunning = FALSE;
	}
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.categoryList = nil;
    self.combinedList = nil;
    self.categoryArray = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = [[self combinedList] count];
	
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
   if(section == 0)
       return 2;
    else
        return [categoryList count];
    */
    NSArray *sectionContents = [[self combinedList] objectAtIndex:section];
    NSInteger rows = [sectionContents count];
	
    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if(section == 0)
		return @"Browse";
	else
		return @"Majors & Minors";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionContents = [[self combinedList] objectAtIndex:[indexPath section]];
    NSString *contentForThisRow = [sectionContents objectAtIndex:[indexPath row]];
    
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell..
   [[cell textLabel] setText:contentForThisRow];
    //categoryName = cell.textLabel.text;
   // NSLog(@"%@", categoryName);
    /*
    CategoryObject *category = [self.categoryList objectAtIndex:indexPath.row];
    cell.textLabel.text = category.category;
     */
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    TutorViewController *vc = [[TutorViewController alloc] initWithNibName:@"TutorViewController" bundle:nil];
    //categoryName = [combinedList objectAtIndex:indexPath.row];
    
    NSArray *sectionContents = [[self combinedList] objectAtIndex:[indexPath section]];
    NSString *contentForThisRow = [sectionContents objectAtIndex:[indexPath row]];
    categoryName = contentForThisRow;
    //categoryName = contentForThisRow;
    
    if([categoryName isEqualToString:@"All"])
       vc.title = @"All Tutors";
    else if([categoryName isEqualToString:@"Rank"])
        vc.title = @"Class Rank";
    else if([categoryName isEqualToString:@"Recently Added"])
        vc.title = @"Recently Added";
    else
       vc.title = categoryName;
    vc.categoryName = categoryName;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)dealloc {
    [categoryList release];
    
	if(guts != nil) {
		[guts release];
		guts = nil;
    }
    [super dealloc];
}

@end
