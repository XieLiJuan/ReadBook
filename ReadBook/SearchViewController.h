//
//  SearchViewController.h
//  ReadBook
//
//  Created by 叶喽喽 on 19/12/14.
//  Copyright (c) 2014年 叶喽喽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchTable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
