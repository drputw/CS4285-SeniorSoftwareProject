//
//  SettingsViewController.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "SettingsViewController.h"
#import "AboutViewController.h"
#import "StudyViewController.h"
#import "TutorEditProfile.h"
#import "TutorMeAppDelegate.h"

@implementation SettingsViewController

@synthesize tutorSwitch;

- (void)tutorSwitchChanged {
    if(tutorSwitch.on)
    {
        [self startQuery];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Tutor Profile Enabled"
                               message:@"You will now show up in the list of active tutors"
                               delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
    }
    else 
    {
        [self startQuery];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Tutor Profile Disabled"
                                   message:@"You will no longer show up in the list of active tutors"
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
    }
}

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
    
    
    tutorSwitch = [[UISwitch alloc] init];
    [tutorSwitch setOn:YES animated:YES];
    [tutorSwitch addTarget:self action:@selector(tutorSwitchChanged) forControlEvents:UIControlEventValueChanged];
    //tutorSwitch.on = TRUE;
 /*   if(toggleSwitch.on = FALSE)
    {
        UIAlertView *errorAlert = [[UIAlertView alloc]
								   initWithTitle:@"Internet Connection Required for this section of TUtorMe"
								   message:@"Please make sure you have an active internet connection"
								   delegate:nil
								   cancelButtonTitle:@"OK"
								   otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
    }
    */
	arryTutorProfileSection = [[NSArray alloc] initWithObjects:@"Enable Tutor",@"Edit Profile",nil];
	arryEventsSection = [[NSArray alloc] initWithObjects:@"Organized Events",@"Events Attending",nil];
    arryAboutSection = [[NSArray alloc] initWithObjects:@"About",nil];
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
        default:
            NSLog(@"Unknown query state");
    }
}

- (void) startQuery {
	query = [[TrinityRestQueryView alloc] initVars];
    [query loadingViewInView:[self.view.window.subviews objectAtIndex:0]];
   // NSLog(@"%@", categoryName);
    //if([categoryName  isEqualToString:@"All"])
    if(tutorSwitch.on)
        [query setQuery:@"UPDATE tm_User SET `isTutor` = 1 WHERE id =2" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
    else
        [query setQuery:@"UPDATE tm_User SET `isTutor` = 0 WHERE id =2" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
	//query.showLoadingView = TRUE;
	[query startQuery];
    
}

- (void) checkQueryStatus {
	if(queryRunning) {
		[self startQuery];
		queryRunning = FALSE;
	}
}


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
		return [arryTutorProfileSection count];
	else if(section == 1)
		return [arryEventsSection count];
    else
        return [arryAboutSection count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if(section == 0)
		return @"Tutor Profile";
	else if(section == 1)
		return @"Events";
    else
        return @"";
	
}

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
		cell.textLabel.text= [arryTutorProfileSection objectAtIndex:indexPath.row];
        if(indexPath.row == 0)
        {
            cell.accessoryView = [[UIView alloc] initWithFrame:tutorSwitch.frame];
            [cell.accessoryView addSubview:tutorSwitch];
            //toggleSwitch.on = TRUE;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
	else if(indexPath.section == 1)
		cell.textLabel.text = [arryEventsSection objectAtIndex:indexPath.row];
	else
        cell.textLabel.text = [arryAboutSection objectAtIndex:indexPath.row];
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
        vc.queryType = @"Organized Events";
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    if(indexPath.section == 1 & indexPath.row == 1)
    {
        StudyViewController *vc = [[StudyViewController alloc] initWithNibName:@"StudyViewController" bundle:nil];
        vc.title = @"Events Attending";
        vc.addButton = nil;
        vc.queryType = @"Events Attending";
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