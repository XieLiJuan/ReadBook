//
//  CategorySelectViewController.m
//  ReadBook
//
//  Created by 叶喽喽 on 20/12/14.
//  Copyright (c) 2014年 叶喽喽. All rights reserved.
//

#import "CategorySelectViewController.h"
#import "RBBusiness.h"
#import "groupListViewController.h"

@interface CategorySelectViewController ()
@property(nonatomic,strong) NSMutableArray *categoryArr;
@end

@implementation CategorySelectViewController

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
    [self bindData];
    self.navigationItem.title=@"添加小组";
}

-(void)bindData
{
    CategoryEntity *bin=[[CategoryEntity alloc]init];
    self.categoryArr=[bin getAllCategory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *m=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    groupListViewController *groupList=[m instantiateViewControllerWithIdentifier:@"groupList"];
    CategoryEntity * theCate=self.categoryArr[indexPath.row];
    groupList.categoryId=theCate.categoryId;
    [self.navigationController pushViewController:groupList animated:YES];
    //[self presentViewController:groupList animated:YES completion:nil];//presentViewController:当前视图
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"categoryCell"];
    }
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    CategoryEntity *category=(CategoryEntity *)self.categoryArr[indexPath.row];
    cell.textLabel.text=category.categoryName;
    cell.detailTextLabel.text=category.description;
    //cell.imageView.layer.cornerRadius=10;
    cell.imageView.layer.masksToBounds=YES;
    cell.imageView.image=[UIImage imageNamed:@"letterDefaultAvatar.png"];
    return cell;
}

//是在- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath后就跟着执行
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont systemFontOfSize:12.0];
    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *tt = cell.detailTextLabel.text;
    CGSize size = [tt sizeWithFont:font constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:UILineBreakModeWordWrap];
    
    return size.height+10+22+10; // 10即消息上下的空间，可自由调整
}

@end
