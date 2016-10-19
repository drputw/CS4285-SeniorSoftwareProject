//
//  TutorDetailViewController.m
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "TutorDetailViewController.h"
#import "Tutor.h"
#import "TutorMeAppDelegate.h"

@implementation TutorDetailViewController

@synthesize scrollView, message, tutorName, tutorClass, tutorEmail, tutorMajor, tutorPhone, emailRecipient, iconView, callButton, tutorDescription, tutorAvailability, tutorMajorTop;


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
	
	[picker setSubject:@"TUtorMe Inquiry"];
	
    
	// Set up recipients
	//NSArray *toRecipients = [NSArray arrayWithObject:@"jseales@trinity.edu"]; 
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
	NSString *recipients = @"mailto:jseales@trinity.edu&subject=TUtorMe Inquiry";
	NSString *body = @"&body=";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

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
    scrollView.clipsToBounds = YES;
	[scrollView setScrollEnabled:YES];
	scrollView.contentSize=CGSizeMake(320,500);
    
    TutorMeAppDelegate *del = (TutorMeAppDelegate *)[UIApplication sharedApplication].delegate;
    Tutor *t = del.tutor;
    
    [tutorName setText:[t.firstName stringByAppendingString:[@" " stringByAppendingString:t.lastName]]];
    if([t.major1 length] != 0 && [t.major2 length] == 0 && [t.major3 length] == 0 && [t.major4 length] == 0)
    {
        [tutorMajor setText:t.major1];
    }
    else if([t.major1 length] != 0 && [t.major2 length] != 0 && [t.major3 length] == 0 && [t.major4 length] == 0)
    {
        [tutorMajor setText:[t.major1 stringByAppendingString:[@", " stringByAppendingString:t.major2]]];
    }
    else if([t.major1 length] != 0 && [t.major2 length] != 0 && [t.major3 length] != 0 && [t.major4 length] == 0)
    {
        [tutorMajor setText:[t.major1 stringByAppendingString:[@", " stringByAppendingString:[t.major2 stringByAppendingString:[@", " stringByAppendingString:t.major3]]]]];
    }
    else
    {
        [tutorMajor setText:[t.major1 stringByAppendingString:[@", " stringByAppendingString:[t.major2 stringByAppendingString:[@", " stringByAppendingString:[t.major3 stringByAppendingString:[@", " stringByAppendingString:t.major4]]]]]]];
    }
    NSString *iconPath = t.major1;
    iconView.image = [UIImage imageNamed:iconPath];
    [tutorClass setText:t.rank];
    [tutorEmail setText:t.email];
    [tutorPhone setText:t.phone];
    [tutorDescription setText:t.description];
    [tutorAvailability setText:t.availability];
    emailRecipient = t.email;
    
    NSLog(@"%@", tutorPhone.text);
    
    if([tutorPhone.text length] == 0)
    {
        callButton.enabled = FALSE;
		callButton.alpha = 0.5f;
    }
        
}

-(IBAction)callPhone:(id)sender {
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:8322836519"]];
    NSString *phoneString = [@"tel:" stringByAppendingString:tutorPhone.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc {
    [tutorName release];
    [tutorMajor release];
    [tutorClass release];
    [tutorEmail release];
    [tutorPhone release];
    [tutorAvailability release];
    [tutorDescription release];
    [super dealloc];
}

@end
