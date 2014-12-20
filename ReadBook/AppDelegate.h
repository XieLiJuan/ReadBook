//
//  AppDelegate.h
//  ReadBook
//
//  Created by 叶喽喽 on 15/12/14.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
#import "RBBusiness.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) FMDatabase *database;//数据库实例
//@property RBBusiness *theUser;
@property int userId;
//@property UserEntity *theUser;
@property BOOL isLogin;
+(AppDelegate *)sharedAppDelegate;

@end
