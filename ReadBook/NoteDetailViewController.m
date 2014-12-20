//
//  NoteDetailViewController.m
//  ReadBook
//
//  Created by student on 14-12-17.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "RBBusiness.h"

@interface NoteDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *noteHeader;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;

- (IBAction)back:(id)sender;

@end

@implementation NoteDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.noteId){
        NoteEntity *bin=[[NoteEntity alloc]init];
        NoteEntity *note=[bin getNote:self.noteId];
        self.noteHeader.text=note.header;
        //self.noteContent.text=note.content;
        UserEntity *binUser=[[UserEntity alloc]init];
        UserEntity *user=[binUser getUser:note.userId];
        self.userName.text=user.userName;
        self.userAvatar.image=[UIImage imageNamed:@"userDefaultAvatar.jpg"];
        //self.userAvatar.image=[UIImage imageNamed:(user.avatarPath!=nil?user.avatarPath:@"userDefaultAvatar.jpg")];
        
        UILabel *noteContent = [[UILabel alloc] initWithFrame:CGRectMake(20, 165, 280, 21)];
        NSString *txt = note.content;
        noteContent.numberOfLines = 0; ///相当于不限制行数
        noteContent.text = txt;
        noteContent.textColor=[UIColor grayColor];
        [noteContent sizeToFit];
        [self.view addSubview:noteContent];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
