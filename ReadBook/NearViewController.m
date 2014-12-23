//
//  NearViewController.m
//  ReadBook
//
//  Created by 叶喽喽 on 22/12/14.
//  Copyright (c) 2014年 叶喽喽. All rights reserved.
//

#import "NearViewController.h"
#import "NoteDetailViewController.h"
#import "RBBusiness.h"
#import "NoteTableViewCell.h"

@interface NearViewController ()
@property NSMutableArray * myGroupTrends;
@end

@implementation NearViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    TrendsEntity *bin=[[TrendsEntity alloc]init];
    self.myGroupTrends=[bin getTrendsByUserId:[AppDelegate sharedAppDelegate].userId];
    [self.navigationItem setTitle:@"附近"];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //self.automaticallyAdjustsScrollViewInsets=YES;
    //[self.navigationItem.leftBarButtonItem setTitle:@"+"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count=[self.myGroupTrends count];
    return count;
}

-(NoteTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"noteCell" forIndexPath:indexPath];
    TrendsEntity * theTrends=(TrendsEntity *)self.myGroupTrends[indexPath.row];
    UserEntity *binUser=[[UserEntity alloc]init];
    UserEntity *theUser=[binUser getUser:theTrends.userId];
    cell.personName.text=[NSString stringWithFormat:@"#%@#",theUser.userName];
    
    UILabel *noteContent = [[UILabel alloc] initWithFrame:CGRectMake(64, 40, 215, 21)];
    NSString *txt = theTrends.content;
    noteContent.numberOfLines = 0; ///相当于不限制行数
    noteContent.text = txt;
    noteContent.textColor=[UIColor grayColor];
    [noteContent sizeToFit];
    [cell.contentView addSubview:noteContent];
    
    GroupEntity *binGroup=[[GroupEntity alloc]init];
    GroupEntity *theGroup=[binGroup getGroup:theTrends.groupId];
    cell.groubName.text=[NSString stringWithFormat:@"来自%@",theGroup.groupName];
    UIImage * img=[UIImage imageNamed:(theGroup.avatarPath!=nil?theGroup.avatarPath:@"groupDefaultAvatar.jpg")];
    cell.groupAvatar.layer.cornerRadius=20;
    cell.groupAvatar.layer.masksToBounds=YES;
    cell.groupAvatar.image=img;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NoteDetailViewController *detai=[s instantiateViewControllerWithIdentifier:@"NoteDetail"];
    [self.navigationController pushViewController:detai animated:YES];
    //[self presentViewController:detai animated:YES completion:nil];//presentViewController:当前视图
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



@end
