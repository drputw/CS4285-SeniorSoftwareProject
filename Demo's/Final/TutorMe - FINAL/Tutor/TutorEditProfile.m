//
//  TutorEditProfile.m
//  TutorMe
//
//  Created by James Seales on 11/3/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "TutorEditProfile.h"
#import "TutorCategoryViewController.h"

@implementation TutorEditProfile

@synthesize scrollView, major1, major2, major3, major4, description, availability, availabilityTextView, descriptionTextView, saving, phoneTextField, phone, major1TextField, major2TextField, major3TextField, major4TextField, majors;

const int major1PickerTag = 3001;
const int major2PickerTag = 3002;
const int major3PickerTag = 3003;
const int major4PickerTag = 3004;


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

-(IBAction)cancelPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)savePressed:(id)sender {
    saving = @"yes";
    
    description = descriptionTextView.text;
    availability = availabilityTextView.text;
    phone = phoneTextField.text;
    major1 = major1TextField.text;
    major2 = major2TextField.text;
    major3 = major3TextField.text;
    major4 = major4TextField.text;
    if([description length] == 0)
        [self showOKAlert:@"Invalid Description" withMessage:@"Please enter a description, it is a requred field"];
    else if([availability length] == 0)
        [self showOKAlert:@"Invalid Availability" withMessage:@"Please enter availability, it is a requred field"];
    else if([phone length] != 0 && [phone length] != 10)
        [self showOKAlert:@"Invalid Phone Number" withMessage:@"Please enter a valid 10 digit phone number"];
    else
    {
        [self startQuery];
        saving = @"no";
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    scrollView.clipsToBounds = YES;
	[scrollView setScrollEnabled:YES];
	scrollView.contentSize=CGSizeMake(320,653);
    [self startQuery];
    self.navigationItem.hidesBackButton = YES;
    
    //TutorCategoryViewController *vc = [[TutorCategoryViewController alloc] initWithNibName:@"TutorViewController" bundle:nil];
    //majors = [[NSMutableArray alloc] initWithObjects:vc.categoryArray, nil];
    //NSLog(@"%@", majors);
    
    // Assign pickers to selected text fields
    UIPickerView *major1Picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    major1Picker.tag = major1PickerTag;
    major1Picker.delegate = self;
    major1Picker.dataSource = self;
    [major1Picker setShowsSelectionIndicator:YES];
    major1TextField.inputView = major1Picker;
    [major1Picker release];
    
    UIPickerView *major2Picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    major2Picker.tag = major2PickerTag;
    major2Picker.delegate = self;
    major2Picker.dataSource = self;
    [major2Picker setShowsSelectionIndicator:YES];
    major2TextField.inputView = major2Picker;
    [major2Picker release];
    
    UIPickerView *major3Picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    major3Picker.tag = major3PickerTag;
    major3Picker.delegate = self;
    major3Picker.dataSource = self;
    [major3Picker setShowsSelectionIndicator:YES];
    major3TextField.inputView = major3Picker;
    [major3Picker release];
    
    UIPickerView *major4Picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    major4Picker.tag = major4PickerTag;
    major4Picker.delegate = self;
    major4Picker.dataSource = self;
    [major4Picker setShowsSelectionIndicator:YES];
    major4TextField.inputView = major4Picker;
    [major4Picker release];
    
    // Set focus to the very top text field    
    [major1TextField becomeFirstResponder];
    
    // Prepare data for pickers
    majors = [NSArray arrayWithObjects:@"Anthropology", @"Art", @"Art History", @"Biology", 
                                  @"Biochemistry", @"Biochemistry and Molecular Biology", @"Business Administration", @"Chinese", @"Classical Studies", @"Communication",
                                  @"Computer Science", @"France", @"Greece", @"Ireland", @"Italy", @"Norway", @"Portugal",
                                  @"Poland", @"Slovenia", @"Sweden", nil];
    /*
    15	Economics
    16	Engineering Science
    17	English
    18	French
    19	Geosciences
    20	German
    21	Greek
    22	History
    23	International Studies
    24	Latin
    25	Mathematics
    26	Music
    27	Neuroscience
    28	Philosophy
    29	Physics and Astronomy
    30	Political Science
    31	Psychology
    32	Religion
    33	Russian
    34	Sociology
    35	Spanish
    37	Urban Studies
    38	Chemistry
    40	Environmental Studies
    41	Human Communication
    42	Theatre
    43	African American Studies
    44	American Intercultural Studies
    45	Biomathematics
    46	Cognitive Science
    47	Communication Management
    48	Comparative Literature
    49	Entrepreneurship
    50	Film Studies
    51	Linguistics
    52	Management Information Systems
    53	Medieval and Renaissance Studies
    54	New Media
    55	Sport Management
    56	Scientific Computing
    57	Women's and Gender Studies
    */
}

#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView.tag == major1PickerTag)
    {
        return [majors objectAtIndex:row];
    }
    else if (pickerView.tag == major2PickerTag)
    {
        return [majors objectAtIndex:row];
    }
    else if (pickerView.tag == major3PickerTag)
    {
        return [majors objectAtIndex:row];
    }
    else if (pickerView.tag == major4PickerTag)
    {
        return [majors objectAtIndex:row];
    }
    
    return @"Unknown title";
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == major1PickerTag)
    {
        major1TextField.text = (NSString *)[majors objectAtIndex:row];
    }
    else if (pickerView.tag == major2PickerTag)
    {
        major2TextField.text = (NSString *)[majors objectAtIndex:row];
    }
    else if (pickerView.tag == major3PickerTag)
    {
        major3TextField.text = (NSString *)[majors objectAtIndex:row];
    }
    else if (pickerView.tag == major4PickerTag)
    {
        major4TextField.text = (NSString *)[majors objectAtIndex:row];
    }
}

#pragma mark -

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return majors.count;
}

#pragma mark -

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
            if([saving  isEqualToString:@"yes"])
                sleep(.1);
            else 
            {
                resultArray = [query getResultArray];
                int numrows = [query getNumSelectRowsFetched];
                if(numrows == 0)
                {
                    [self showOKAlert:@"No Results Found" withMessage:@""];
                }
                NSLog(@"%d", numrows);
                for(int i = 0; i < [query getNumSelectRowsFetched]; i++) {
                    NSMutableDictionary *currentDict = [resultArray objectAtIndex:i];
                    major1TextField.text = [currentDict objectForKey:@"major"];
                    major2TextField.text = [currentDict objectForKey:@"major2"]; 
                    major3TextField.text = [currentDict objectForKey:@"major3"]; 
                    major4TextField.text = [currentDict objectForKey:@"major4"]; 
                   descriptionTextView.text = [currentDict objectForKey:@"description"];
                   availabilityTextView.text = [currentDict objectForKey:@"availability"];
                   phoneTextField.text = [currentDict objectForKey:@"phone"];
                }
                break;
            }
        default:
            NSLog(@"Unknown query state");
    }
}

- (void) startQuery {
	query = [[TrinityRestQueryView alloc] initVars];
    [query loadingViewInView:[self.view.window.subviews objectAtIndex:0]];
    if([saving  isEqualToString:@"yes"])
    {
         NSString *args = [description stringByAppendingString:[@"|" stringByAppendingString:[availability stringByAppendingString:[@"|" stringByAppendingString:phone]]]];
        [query setQuery:@"UPDATE tm_User SET description = ?, availability = ?, phone = ? WHERE id =2" withArgs:args teamnumber:11 target:self selector:@selector(queryFinish)];
    }
    else
        [query setQuery:@"SELECT user.id, user.phone, user.description, user.availability, major_1.major, major_2.major2, major_3.major3, major_4.major4 FROM tm_User AS user  INNER JOIN tm_Major AS major_1 ON major_1.id = user.major_1 LEFT JOIN tm_Major2 AS major_2 ON major_2.id = user.major_2 LEFT JOIN tm_Major3 AS major_3 ON major_3.id = user.major_3 LEFT JOIN tm_Major4 AS major_4 ON major_4.id = user.major_4 WHERE user.isTutor =1 AND user.id = 2" withArgs:@"" teamnumber:11 target:self selector:@selector(queryFinish)];
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
 
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
