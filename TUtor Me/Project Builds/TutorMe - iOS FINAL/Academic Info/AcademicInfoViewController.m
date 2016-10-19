//
//  AcademicInfoViewController.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "AcademicInfoViewController.h"
#import "CodeViewController.h"
#import "PhilosophyViewController.h"
#import "FAQTest.h"
#import "CalendarViewController.h"

@implementation AcademicInfoViewController

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	arryAcademicCalendar = [[NSArray alloc] initWithObjects:@"Fall 2011",@"Spring 2012",nil];
	arryHonorCode = [[NSArray alloc] initWithObjects:@"The Code",@"Philosophy and Background",@"FAQ's",nil];
    [super viewDidLoad];
}



/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section == 0)
		return [arryAcademicCalendar count];
	else
		return [arryHonorCode count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if(section == 0)
		return @"Academic Calendar";
	else
		return @"Honor Code";
	}
/*
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //if(indexPath.section == 0)
    //   return UITableViewCellAccessoryCheckmark;
    //else
    return UITableViewCellAccessoryDisclosureIndicator;
}

 - (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
 if(section == 0){
 return @"Footer for Apple Products";
 }else{
 return @"Footer for Adobe Softwares";
 }
 }
 */

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	if(indexPath.section == 0)
		cell.textLabel.text = [arryAcademicCalendar objectAtIndex:indexPath.row];
	else
		cell.textLabel.text = [arryHonorCode objectAtIndex:indexPath.row];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel sizeToFit];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     
     if(indexPath.section == 0 & indexPath.row == 0)
     {
         CalendarViewController *vc = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
         vc.title = @"Fall 2011";
         vc.dataPath = [[NSBundle mainBundle] pathForResource:@"CalendarFall" ofType:@"plist"];
         [self.navigationController pushViewController:vc animated:YES];
         [vc release];
     }
     if(indexPath.section == 0 & indexPath.row == 1)
     {
         CalendarViewController *vc = [[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
         vc.title = @"Spring 2012";
         vc.dataPath = [[NSBundle mainBundle] pathForResource:@"CalendarSpring" ofType:@"plist"];
         [self.navigationController pushViewController:vc animated:YES];
         [vc release];
     }
     if(indexPath.section == 1 & indexPath.row == 0)
     {
         CodeViewController *vc = [[CodeViewController alloc] initWithNibName:@"CodeViewController" bundle:nil];
         vc.title = @"The Code";
         [self.navigationController pushViewController:vc animated:YES];
         [vc release];
     }   
     if(indexPath.section == 1 & indexPath.row == 1)
     {
         PhilosophyViewController *vc = [[PhilosophyViewController alloc] initWithNibName:@"PhilosophyViewController" bundle:nil];
         vc.title = @"Philosophy and Background";
         [self.navigationController pushViewController:vc animated:YES];
         [vc release];
     } 
     if(indexPath.section == 1 & indexPath.row == 2)
     {
         FAQTest *vc = [[FAQTest alloc] initWithNibName:@"FAQTest" bundle:nil];
         vc.title = @"FAQ";
         [self.navigationController pushViewController:vc animated:YES];
         [vc release];
     } 
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
 }
 
@end

