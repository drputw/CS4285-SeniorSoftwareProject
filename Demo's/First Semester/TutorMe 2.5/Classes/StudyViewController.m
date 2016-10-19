//
//  StudyViewController.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StudyViewController.h"
#import "StudyDetailViewController.h"
#import "AddStudyEvent.h"


/*
 Predefined colors to alternate the background color of each cell row by row
 (see tableView:cellForRowAtIndexPath: and tableView:willDisplayCell:forRowAtIndexPath:).
 */
#define DARK_BACKGROUND  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0]
#define LIGHT_BACKGROUND [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0]


@implementation StudyViewController

@synthesize tmpCell, data, cellNib, addButton, dataPath;


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
    //dataPath = [[NSBundle mainBundle] pathForResource:@"StudyData" ofType:@"plist"];
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
	self.cellNib = [UINib nibWithNibName:@"StudyCell" bundle:nil];
    
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

- (void)viewDidUnload
{
	[super viewDidLoad];
	
	self.data = nil;
	self.tmpCell = nil;
	self.cellNib = nil;
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
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplicationCellEvent";
    
    ApplicationCellEvent *cell = (ApplicationCellEvent *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil)
    {
        [self.cellNib instantiateWithOwner:self options:nil];
		cell = tmpCell;
		self.tmpCell = nil;
    }
    
	// Display dark and light background in alternate rows -- see tableView:willDisplayCell:forRowAtIndexPath:.
    cell.useDarkBackground = (indexPath.row % 2 == 0);
	
	// Configure the data for the cell.
    NSDictionary *dataItem = [data objectAtIndex:indexPath.row];
    cell.icon = [UIImage imageNamed:[dataItem objectForKey:@"Icon"]];
    cell.number = [dataItem objectForKey:@"Class Number"];
    cell.classname = [dataItem objectForKey:@"Class Name"];
    cell.organizer = [dataItem objectForKey:@"Organizer"];
    cell.month = [dataItem objectForKey:@"Month"];
    cell.day = [dataItem objectForKey:@"Day"];
    // cell.numRatings = [[dataItem objectForKey:@"NumRatings"] intValue];
    // cell.rating = [[dataItem objectForKey:@"Rating"] floatValue];
    //cell.price = [dataItem objectForKey:@"Price"];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = ((ApplicationCellEvent *)cell).useDarkBackground ? DARK_BACKGROUND : LIGHT_BACKGROUND;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StudyDetailViewController *vc = [[StudyDetailViewController alloc] initWithNibName:@"StudyDetailViewController" bundle:nil];
    //vc.descTemp = tempDescription;
    //vc.imageNameTemp = tempImageName;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    [data release];
	[tmpCell release];
	[cellNib release];
	
    [super dealloc];
}


@end
