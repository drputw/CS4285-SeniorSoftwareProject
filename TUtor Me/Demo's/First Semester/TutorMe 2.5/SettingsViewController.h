//
//  SettingsViewController.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	//IBOutlet UITableView *tblSimpleTable;
	NSArray *arryAppleProducts;
	NSArray *arryAdobeSoftwares;
    NSArray *arrySettings;
}

@end