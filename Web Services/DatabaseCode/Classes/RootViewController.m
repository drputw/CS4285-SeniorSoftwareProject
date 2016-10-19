//
//  RootViewController.m
//  MovieTable
//
//  Created by Mark Robinson on 2/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize movieEditor;
@synthesize sortControl;
@synthesize nibLoadedCell;

#pragma mark -
#pragma mark View lifecycle

-(void) sortMoviesArray {
	NSSortDescriptor *sorter;
	switch (sortControl.selectedSegmentIndex) {
		case 0: //sort alpha asc
			sorter = [[NSSortDescriptor alloc] initWithKey: @"title" ascending: YES];
			break;
		case 1: //sort alpha desc
			sorter = [[NSSortDescriptor alloc] initWithKey: @"title" ascending: NO];
			break;
		case 2: //sort $$ asc
		default:
			sorter = [[NSSortDescriptor alloc] initWithKey: @"boxOfficeGross" ascending: YES];
			break;
	}
	NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
	[moviesArray sortUsingDescriptors:sortDescriptors];
	[sorter release];
}

-(IBAction) handleSortChanged {
	[self sortMoviesArray];
	[self.tableView reloadData];
}

-(IBAction) handleAddTapped {
	Movie *newMovie = [[Movie alloc] init];
	editingMovie = newMovie;
	movieEditor.movie = editingMovie;
	[self.navigationController pushViewController:movieEditor animated: YES];
	[moviesArray addObject: newMovie];
	NSIndexPath *newMoviePath = [NSIndexPath indexPathForRow: [moviesArray count] - 1 inSection: 0];
	NSArray *newMoviePaths = [NSArray arrayWithObject: newMoviePath];
	[self.tableView insertRowsAtIndexPaths:newMoviePaths withRowAnimation:NO];
	[newMovie release];
	
	//self.queryProgressViewController.query = query;
	//[self presentModalViewController:self.queryProgressViewController animated:YES];
	//[self presentSemiModalViewController:queryProgressViewController];
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
			//NSLog(@"Success!");
			moviesArray = [[NSMutableArray alloc] init];
			resultArray = [query getResultArray];
			//[query getNumSelectRowsFetched]
			for(int i = 0; i < [query getNumSelectRowsFetched]; i++) {
				NSMutableDictionary *currentDict = [resultArray objectAtIndex:i];
				Movie *aMovie = [[Movie alloc] init];
				aMovie.title = [[NSString alloc] initWithFormat: @"%@", [currentDict objectForKey:@"testname"]];
				aMovie.boxOfficeGross = [currentDict objectForKey:@"age"];//[NSNumber numberWithInt: [currentDict objectForKey:@"Phone"]];//[NSNumber numberWithInt:191796233];
				aMovie.summary = [[NSString alloc] initWithFormat: @"%@", [currentDict objectForKey:@"testname"]];
				//aMovie.title = [[NSString alloc] initWithFormat: @"%@", [currentDict objectForKey:@"Name"]];//[currentDict objectForKey:@"testname"]];
				//aMovie.boxOfficeGross = [currentDict objectForKey:@"Phone"];//[NSNumber numberWithInt: [currentDict objectForKey:@"Phone"]];//[NSNumber numberWithInt:191796233];
				//aMovie.summary = [[NSString alloc] initWithFormat: @"%@", [currentDict objectForKey:@"Name"]];//[currentDict objectForKey:@"testname"]];
				[moviesArray addObject: aMovie];
				[aMovie release];
			}
			[self sortMoviesArray];
			[self.tableView reloadData];
			break;
		default:
			NSLog(@"Unknown query state");
	}
}

- (void) startQuery {
	resultArray = nil;
	//query = [[[TrinityRestQuery alloc] initWithQuery:@"SELECT * FROM test1 WHERE age_indexed = ? and testname like ?" withArgs:@"55|b%" teamnumber:5 target:self selector:@selector(queryFinish)] autorelease];		
	query = [[TrinityRestQueryView alloc] initVars];
	[query loadingViewInView:[self.view.window.subviews objectAtIndex:0]];
	//[query setQuery:@"SELECT * FROM test1 WHERE age_indexed = ? and testname like ?" withArgs:@"55|b%" teamnumber:11 target:self selector:@selector(queryFinish)];
    [query setQuery:@"SELECT * FROM test1" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
	//query.showLoadingView = TRUE;
	[query startQuery];

	//query = [[[TrinityRestQuery alloc] initWithQuery:@"INSERT INTO test2 (testname,age,birthday) VALUES(?,?,?)" withArgs:@"Jimbob X Smith|\90|1920-12-04" target:self selector:@selector(queryFinish)] autorelease];
	//query = [[[TrinityRestQuery alloc] initWithQuery:@"" withArgs:@"2" target:self selector:@selector(queryFinish)] autorelease];
	//query = [[[TrinityRestQuery alloc] initWithQuery:@"SELECT * FROM test2 WHERE age = ?" withArgs:@"90" target:self selector:@selector(queryFinish)] autorelease];	
	//[query setQueryText:@"SELECT * FROM test1 WHERE age_indexed = ? and testname like ?" withArgs:@"555|b%"];
	//[query setQueryText:@"SELECT * FROM test1 WHERE age_indexed = ? and testname like ?" withArgs:@"55|b%"];
	//[query setQueryText:@"UPDATE test2 SET age = ? WHERE id = ?" withArgs:@"44|3"];
	//[query setQueryText:@"INSERT INTO test2 (testname,age,birthday) VALUES(?,?,?)" withArgs:@"Jimbob Smith|\90|1920-12-04"];

	//[query setQueryText:@"DELETE FROM test2 WHERE id = ?" withArgs:@"2"];
	
	//NSLog(@"query inits state to %d", [query getQueryState]);

}

- (void) checkQueryStatus {
	if(queryRunning) {
		[self startQuery];
		queryRunning = FALSE;
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	queryRunning = FALSE;
	myTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(checkQueryStatus) userInfo:nil repeats:YES];
	queryRunning = TRUE;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	if(editingMovie) {
		NSIndexPath *updatedPath = [NSIndexPath indexPathForRow: [moviesArray indexOfObject: editingMovie] inSection:0];
		NSArray *updatedPaths = [NSArray arrayWithObject: updatedPath];
		[self.tableView reloadRowsAtIndexPaths:updatedPaths withRowAnimation:NO];
		editingMovie = nil;
	}
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [moviesArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[[NSBundle mainBundle] loadNibNamed:@"MovieTableCell" owner:self options:NULL];
		cell = nibLoadedCell;
    }
    
	// Configure the cell.
	Movie *aMovie = [moviesArray objectAtIndex:indexPath.row];
	UILabel *titleLabel = (UILabel*) [cell viewWithTag:1];
	titleLabel.text = aMovie.title;
	UILabel *boxOfficeLabel = (UILabel*) [cell viewWithTag:2];
	boxOfficeLabel.text = [NSString stringWithFormat: @"%d", [aMovie.boxOfficeGross intValue]];
	UILabel *summaryLabel = (UILabel *) [cell viewWithTag:3];
	summaryLabel.text = aMovie.summary;
	//cell.textLabel.text = aMovie.title;
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		[moviesArray removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    editingMovie = [moviesArray objectAtIndex: indexPath.row];
	movieEditor.movie = editingMovie;
	[self.navigationController pushViewController:movieEditor animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)drawRect:(CGRect)rect {
	rect.size.height -= 1;
	rect.size.width -= 1;
	
	const CGFloat RECT_PADDING = 8.0;
	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
	
	const CGFloat ROUND_RECT_CORNER_RADIUS = 5.0;
	CGPathRef roundRectPath = NewPathWithRoundRect(rect, ROUND_RECT_CORNER_RADIUS);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	const CGFloat BACKGROUND_OPACITY = 0.55;
	CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextFillPath(context);
	
	const CGFloat STROKE_OPACITY = 0.25;
	CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextStrokePath(context);
	
	CGPathRelease(roundRectPath);
}

- (void)dealloc {
	if(query != nil)
		[query release];
    [super dealloc];
}


@end