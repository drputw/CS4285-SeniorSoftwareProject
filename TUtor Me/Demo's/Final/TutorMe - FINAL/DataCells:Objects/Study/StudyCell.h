//
//  StudyCell.h
//  TutorMe
//
//  Created by James Seales on 10/11/11.
//  Copyright (c) Senior Software Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ApplicationCell.h>

@interface StudyCell : ApplicationCell
{
    IBOutlet UIImageView *iconView;
    IBOutlet UILabel *subjectLabel;
    IBOutlet UILabel *organizerLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *monthLabel;
    IBOutlet UILabel *dayLabel;
}

@end
