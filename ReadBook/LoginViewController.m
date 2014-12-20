//
//  LoginViewController.m
//  ReadBook
//
//  Created by student on 14-12-17.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "LoginViewController.h"
#import "FMDB.h"
#import "AppDelegate.h"
#import "RBBusiness.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)login:(id)sender;
@end

@implementation LoginViewController

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
    // Do any additional setup after loading the view.
    UIImageView *imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"groupDefaultAvatar.jpg"]];
    imgView.frame=CGRectMake(10, 10, 60, 60);
    imgView.layer.cornerRadius=30;
    imgView.layer.masksToBounds=YES;
    [self.view addSubview:imgView];
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

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
}

- (IBAction)login:(id)sender
{    
    UserEntity * bin=[[UserEntity alloc]init];
    UserEntity *res=[bin getUserByUserName:self.userName.text];
    if(res){
        NSString *pwd=res.password;
        if([pwd isEqualToString:self.passWord.text])
        {
            //进入主界面
            [AppDelegate sharedAppDelegate].userId=res.userId;
            [self performSegueWithIdentifier:@"enterMain" sender:self];
        }
    }
    
    
}

@end
