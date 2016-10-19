//
//  StudyDetailViewController.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "StudyDetailViewController.h"
#import "TutorMeAppDelegate.h"
#import "Study.h"
#import "SVProgressHUD.h"

@implementation StudyDetailViewController

@synthesize scrollView, message, organizerName, organizerClass, organizerEmail, organizerPhone, eventTitle, emailRecipient, callButton, eventDescription, eventEndDate, eventLocation, eventStartDate, eventSubject, rsvpButton, eventID, rsvp, studyList, rsvpCount, month, date, icon;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    // Do any additional setup after loading the view from its nib.
    rsvp = @"no";
    scrollView.clipsToBounds = YES;
	[scrollView setScrollEnabled:YES];
	scrollView.contentSize=CGSizeMake(320,405);
    
    TutorMeAppDelegate *del = (TutorMeAppDelegate *)[UIApplication sharedApplication].delegate;
    Study *s = del.study;
    
    [organizerName setText:[s.firstName stringByAppendingString:[@" " stringByAppendingString:s.lastName]]];
    eventID = s.eventID;
    [eventTitle setText:s.title];
    if([s.className length] == 0)
        [organizerClass setText:@"(Not Specified)"];
    else
        [organizerClass setText:[s.classNumber stringByAppendingString:[@" " stringByAppendingString:s.className]]];
    [organizerEmail setText:s.email];
    [organizerPhone setText:s.phone];
    [eventDescription setText:s.description];
    [eventLocation setText:s.location];
    [eventStartDate setText:s.startDate];
    [eventEndDate setText:s.endDate];
    [eventSubject setText:s.subject];
    emailRecipient = s.email;
    rsvpCount = [s.rsvp intValue];
    [month setText:s.month];
    [date setText:s.day];
    [rsvpButton setTitle:[s.rsvp stringByAppendingString:[@" " stringByAppendingString:@"RSVP's"]] forState: UIControlStateNormal];
    if([organizerPhone.text length] == 0)
    {
        callButton.enabled = FALSE;
		callButton.alpha = 0.5f;
    }
}

-(IBAction)rsvpPressed:(id)sender {
        if([rsvp isEqualToString:@"no"])
        {
            rsvpCount++;
            NSString *string = [NSString stringWithFormat:@"%d", rsvpCount];
            [rsvpButton setTitle:[string stringByAppendingString:[@" " stringByAppendingString:@"RSVP's"]] forState: UIControlStateNormal];
            [SVProgressHUD showWithStatus:@"Loading"];
            sleep(.1);
            [SVProgressHUD dismissWithSuccess:@"You are now RSVP'd for this event!"];
            [self startQuery];
        }
        else 
        {
            rsvpCount--;
            NSString *string = [NSString stringWithFormat:@"%d", rsvpCount];
            [rsvpButton setTitle:[string stringByAppendingString:[@" " stringByAppendingString:@"RSVP's"]] forState: UIControlStateNormal];
            [SVProgressHUD showWithStatus:@"Loading"];
            sleep(.1);
            [SVProgressHUD dismissWithError:@"You are no longer RSVP'd for this event!"];
            [self startQuery];
        }
}

-(IBAction)callPhone:(id)sender {
    NSString *phoneString = [@"tel:" stringByAppendingString:organizerPhone.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
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
        default:
            NSLog(@"Unknown query state");
    }
}

- (void) startQuery {
	query = [[TrinityRestQueryView alloc] initVars];
    [query loadingViewInView:[self.view.window.subviews objectAtIndex:0]];
    {
        if([rsvp isEqualToString:@"no"])
        {
            [query setQuery:@"INSERT INTO tm_RSVP (`event_ID`, `user_ID`) VALUES (?,2)"withArgs: eventID teamnumber:11 target:self selector:@selector(queryFinish)];
            rsvp = @"yes";
        }
        else if([rsvp isEqualToString:@"yes"])
        {
            [query setQuery:@"DELETE FROM `trinity2011team1`.`tm_RSVP` WHERE event_id = ? AND user_id  = 2"withArgs: eventID teamnumber:11 target:self selector:@selector(queryFinish)];
            rsvp = @"no";
        }
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)showPicker:(id)sender
{	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
}


#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"TUtorMe Study Event Inquiry"];
	
    
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:emailRecipient]; 
	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil]; 
	//NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"]; 
	
	[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];	
	//[picker setBccRecipients:bccRecipients];
    /*	
     // Attach an image to the email
     NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
     NSData *myData = [NSData dataWithContentsOfFile:path];
     [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
     */
	// Fill out the email body text
	NSString *emailBody = @"";
	[picker setMessageBody:emailBody isHTML:NO];
	
    picker.navigationBar.tintColor = [UIColor darkGrayColor];
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			message.text = @"Result: failed";
			break;
		default:
			message.text = @"Result: not sent";
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:jseales@trinity.edu&subject=TUtorMe Study Event Inquiry";
	NSString *body = @"&body=";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}


@end
