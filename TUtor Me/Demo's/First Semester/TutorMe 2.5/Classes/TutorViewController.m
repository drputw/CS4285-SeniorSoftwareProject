//
//  TutorViewController.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TutorViewController.h"
#import "TutorDetailViewController.h"


/*
 Predefined colors to alternate the background color of each cell row by row
 (see tableView:cellForRowAtIndexPath: and tableView:willDisplayCell:forRowAtIndexPath:).
 */
#define DARK_BACKGROUND  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0]
#define LIGHT_BACKGROUND [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0]


@implementation TutorViewController

@synthesize tmpCell, data, cellNib, filteredListContent;


#pragma mark -
#pragma mark View controller methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
	
	// Configure the table view.
    self.tableView.rowHeight = 73.0;
    self.tableView.backgroundColor = DARK_BACKGROUND;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
	// Load the data.
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"TutorData" ofType:@"plist"];
    self.data = [NSArray arrayWithContentsOfFile:dataPath];
	
	// create our UINib instance which will later help us load and instanciate the
	// UITableViewCells's UI via a xib file.
	//
	// Note:
	// The UINib classe provides better performance in situations where you want to create multiple
	// copies of a nib file’s contents. The normal nib-loading process involves reading the nib file
	// from disk and then instantiating the objects it contains. However, with the UINib class, the
	// nib file is read from disk once and the contents are stored in memory.
	// Because they are in memory, creating successive sets of objects takes less time because it
	// does not require accessing the disk.
	//
	self.cellNib = [UINib nibWithNibName:@"TutorCell" bundle:nil];
    
    // create a filtered list that will contain products for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.data count]];
    
    
}

- (void)viewDidUnload
{
	[super viewDidLoad];
	
	self.data = nil;
	self.tmpCell = nil;
	self.cellNib = nil;
    self.filteredListContent = nil;
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
        return [data count];
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
        
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            cell = [self.filteredListContent objectAtIndex:indexPath.row];
        }
    }
	// Display dark and light background in alternate rows -- see tableView:willDisplayCell:forRowAtIndexPath:.
    cell.useDarkBackground = (indexPath.row % 2 == 0);
	
	// Configure the data for the cell.
    NSDictionary *dataItem = [data objectAtIndex:indexPath.row];
    cell.icon = [UIImage imageNamed:[dataItem objectForKey:@"Icon"]];
    cell.major = [dataItem objectForKey:@"Major"];
    cell.name = [dataItem objectForKey:@"Name"];
    cell.rank = [dataItem objectForKey:@"Rank"];
   // cell.numRatings = [[dataItem objectForKey:@"NumRatings"] intValue];
   // cell.rating = [[dataItem objectForKey:@"Rating"] floatValue];
    //cell.price = [dataItem objectForKey:@"Price"];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = ((ApplicationCell *)cell).useDarkBackground ? DARK_BACKGROUND : LIGHT_BACKGROUND;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ApplicationCell *cell = nil;
     //UIViewController *detailsViewController = [[UIViewController alloc] init];
    //detailsViewController.title = cell.name;
    //[[self navigationController] pushViewController:TutorDetailViewController animated:YES];
    //[detailsViewController release];
    TutorDetailViewController *vc = [[TutorDetailViewController alloc] initWithNibName:@"TutorDetailViewController" bundle:nil];
    //vc.descTemp = tempDescription;
    //vc.imageNameTemp = tempImageName;
    //vc.title = cell.name;
    //vc.title = @"James Seales";
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (ApplicationCell *cell in data)
	{
			NSComparisonResult result = [cell.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
			{
				[self.filteredListContent addObject:cell];
            }
		}
	}


#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    [data release];
	[tmpCell release];
	[cellNib release];
    [filteredListContent release];
	
    [super dealloc];
}

@end