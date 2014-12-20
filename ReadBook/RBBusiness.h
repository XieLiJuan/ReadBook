//
//  RBBusiness.h
//  ReadBook
//
//  Created by 叶喽喽 on 17/12/14.
//  Copyright (c) 2014年 叶喽喽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

// 用于添加，删除，获得的通用方法
@interface RBBusiness : NSObject
@property FMDatabase *DB;//数据库实例

-(RBBusiness *)init;
-(BOOL)addObj: (NSString*)sqlStr;
-(BOOL)delObj: (NSString*)sqlStr;
-(BOOL)updateObj: (NSString*)sqlStr;
-(FMResultSet *)selectObj: (NSString*)sqlStr;
-(int)getTableItemCount: (NSString*)tableName;
-(void)closeDatabase;

@end


// 用户类
@interface UserEntity : NSObject
@property int userId;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) NSDate *loginTime;
@property (nonatomic,retain) NSString *avatarPath;

-(UserEntity *)getUser:(int)userId;
-(UserEntity *)getUserByUserName:(NSString *)userName;
-(NSMutableArray *)selectUser:(NSString *)sqlStr;
@end


// 笔记类
@interface NoteEntity : NSObject
@property int noteId;
@property int userId;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSString *header;
@property int praiseCount;
@property int commentCount;
@property int groupId;

-(NSMutableArray *)getNoteByUserId:(int)userId;
-(NoteEntity *)getNote:(int)noteId;
-(NSMutableArray *)selectNote:(NSString *)sqlStr;//获得一个人的所有笔记；获得小组的所有笔记
-(NSMutableArray *)searchNote:(NSString *)keyWord;
@end


// 小组类
@interface GroupEntity : NSObject
@property int groupId;
@property (nonatomic,retain) NSString * groupName;
@property (nonatomic,retain) NSString *bookReadingName;
@property (nonatomic,retain) NSString *location;
@property (nonatomic,retain) NSString *announcement;
@property (nonatomic,retain) NSString *avatarPath;
@property int leaderId;
@property int memberCount;
@property int noteCount;
@property int categoryId;

-(GroupEntity *)getGroup:(int)groupId;
-(NSMutableArray *)getGroupByCategoryId:(int)categoryId;
-(NSMutableArray *)selectGroup:(NSString *)sqlStr;
-(NSMutableArray *)searchGroup:(NSString *)keyWord;
-(NSMutableArray *)getGroupByLocation:(NSString *)location;
@end


// 用户与小组关系
@interface UserGroupRelationEntity : NSObject
@property int groupId;
@property int userId;
@property int type;

-(NSMutableArray *)getUserByGroupId:(int)groupId;
-(NSMutableArray *)getGroupByUserId:(int)userId;
@end


// 评论类
@interface CommentEntity : NSObject
@property int commentId;
@property int noteId;
@property int userId;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSDate *date;
@property int prevCommentId;
@property int prevUserId;

-(NSMutableArray *)getCommentByNoteId:(int)noteId;
-(NSMutableArray *)getCommentByUserId:(int)userId;
@end


// 申请类
@interface ApplyEntity : NSObject
@property int applyId;
@property int applicantId;
@property int groupId;
@property (nonatomic,retain) NSString *description;
@property int leaderId;
@property int status;

-(ApplyEntity *)getApply:(int)applyId;
-(NSMutableArray *)getApplyByUserId:(int)userId;
@end


// 类别类
@interface CategoryEntity : NSObject
@property int categoryId;
@property (nonatomic,retain) NSString *categoryName;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSString *avatarPath;

-(CategoryEntity *)getCategory:(int)categoryId;
-(NSMutableArray *)getAllCategory;
@end


// 小组最新动态类
@interface TrendsEntity : NSObject
@property int trendsId;
@property int userId;
@property int type;
@property int groupId;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSDate *date;

-(NSMutableArray *)selectTrends:(NSString *)sqlStr;
-(NSMutableArray *)findTrends;
-(NSMutableArray *)getTrendsByUserId:(int)userId;//获取某个用户关注的小组的所有动态
@end


// 收藏类
@interface CollectEntity : NSObject
@property int collectId;
@property int noteId;
@property int userId;

-(NSMutableArray *)getCollectByUserId:(int)userId;//返回收藏的所有笔记
@end


// 讨论区类
@interface DiscussEntity : NSObject
@property int discussId;
@property int groupId;
@property int userId;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSDate *date;

-(NSMutableArray *)getDiscussByGroupId:(int)groupId;//返回小组的所有讨论
@end


// 私信类
@interface PrivateLetterEntity : NSObject
@property int privateLetterId;
@property int sendId;
@property int receiveId;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSDate *date;
@property int sessionId;
@property int status;

-(NSMutableArray *)getPrivateLetterBySessionId:(int)sessionId;//获取某一个对话的所有私信
@end


// 会话类
@interface SessionEntity : NSObject
@property int sessionId;
@property int user2Id;
@property int user1Id;

-(NSMutableArray *)getSessionIdByUserId:(int)userId;
@end