//
//  GroupHomeViewController.m
//  ReadBook
//
//  Created by student on 14-12-23.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "GroupHomeViewController.h"

@interface GroupHomeViewController ()
@property UISegmentedControl *segmentedControl;
@end

@implementation GroupHomeViewController

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
    [self initSegmentedControl];
    if(!self.viewId)
        self.viewId=0;
    [self setViewActive:self.viewId];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
}

-(void)initSegmentedControl
{
    NSArray *segmentedArray=[[NSArray alloc]initWithObjects:@"主页",@"讨论区",@"组员", nil];
    self.segmentedControl=[[UISegmentedControl alloc]initWithItems:segmentedArray];
    [self.segmentedControl setImage:[UIImage imageNamed:@"groupHome_1.png"] forSegmentAtIndex:0];//设置指定索引的图片
    [self.segmentedControl setImage:[UIImage imageNamed:@"discuss_1.png"] forSegmentAtIndex:1];//设置指定索引的图片
    [self.segmentedControl setImage:[UIImage imageNamed:@"groupMembers_1.png"] forSegmentAtIndex:2];//设置指定索引的图片
    self.segmentedControl.frame=CGRectMake(-5, 64, 330, 50);
    self.segmentedControl.layer.cornerRadius=0;
    //segmentedControl.selectedSegmentIndex=0;
    UIColor *color=[[UIColor alloc]initWithRed:0.45 green:0.45 blue:0.47 alpha:1];
    //UIColor *color=[UIColor whiteColor];
    self.segmentedControl.tintColor=color;
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.segmentedControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setViewActive:(int)viewId
{
    self.segmentedControl.selectedSegmentIndex=viewId;
    switch (viewId) {
        case 0:
            [self selectHomeView];
            break;
        case 1:
            [self selectDiscussView];
            break;
        case 2:
            [self selectMembersView];
            break;
        default:
            break;
    }
    
}

-(void)segmentAction:(UISegmentedControl *)seg
{
    NSInteger index=seg.selectedSegmentIndex;
    //NSLog(@"index %i",index);
    switch (index) {
        case 0:
            [self selectHomeView];
            break;
        case 1:
            [self selectDiscussView];
            break;
        case 2:
            [self selectMembersView];
            break;
        default:
            break;
    }
}

-(void)selectHomeView
{
    [self.navigationItem setTitle:@"小组主页"];
    self.homeView.hidden=NO;
    self.membersView.hidden=YES;
    self.discussView.hidden=YES;
}

-(void)selectDiscussView
{
    [self.navigationItem setTitle:@"讨论区"];
    self.homeView.hidden=YES;
    self.membersView.hidden=YES;
    self.discussView.hidden=NO;
}

-(void)selectMembersView
{
    [self.navigationItem setTitle:@"组员"];
    self.homeView.hidden=YES;
    self.membersView.hidden=NO;
    self.discussView.hidden=YES;
}

@end
