//
//  groupListViewController.m
//  ReadBook
//
//  Created by 叶喽喽 on 20/12/14.
//  Copyright (c) 2014年 叶喽喽. All rights reserved.
//

#import "groupListViewController.h"
#import "RBBusiness.h"

@interface groupListViewController ()
@property NSMutableArray *groupList;
@end

@implementation groupListViewController
@synthesize title;

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
    [self setNavigateTitle:self.categoryId];
    // Do any additional setup after loading the view.
}

-(void)setNavigateTitle:(int)categoryId
{
    CategoryEntity *bin=[[CategoryEntity alloc]init];
    CategoryEntity *theCate=[bin getCategory:categoryId];
    [self.navigationItem setTitle:theCate.categoryName];
    [self bindData:categoryId];
}

-(void)bindData:(int)categoryId
{
    GroupEntity *bin=[[GroupEntity alloc]init];
    self.groupList=[bin getGroupByCategoryId:categoryId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//是在- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath后就跟着执行
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIFont *font = [UIFont systemFontOfSize:12.0];
//    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
//    NSString *tt = cell.detailTextLabel.text;
//    CGSize size = [tt sizeWithFont:font constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:UILineBreakModeWordWrap];
//    
//    return size.height+10; // 10即消息上下的空间，可自由调整
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"groupItemCell"];
    GroupEntity * group=self.groupList[indexPath.row];
    cell.textLabel.text=group.groupName;
    cell.imageView.image=[UIImage imageNamed:group.avatarPath];
    cell.detailTextLabel.text=group.bookReadingName;
    cell.detailTextLabel.lineBreakMode=UILineBreakModeWordWrap;
    [cell.detailTextLabel sizeToFit];
    cell.detailTextLabel.numberOfLines=0;
    return cell;
}

@end
