//
//  EditViewController.m
//  ReadBook
//
//  Created by 叶喽喽 on 21/12/14.
//  Copyright (c) 2014年 叶喽喽. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

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
    
    UIView *viewContainer=[self createViewContainer:-1 y:84 width:322 height:50];
    [self.view addSubview:viewContainer];
}

-(UIView *)createViewContainer:(int)x  y:(int)y width:(int)wid height:(int)hei
{
    UIView *viewContainer=[[UIView alloc]initWithFrame:CGRectMake(x, y, wid, hei)];
    viewContainer.layer.borderWidth=1;
    UIColor *col=[UIColor colorWithRed:120 green:120 blue:120 alpha:.2];
    viewContainer.layer.borderColor=col.CGColor;
    return viewContainer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
