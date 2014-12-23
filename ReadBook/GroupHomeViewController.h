//
//  GroupHomeViewController.h
//  ReadBook
//
//  Created by student on 14-12-23.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupHomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *homeView;
@property (strong, nonatomic) IBOutlet UIView *discussView;
@property (strong, nonatomic) IBOutlet UIView *membersView;
@property int viewId;
@property (weak, nonatomic) IBOutlet UIScrollView *homeScrollView;

@end
