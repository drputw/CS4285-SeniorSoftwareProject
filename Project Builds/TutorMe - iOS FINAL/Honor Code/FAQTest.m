//
//  FAQTest.m
//  TutorMe
//
//  Created by James Seales on 12/5/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import "FAQTest.h"
#import "FAQAnswers.h"

@implementation FAQTest

@synthesize data, dataSpecial, answer, question;

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
    
    NSString *dataPath2 = [[NSBundle mainBundle] pathForResource:@"FAQuestions" ofType:@"plist"];
    self.dataSpecial = [NSArray arrayWithContentsOfFile:dataPath2];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [dataSpecial count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
		return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell..
    if(indexPath.section == 0){
        NSDictionary *dataItem = [dataSpecial objectAtIndex:indexPath.row];
        cell.textLabel.text = [dataItem objectForKey:@"Major"];
        cell.textLabel.numberOfLines = 0;
    }
    //if(indexPath.section == 1){
      //  NSDictionary *dataItem1 = [data objectAtIndex:indexPath.row];
       // cell.textLabel.text = [dataItem1 objectForKey:@"Major"];
    //}
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
    FAQAnswers *vc = [[FAQAnswers alloc] initWithNibName:@"FAQAnswers" bundle:nil];
    vc.title = @"Answer";
    if(indexPath.row == 0)
    {
        answer = @"There are three mitigating factors which could influence your sanction. The first factor is the amount of plagiarism; the second is cooperation before and during a hearing, including entering a plea of responsible; and the third is “extenuating circumstances”. All of these factors are dependent upon the individual case and may not be used at all if the hearing panel does not find them applicable.";
        vc.answer = answer;
        question = @"What are the mitigating factors that could influence my sanction if found responsible?";
        vc.question = question;
    }
    else if(indexPath.row == 1)
    {
        answer = @"The easiest way to make sure everything with your assignment is in order is to talk with your professors.  They are the ones grading what you turn in, so they know what they expect.  If the professor is unclear or other ambiguities present themselves, ask questions. You can always email the Honor Council to ask questions about proper citations. Finally, consult a style guide such as the MLA Handbook, or the Writing Center in the library.";
        vc.answer = answer;
        question = @"Who can I talk to about acceptable citations before turning in an assignment?";
        vc.question = question;
    }
    else if(indexPath.row == 2)
    {
        answer = @"The Academic Honor Council deals strictly with academic integrity violations that occur at any time during any class offered at Trinity. We have nothing to do with other conduct related violations, such as getting written up for possession of alcohol.";
        vc.answer = answer;
        question = @"What violations are covered by the AHC?";
        vc.question = question;
    }
    else if(indexPath.row == 3)
    {
        answer = @"An email will be sent to you informing you that a complaint has been filed and accepted. Contained within this email will be information regarding the date and time of your hearing. An advocate-presenter will also get in contact with you to help you prepare for the hearing. The advocate-presenter is not a legal representative and will only present relevant evidence that you supply.";
        vc.answer = answer;
        question = @"What happens when a complaint is filed against me?";
        vc.question = question;
    }
    if(indexPath.row == 4)
    {
        answer = @"Once a sanction has been issued, there are two ways in which a sanction may be appealed. The first is if a procedural error occurred during the hearing; however, two faculty advisors are present during each hearing to call points-of-order, which are designed to prevent such errors from occurring. The second option is if you discover new evidence or witnesses, which completely changes the nature of the case.";
        vc.answer = answer;
        question = @"What recourse do I have to appeal a sanction?";
        vc.question = question;
    }
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

@end
