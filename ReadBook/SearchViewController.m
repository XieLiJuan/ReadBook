//
//  SearchViewController.m
//  ReadBook
//
//  Created by 叶喽喽 on 19/12/14.
//  Copyright (c) 2014年 叶喽喽. All rights reserved.
//

#import "SearchViewController.h"
#import "RBBusiness.h"
#import "NoteDetailViewController.h"

@interface SearchViewController ()
@property(nonatomic,strong) NSMutableArray *searchResult;
@end

@implementation SearchViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideSearchView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResult.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchCell"];
    }
    UserEntity * bin=[[UserEntity alloc]init];
    NoteEntity *note=(NoteEntity *)self.searchResult[indexPath.row];
    UserEntity * user=[bin getUser:note.userId];
    cell.textLabel.text=note.header;
    //cell.imageView.frame=CGRectMake(5, 0, 30, 30);
    cell.imageView.layer.cornerRadius=10;
    cell.imageView.layer.masksToBounds=YES;
    cell.imageView.image=[UIImage imageNamed:@"userDefaultAvatar.jpg"];
    //cell.imageView.image=[UIImage imageNamed:(user.avatarPath!=nil?user.avatarPath:@"userDefaultAvatar.jpg")];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NoteDetailViewController *detai=[s instantiateViewControllerWithIdentifier:@"NoteDetail"];
    NoteEntity *note=(NoteEntity *)self.searchResult[indexPath.row];
    detai.noteId=note.noteId;
    [self presentViewController:detai animated:YES completion:nil];//presentViewController:当前视图
}

#pragma mark - Search Delegate
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
//    self.filteredDeparts=nil;//清空数据
//    searchBar.text=@"";
//    self.searchTableView.hidden=YES;
    [self hideSearchView];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText length]==0){
        [self.searchTable reloadData];
    }else{
        //获得数据
        NoteEntity *bin=[[NoteEntity alloc]init];
        self.searchResult=[bin searchNote:searchText];
        //self.searchResult=[self.departments filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText]];//过滤数据
        [self.searchTable reloadData];
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    self.searchResult=nil;
    [self.searchTable reloadData];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     [self.searchBar resignFirstResponder];
}

@end
