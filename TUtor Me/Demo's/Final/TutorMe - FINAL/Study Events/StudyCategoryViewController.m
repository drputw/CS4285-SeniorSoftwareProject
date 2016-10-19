//
//  StudyCategoryViewController.m
//  TutorMe
//
//  Created by James Seales on 11/3/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "StudyCategoryViewController.h"
#import "StudyViewController.h"
#import "AddStudyEvent.h"
#import "TutorMeAppDelegate.h"

@implementation StudyCategoryViewController

@synthesize categoryList, combinedList, categoryArray, categorytext, subjectName;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    //self.tableView.backgroundColor = DARK_BACKGROUND;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    queryRunning = FALSE;
    myTimer =[NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(checkQueryStatus) userInfo:nil repeats:YES];
    queryRunning = TRUE;
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
            categoryList = [[NSMutableArray alloc] init];
            resultArray = [query getResultArray];
            categoryArray = [[NSMutableArray alloc] init];
            for(int i = 0; i < [query getNumSelectRowsFetched]; i++) {
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
            NSArray *firstSection = [NSArray arrayWithObjects:@"All", @"Organizer Name", @"Recently Added",nil];
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:firstSection, categoryArray, nil];
            [self setCombinedList:array];
            [array release], array = nil;
            [self.tableView reloadData];
            break;
        default:
            NSLog(@"Unknown query state");
    }
}

- (void) startQuery {
	categoryList = nil;	
	query = [[TrinityRestQueryView alloc] initVars];
	//[query loadingViewInView:[self.view.window.subviews objectAtIndex:0]];1 where age_indexed = ?" withArgs:@"18" teamnumber:12 target:self selector:@selector(queryFinish)];
    [query loadingViewInView:[self.view.window.subviews objectAtIndex:0]];
    //[query setQuery:@"SELECT * FROM Roster where ?" withArgs:@"1" teamnumber:12 target:self selector:@selector(queryFinish)];
    //TutorMeAppDelegate *del = (TutorMeAppDelegate *)[UIApplication sharedApplication].delegate;
    [query setQuery:@"SELECT * FROM tm_Major ORDER BY major Asc" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
    
	//query.showLoadingView = TRUE;
	[query startQuery];
    
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
    NSArray *sectionContents = [[self combinedList] objectAtIndex:section];
    NSInteger rows = [sectionContents count];
	
    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if(section == 0)
		return @"Browse";
	else
		return @"Subjects";
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
    // Configure the cell..
    //CategoryObject *category = [self.categoryList objectAtIndex:indexPath.row];
   // cell.textLabel.text = category.category;
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
    StudyViewController *vc = [[StudyViewController alloc] initWithNibName:@"StudyViewController" bundle:nil];
    //CategoryObject *c= [categoryList objectAtIndex:indexPath.row];
    NSArray *sectionContents = [[self combinedList] objectAtIndex:[indexPath section]];
    NSString *contentForThisRow = [sectionContents objectAtIndex:[indexPath row]];
    subjectName = contentForThisRow;
    
    if([subjectName isEqualToString:@"All"])
        vc.title = @"All Events";
    else if([subjectName isEqualToString:@"Upcoming"])
        vc.title = @"Upcoming Events";
    else if([subjectName isEqualToString:@"Recently Added"])
        vc.title = @"Recently Added";
    else
        vc.title = subjectName;
    vc.subjectName = subjectName;
    vc.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(addEventHandler:)];       
    vc.navigationItem.rightBarButtonItem = vc.addButton;
    //vc.title = @"Create New Event";
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

-(IBAction)addEventHandler:(id)sender {
	[self addEvent];
}

-(void)addEvent{
    //TestAddStudyEvent *vc = [[[TestAddStudyEvent alloc] initWithNibName:nil bundle:nil ] autorelease];
    AddStudyEvent *vc = [[AddStudyEvent alloc] initWithNibName:@"AddStudyEvent" bundle:nil];
    vc.title = @"Create New Event";
    //[[[ShowcaseController alloc] initWithNibName:nil bundle:nil formDataSource:showcaseDataSource] autorelease];
    //addStudyEvent.delegate = self;
    //vc.title = @"New Event";
    vc.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)dealloc {
    [categoryList release];
    
	if(query != nil)
		[query release];
    [super dealloc];
}

@end
