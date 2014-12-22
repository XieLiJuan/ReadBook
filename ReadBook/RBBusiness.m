//
//  RBBusiness.m
//  ReadBook
//
//  Created by 叶喽喽 on 17/12/14.
//  Copyright (c) 2014年 叶喽喽. All rights reserved.
//

#import "RBBusiness.h"

NSInteger const MutableArrNum=20;

// 通用类
@implementation RBBusiness
@synthesize DB;

-(RBBusiness *)init
{
    if(self=[super init])
    {
        DB=[AppDelegate sharedAppDelegate].database;
    }
    return self;
}
-(BOOL)addObj: (NSString*)sqlStr
{
    if(![DB open]){
        NSLog(@"could not open db");
    }
    if(![DB executeUpdate:sqlStr]){
        NSLog(@"an error while insert Obj!");
        return NO;
    }
    return YES;
}
-(BOOL)delObj: (NSString*)sqlStr
{
    if(![DB open]){
        NSLog(@"could not open db");
    }
    if(![DB executeUpdate:sqlStr]){
        NSLog(@"an error while delete Obj!");
        return NO;
    }
    return YES;
}
-(BOOL)updateObj: (NSString*)sqlStr
{
    if(![DB open]){
        NSLog(@"could not open db");
    }
    if(![DB executeUpdate:sqlStr]){
        NSLog(@"an error while update Obj!");
        return NO;
    }
    return YES;
}
-(FMResultSet *)selectObj: (NSString*)sqlStr
{
    if(![DB open]){
        NSLog(@"could not open db");
    }
    FMResultSet *res=[DB executeQuery:sqlStr];
    //[DB close];
    return res;
}
-(int)getTableItemCount: (NSString*)tableName
{
    if(![DB open]){
        NSLog(@"could not open db");
    }
    NSString *sqlStr=[NSString stringWithFormat:@"select count(*) as 'count' from %@",tableName];
    FMResultSet *res=[DB executeQuery:sqlStr];
    while([res next]){
        NSInteger count=[res intForColumn:@"count"];
        return count;
    }
    return 0;
}
-(void)closeDatabase
{
    [DB close];
}
@end


// 用户类
@implementation UserEntity
@synthesize userId,userName,password,loginTime,avatarPath;

-(UserEntity *)getUser:(int)userId
{
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSString * sqlStr=[NSString stringWithFormat:@"select * from tbUser u where u.UserId=%d",userId];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    //封装为UserEntity
    while([resSet next]){
        UserEntity * resUser=[[UserEntity alloc]init];
        resUser.userId=[resSet intForColumn:@"UserId"];
        resUser.userName=[resSet stringForColumn:@"UserName"];
        resUser.password=[resSet stringForColumn:@"Password"];
        resUser.avatarPath=[resSet stringForColumn:@"AvatarPath"];
        resUser.loginTime=[resSet dateForColumn:@"LoginTime"];//还要转为时间类型
        [rbBin closeDatabase];
        return resUser;
    }
    [rbBin closeDatabase];
    return nil;
}
-(UserEntity *)getUserByUserName:(NSString *)userName
{
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSString * sqlStr=[NSString stringWithFormat:@"select * from tbUser u where u.UserName=\"%@\"",userName];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    //封装为UserEntity
    while([resSet next]){
        UserEntity * resUser=[[UserEntity alloc]init];
        resUser.userId=[resSet intForColumn:@"UserId"];
        resUser.userName=[resSet stringForColumn:@"UserName"];
        resUser.password=[resSet stringForColumn:@"Password"];
        resUser.avatarPath=[resSet stringForColumn:@"AvatarPath"];
        resUser.loginTime=[resSet dateForColumn:@"LoginTime"];//还要转为时间类型
        [rbBin closeDatabase];
        return resUser;
    }
    [rbBin closeDatabase];
    return nil;
}
-(NSMutableArray *)selectUser:(NSString *)sqlStr
{
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    //封装为UserEntity
    while([resSet next]){
        UserEntity * resUser=[[UserEntity alloc]init];
        resUser.UserId=[resSet intForColumn:@"UserId"];
        resUser.UserName=[resSet stringForColumn:@"UserName"];
        resUser.Password=[resSet stringForColumn:@"Password"];
        resUser.AvatarPath=[resSet stringForColumn:@"AvatarPath"];
        resUser.LoginTime=[resSet dateForColumn:@"LoginTime"];//还要转为时间类型
        [resArr addObject:resUser];
    }
    [rbBin closeDatabase];
    return resArr;
}
@end


// 笔记类
@implementation NoteEntity
@synthesize noteId,userId,commentCount,content,header,praiseCount,groupId;

-(NoteEntity *)getNote:(int)noteId
{
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbNote n where n.NoteId=%d",noteId];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while([resSet next]){
        NoteEntity * res=[[NoteEntity alloc]init];
        res.noteId=[resSet intForColumn:@"GroupId"];
        res.userId=[resSet intForColumn:@"UserId"];
        res.commentCount=[resSet intForColumn:@"CommentCount"];
        res.content=[resSet stringForColumn:@"Content"];
        res.header=[resSet stringForColumn:@"Header"];
        res.praiseCount=[resSet intForColumn:@"PraiseCount"];
        res.groupId=[resSet intForColumn:@"GroupId"];
        [rbBin closeDatabase];
        return res;
    }
    [rbBin closeDatabase];
    return nil;
}
-(NSMutableArray *)selectNote:(NSString *)sqlStr
{
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while([resSet next]){
        NoteEntity * res=[[NoteEntity alloc]init];
        res.noteId=[resSet intForColumn:@"GroupId"];
        res.userId=[resSet intForColumn:@"UserId"];
        res.commentCount=[resSet intForColumn:@"CommentCount"];
        res.content=[resSet stringForColumn:@"Content"];
        res.header=[resSet stringForColumn:@"Header"];
        res.praiseCount=[resSet intForColumn:@"PraiseCount"];
        res.groupId=[resSet intForColumn:@"GroupId"];
        [resArr addObject:res];
    }
    [rbBin closeDatabase];
    return resArr;
}
-(NSMutableArray *)searchNote:(NSString *)keyWord
{
    NSString * sqlStr=[NSString stringWithFormat:@"select * from tbNote n where n.Header like \"%%%@%%\"",keyWord];
    return [self selectNote:sqlStr];
}
-(NSMutableArray *)getNoteByUserId:(int)userId
{
    NSString * sqlStr=[NSString stringWithFormat:@"select * from tbNote n where n.UserId=%d",userId];
    return [self selectNote:sqlStr];
}
@end


// 小组类
@implementation GroupEntity
@synthesize groupId,groupName,memberCount,noteCount,bookReadingName,categoryId,location,announcement,avatarPath,leaderId;

-(GroupEntity *)getGroup:(int)groupId
{
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbGroup g where g.GroupId=%d",groupId];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while([resSet next]){
        GroupEntity * res=[[GroupEntity alloc]init];
        res.groupId=[resSet intForColumn:@"GroupId"];
        res.groupName=[resSet stringForColumn:@"GroupName"];
        res.memberCount=[resSet intForColumn:@"MemberCount"];
        res.noteCount=[resSet intForColumn:@"NoteCount"];
        res.bookReadingName=[resSet stringForColumn:@"BookReadingName"];
        res.categoryId=[resSet intForColumn:@"CategoryId"];
        res.location=[resSet stringForColumn:@"Location"];
        res.announcement=[resSet stringForColumn:@"Announcement"];
        res.avatarPath=[resSet stringForColumn:@"AvatarPath"];
        res.leaderId=[resSet intForColumn:@"LeaderId"];
        [rbBin closeDatabase];
        return res;
    }
    [rbBin closeDatabase];
    return nil;
}
-(NSMutableArray *)selectGroup:(NSString *)sqlStr
{
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while([resSet next]){
        GroupEntity * res=[[GroupEntity alloc]init];
        res.groupId=[resSet intForColumn:@"GroupId"];
        res.groupName=[resSet stringForColumn:@"GroupName"];
        res.memberCount=[resSet intForColumn:@"MemberCount"];
        res.noteCount=[resSet intForColumn:@"NoteCount"];
        res.bookReadingName=[resSet stringForColumn:@"BookReadingName"];
        res.categoryId=[resSet intForColumn:@"CategoryId"];
        res.location=[resSet stringForColumn:@"Location"];
        res.announcement=[resSet stringForColumn:@"Announcement"];
        res.avatarPath=[resSet stringForColumn:@"AvatarPath"];
        res.leaderId=[resSet intForColumn:@"LeaderId"];
        [resArr addObject:res];
    }
    [rbBin closeDatabase];
    return resArr;
}
-(NSMutableArray *)getGroupByCategoryId:(int)categoryId
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbGroup g where g.CategoryId=%d",categoryId];
    return [self selectGroup:sqlStr];
}
-(NSMutableArray *)searchGroup:(NSString *)keyWord
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbGroup g where g.GroupName like \"%%%@%%\"",keyWord];
    return [self selectGroup:sqlStr];
}
-(NSMutableArray *)getGroupByLocation:(NSString *)location
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbGroup g where g.Location like \"%%%@%%\"",location];
    return [self selectGroup:sqlStr];
}
@end


// 用户小组关系类
@implementation UserGroupRelationEntity
@synthesize userId,groupId,type;

-(NSMutableArray *)getUserByGroupId:(int)groupId
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbUser where UserId in (select UserId from tbUserGroupRelation where GroupId=%d)",groupId];
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while([resSet next]){
        UserEntity * resUser=[[UserEntity alloc]init];
        resUser.UserId=[resSet intForColumn:@"UserId"];
        resUser.UserName=[resSet stringForColumn:@"UserName"];
        resUser.Password=[resSet stringForColumn:@"Password"];
        resUser.AvatarPath=[resSet stringForColumn:@"AvatarPath"];
        resUser.LoginTime=[resSet dateForColumn:@"LoginTime"];//还要转为时间类型
        [resArr addObject:resUser];
    }
    [rbBin closeDatabase];
    return resArr;
}
-(NSMutableArray *)getGroupByUserId:(int)userId
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbGroup where GroupId in (select GroupId from tbUserGroupRelation where UserId=%d)",userId];
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while([resSet next]){
        GroupEntity * res=[[GroupEntity alloc]init];
        res.groupId=[resSet intForColumn:@"GroupId"];
        res.groupName=[resSet stringForColumn:@"GroupName"];
        res.memberCount=[resSet intForColumn:@"MemberCount"];
        res.noteCount=[resSet intForColumn:@"NoteCount"];
        res.bookReadingName=[resSet stringForColumn:@"BookReadingName"];
        res.categoryId=[resSet intForColumn:@"CategoryId"];
        res.location=[resSet stringForColumn:@"Location"];
        res.announcement=[resSet stringForColumn:@"Announcement"];
        res.avatarPath=[resSet stringForColumn:@"AvatarPath"];
        res.leaderId=[resSet intForColumn:@"LeaderId"];
        [resArr addObject:res];
    }
    [rbBin closeDatabase];
    return resArr;
}

@end



// 评论类
@implementation CommentEntity
@synthesize commentId,noteId,userId,content,date,prevCommentId,prevUserId;

-(NSMutableArray *)getCommentByNoteId:(int)noteId
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbComment c where c.NoteId=%d",noteId];
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while ([resSet next]) {
        CommentEntity *res=[[CommentEntity alloc]init];
        res.commentId=[resSet intForColumn:@"CommentId"];
        res.noteId=[resSet intForColumn:@"Note"];
        res.userId=[resSet intForColumn:@"UserId"];
        res.content=[resSet stringForColumn:@"Content"];
        res.date=[resSet dateForColumn:@"Date"];
        res.prevUserId=[resSet intForColumn:@"PrevUserId"];
        res.prevCommentId=[resSet intForColumn:@"PrevCommentId"];
        [resArr addObject:res];
    }
    [rbBin closeDatabase];
    return resArr;
}
-(NSMutableArray *)getCommentByUserId:(int)userId
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbComment c where c.UserId=%d",userId];
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while ([resSet next]) {
        CommentEntity *res=[[CommentEntity alloc]init];
        res.commentId=[resSet intForColumn:@"CommentId"];
        res.noteId=[resSet intForColumn:@"Note"];
        res.userId=[resSet intForColumn:@"UserId"];
        res.content=[resSet stringForColumn:@"Content"];
        res.date=[resSet dateForColumn:@"Date"];
        res.prevUserId=[resSet intForColumn:@"PrevUserId"];
        res.prevCommentId=[resSet intForColumn:@"PrevCommentId"];
        [resArr addObject:res];
    }
    [rbBin closeDatabase];
    return resArr;
}
@end



// 申请加入类
@implementation ApplyEntity
@synthesize applicantId,applyId,groupId,leaderId,description,status;

-(ApplyEntity *)getApply:(int)applyId
{
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbApply a where a.ApplyId=%d",applyId];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while([resSet next]){
        ApplyEntity * res=[[ApplyEntity alloc]init];
        res.groupId=[resSet intForColumn:@"GroupId"];
        res.applyId=[resSet intForColumn:@"ApplyId"];
        res.applicantId=[resSet intForColumn:@"ApplicantId"];
        res.leaderId=[resSet intForColumn:@"LeaderId"];
        res.description=[resSet stringForColumn:@"Description"];
        res.status=[resSet intForColumn:@"Status"];
        [rbBin closeDatabase];
        return res;
    }
    [rbBin closeDatabase];
    return nil;
}
-(NSMutableArray *)getApplyByUserId:(int)leaderId
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbApply a where a.LeaderId=%d",leaderId];
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while ([resSet next])
    {
        ApplyEntity * res=[[ApplyEntity alloc]init];
        res.groupId=[resSet intForColumn:@"GroupId"];
        res.applyId=[resSet intForColumn:@"ApplyId"];
        res.applicantId=[resSet intForColumn:@"ApplicantId"];
        res.leaderId=[resSet intForColumn:@"LeaderId"];
        res.description=[resSet stringForColumn:@"Description"];
        res.status=[resSet intForColumn:@"Status"];
        [resArr addObject:res];
    }
    [rbBin closeDatabase];
    return resArr;
}

@end



// 类别类
@implementation CategoryEntity
@synthesize categoryId,categoryName,description,avatarPath;

-(CategoryEntity *)getCategory:(int)categoryId
{
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbCategory a where a.CategoryId=%d",categoryId];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while([resSet next]){
        CategoryEntity * res=[[CategoryEntity alloc]init];
        res.categoryId=[resSet intForColumn:@"CategoryId"];
        res.categoryName=[resSet stringForColumn:@"CategoryName"];
        res.description=[resSet stringForColumn:@"Description"];
        res.avatarPath=[resSet stringForColumn:@"AvatarPath"];
        [rbBin closeDatabase];
        return res;
    }
    [rbBin closeDatabase];
    return nil;
}
-(NSMutableArray *)getAllCategory
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbCategory"];
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while ([resSet next])
    {
        CategoryEntity * res=[[CategoryEntity alloc]init];
        res.categoryId=[resSet intForColumn:@"CategoryId"];
        res.categoryName=[resSet stringForColumn:@"CategoryName"];
        res.description=[resSet stringForColumn:@"Description"];
        res.avatarPath=[resSet stringForColumn:@"AvatarPath"];
        [resArr addObject:res];
    }
    [rbBin closeDatabase];
    return resArr;
}
@end



// 最新动态类
@implementation TrendsEntity
@synthesize trendsId,userId,type,groupId,content,date;

-(NSMutableArray *)selectTrends:(NSString *)sqlStr
{
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while ([resSet next])
    {
        TrendsEntity * res=[[TrendsEntity alloc]init];
        res.trendsId=[resSet intForColumn:@"TrendsId"];
        res.userId=[resSet intForColumn:@"UserId"];
        res.type=[resSet intForColumn:@"Type"];
        res.groupId=[resSet intForColumn:@"GroupId"];
        res.content=[resSet stringForColumn:@"Content"];
        [resArr addObject:res];
    }
    [rbBin closeDatabase];
    return resArr;
}
-(NSMutableArray *)findTrends
{
    NSString *sqlStr=[NSString stringWithFormat:@"select tbTrends.TrendsId,tbTrends.UserId,tbTrends.Type,tbTrends.GroupId,tbTrends.Content from tbTrends,tbGroup where tbTrends.GroupId=tbGroup.GroupId order by tbTrends.Date desc"];
    return [self selectTrends:sqlStr];
}
-(NSMutableArray *)getTrendsByUserId:(int)userId
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbTrends where GroupId in (select GroupId from tbUserGroupRelation where UserId=%d)",userId];
    return [self selectTrends:sqlStr];
}

@end



// 收藏夹
@implementation CollectEntity
@synthesize collectId,noteId,userId;

-(NSMutableArray *)getCollectByUserId:(int)userId
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbNote NoteId in (select NoteId from tbCollect where UserId=%d)",userId];
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while([resSet next]){
        NoteEntity * res=[[NoteEntity alloc]init];
        res.noteId=[resSet intForColumn:@"GroupId"];
        res.userId=[resSet intForColumn:@"UserId"];
        res.commentCount=[resSet intForColumn:@"CommentCount"];
        res.content=[resSet stringForColumn:@"Content"];
        res.header=[resSet stringForColumn:@"Header"];
        res.praiseCount=[resSet intForColumn:@"PraiseCount"];
        res.groupId=[resSet intForColumn:@"GroupId"];
        [resArr addObject:res];
    }
    [rbBin closeDatabase];
    return resArr;
}
@end



// 讨论区类
@implementation DiscussEntity
@synthesize discussId,groupId,userId,content,date;

-(NSMutableArray *)getDiscussByGroupId:(int)groupId
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from tbDiscuss d where d.GroupId=%d order by d.Date desc)",groupId];
    RBBusiness *rbBin=[[RBBusiness alloc]init];
    NSMutableArray * resArr=[NSMutableArray arrayWithCapacity:MutableArrNum];
    FMResultSet * resSet = [rbBin selectObj:sqlStr];
    while([resSet next]){
        DiscussEntity * res=[[DiscussEntity alloc]init];
        res.discussId=[resSet intForColumn:@"DiscussId"];
        res.userId=[resSet intForColumn:@"UserId"];
        res.groupId=[resSet intForColumn:@"GroupId"];
        res.content=[resSet stringForColumn:@"Content"];
        res.date=[resSet dateForColumn:@"Date"];
        [resArr addObject:res];
    }
    [rbBin closeDatabase];
    return resArr;
}
@end



// 私信类
@implementation PrivateLetterEntity
// 未实现
@end


// 会话类
@implementation SessionEntity
// 未实现
@end