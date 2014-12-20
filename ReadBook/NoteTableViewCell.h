//
//  NoteTableViewCell.h
//  ReadBook
//
//  Created by student on 14-12-17.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewCell : UITableViewCell
- (IBAction)showNoteDetail:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *personName;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UILabel *groubName;
@property (weak, nonatomic) IBOutlet UIButton *look;
@property (weak, nonatomic) IBOutlet UIImageView *groupAvatar;

@end
