//
//  SettingsViewController.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "AboutViewController.h"
#import "StudyViewController.h"
#import "TutorEditProfile.h"

@implementation SettingsViewController

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
	arryAppleProducts = [[NSArray alloc] initWithObjects:@"Enable Tutor",@"Edit Profile",nil];
	arryAdobeSoftwares = [[NSArray alloc] initWithObjects:@"Organized Events",@"Events Attending",nil];
    arrySettings = [[NSArray alloc] initWithObjects:@"About",nil];
	//self.title = @"Simple Table Exmaple";
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
    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section == 0)
		return [arryAppleProducts count];
	else if(section == 1)
		return [arryAdobeSoftwares count];
    else
        return [arrySettings count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if(section == 0)
		return @"Tutor Profile";
	else if(section == 1)
		return @"Events";
    else
        return @"";
	
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	if(indexPath.section == 0)
    { 
		cell.textLabel.text= [arryAppleProducts objectAtIndex:indexPath.row];
        if(indexPath.row == 0)
        {
            UISwitch *toggleSwitch = [[UISwitch alloc] init];
            cell.accessoryView = [[UIView alloc] initWithFrame:toggleSwitch.frame];
            [cell.accessoryView addSubview:toggleSwitch];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
	else if(indexPath.section == 1)
		cell.textLabel.text = [arryAdobeSoftwares objectAtIndex:indexPath.row];
	else
        cell.textLabel.text = [arrySettings objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 & indexPath.row == 1)
    {
        TutorEditProfile *vc = [[TutorEditProfile alloc] initWithNibName:@"TutorEditProfile" bundle:nil];
        vc.title = @"Edit Profile";
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    if(indexPath.section == 1 & indexPath.row == 0)
    {
        StudyViewController *vc = [[StudyViewController alloc] initWithNibName:@"StudyViewController" bundle:nil];
        vc.title = @"Organized Events";
        vc.addButton = nil;
        vc.dataPath = [[NSBundle mainBundle] pathForResource:@"StudyDataOrganized" ofType:@"plist"];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    if(indexPath.section == 1 & indexPath.row == 1)
    {
        StudyViewController *vc = [[StudyViewController alloc] initWithNibName:@"StudyViewController" bundle:nil];
        vc.title = @"Events Attending";
        vc.addButton = nil;
        vc.dataPath = [[NSBundle mainBundle] pathForResource:@"StudyDataAttending" ofType:@"plist"];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    if(indexPath.section == 2 & indexPath.row == 0)
    {
        AboutViewController *vc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
        vc.title = @"About";
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}

@end