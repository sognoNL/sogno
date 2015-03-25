//
//  HappyDAO.m
//  HappyDel
//
//  Created by NL on 15-1-15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "HappyDAO.h"
#import "FMDatabase.h"
#define kDBFile     @"score.sqlite"

@interface HappyDAO()

@end

@implementation HappyDAO

static HappyDAO *sharedDAO = nil;

- (void)_singletonInit
{
}

+ (HappyDAO *)sharedDAO
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^
                  {
                      sharedDAO = [[self alloc] init];
                      [sharedDAO _singletonInit];
                  });
    
    return sharedDAO;
}

- (BOOL)initDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbFilePath = [NSString stringWithFormat:@"%@/%@",[NSString stringWithFormat:@"%@",paths[0]],kDBFile];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbFilePath])
    {
        BOOL success;
        NSError *error;
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDBFile];
        // 拷贝文件可能需要耗1MB内存
        success = [[NSFileManager defaultManager] copyItemAtPath:defaultDBPath toPath:dbFilePath error:&error];
        if (!success)
        {
            return NO;
        }
    }
    
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    // 数据库的一些优化
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         // 开启缓存
         [db setShouldCacheStatements:YES];
         // 关闭同步，日志系统写入内容，临时表写入内存--加快sql处理速度
         sqlite3_exec([db sqliteHandle],"PRAGMA synchronous=OFF", NULL, NULL, NULL);
         if ([db hadError])
         {
         }
     }];
    
    return YES;
}

- (BOOL)addRecord:(HappyDetail *)detail
{
    __block BOOL success = YES;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:@"INSERT INTO happydel (recordId,curScore,curRank,"\
          "bestScore,bestRank,iscompleted,threestar) VALUES (?,?,?,?,?,?,?)",
          @(detail.recordId), detail.curScore,@(detail.curRank),detail.bestScore,@(detail.bestRank)
          ,@(detail.isCompleted),detail.threeStar];
         
         if ([db hadError])
         {
             *rollback = YES;
             success = NO;
             return ;
         }
     }];
    return success;
}
- (BOOL)updateRecord:(HappyDetail *)detail
{
    __block BOOL success = YES;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:@"UPDATE happydel SET curScore = ?,curRank = ?,bestScore = ?,bestRank = ?, "\
          "iscompleted = ?,threestar = ? WHERE recordId = ?", detail.curScore,@(detail.curRank),detail.bestScore,
          @(detail.bestRank),@(detail.isCompleted),detail.threeStar,@(detail.recordId)];
         if ([db hadError])
         {
             *rollback = YES;
             success = NO;
             return ;
         }
     }];
    return success;
}

- (HappyDetail *)_rsToHappyDetail:(FMResultSet *)rs
{
    HappyDetail *dial = [[HappyDetail alloc] init];
    dial.recordId = [rs intForColumn:@"recordId"];
    dial.curScore = [rs stringForColumn:@"curScore"];
    dial.curRank = [rs intForColumn:@"curRank"];
    dial.bestScore = [rs stringForColumn:@"bestScore"];
    dial.bestRank = [rs intForColumn:@"bestRank"];
    dial.threeStar = [rs stringForColumn:@"threestar"];
    dial.isCompleted = [rs boolForColumn:@"iscompleted"];
    return dial;
}

- (void)getAllRecord:(void(^)(NSMutableArray *records))finish
{
    if (finish == nil)
    {
        return;
    }
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         NSMutableArray *tempRecords = [NSMutableArray array];
         NSString *sql = [NSString stringWithFormat:@"SELECT * FROM happydel order by recordId asc"];
         FMResultSet *rs = [db executeQuery:sql];
         while ([rs next])
         {
             HappyDetail *record = [self _rsToHappyDetail:rs];
             [tempRecords addObject:record];
         }
         [rs close];
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            finish(tempRecords);
                        });
     }];
}

- (void)getRecordByRand:(void(^)(NSMutableArray *records))finish
{
    if (finish == nil)
    {
        return;
    }
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         NSMutableArray *tempRecords = [NSMutableArray array];
         NSString *sql = [NSString stringWithFormat:@"SELECT * FROM happydel where iscompleted = 0 order by curRank desc"];
         FMResultSet *rs = [db executeQuery:sql];
         while ([rs next])
         {
             HappyDetail *record = [self _rsToHappyDetail:rs];
             [tempRecords addObject:record];
         }
         [rs close];
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            finish(tempRecords);
                        });
     }];
}
- (void)getRecordByRecordId:(void(^)(NSMutableArray *records))finish
{
    if (finish == nil)
    {
        return;
    }
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         NSMutableArray *tempRecords = [NSMutableArray array];
         NSString *sql = [NSString stringWithFormat:@"SELECT * FROM happydel where iscompleted = 0 order by recordId asc"];
         FMResultSet *rs = [db executeQuery:sql];
         while ([rs next])
         {
             HappyDetail *record = [self _rsToHappyDetail:rs];
             [tempRecords addObject:record];
         }
         [rs close];
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            finish(tempRecords);
                        });
     }];
}

- (NSInteger)numberOfRecord
{
    __block NSInteger count = 0;
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) AS numberofconvos FROM"\
                          " happydel where iscompleted = 0"];
         FMResultSet *rs = [db executeQuery:sql];
         if ([rs next])
         {
             count = [rs intForColumn:@"numberofconvos"];
         }
         
         [rs close];
     }];
    return count;
}

- (BOOL)addFriend:(FriendScore *)fs
{
    __block BOOL success = YES;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:@"INSERT INTO friendscroe (name,maxmark,totalscore,point) VALUES (?,?,?,?)",
          fs.Name, @(fs.MaxMark),@(fs.TotalScore),@(fs.Point)];
         
         if ([db hadError])
         {
             *rollback = YES;
             success = NO;
             return ;
         }
     }];
    return success;
}

- (BOOL)updateFriend:(FriendScore *)fs
{
    __block BOOL success = YES;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:@"UPDATE friendscroe SET maxmark = ?,totalscore = ?,point = ? WHERE name = ?",
          @(fs.MaxMark),@(fs.TotalScore),@(fs.Point),fs.Name];
         if ([db hadError])
         {
             *rollback = YES;
             success = NO;
             return ;
         }
     }];
    return success;
}

- (FriendScore *)_rsToFriendScore:(FMResultSet *)rs
{
    FriendScore *fs = [[FriendScore alloc] init];
    fs.Name = [rs stringForColumn:@"name"];
    fs.MaxMark = [rs intForColumn:@"maxmark"];
    fs.TotalScore = [rs intForColumn:@"totalscore"];
    fs.Point = (float) [rs doubleForColumn:@"point"];
    return fs;
}

- (void)getAllFriendScore:(void(^)(NSMutableArray *records))finish
{
    if (finish == nil)
    {
        return;
    }
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         NSMutableArray *tempRecords = [NSMutableArray array];
         NSString *sql = [NSString stringWithFormat:@"SELECT * FROM friendscroe order by totalscore desc"];
         FMResultSet *rs = [db executeQuery:sql];
         while ([rs next])
         {
             FriendScore *record = [self _rsToFriendScore:rs];
             [tempRecords addObject:record];
         }
         [rs close];
         dispatch_async(dispatch_get_main_queue(), ^
        {
            finish(tempRecords);
        });
     }];
}
- (FourStar *)_rsToFourStar:(FMResultSet *)rs
{
    FourStar *fs = [[FourStar alloc] init];
    fs.recordId = [rs intForColumn:@"recordid"];
    fs.score = [rs intForColumn:@"score"];
    fs.myScore = [rs intForColumn:@"myscore"];
    fs.isCompleted = [rs boolForColumn:@"iscomplete"];
    return fs;
}
- (void)getAllFourStar:(void(^)(NSMutableArray *records))finish
{
    if (finish == nil)
    {
        return;
    }
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         NSMutableArray *tempRecords = [NSMutableArray array];
         NSString *sql = [NSString stringWithFormat:@"SELECT * FROM fourstar"];
         FMResultSet *rs = [db executeQuery:sql];
         while ([rs next])
         {
             FourStar *record = [self _rsToFourStar:rs];
             [tempRecords addObject:record];
         }
         [rs close];
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            finish(tempRecords);
                        });
     }];
}

- (BOOL)updateFourstar:(FourStar *)fs
{
    __block BOOL success = YES;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:@"UPDATE fourstar SET myscore = ?,iscomplete = ? WHERE recordid = ?",
          @(fs.myScore),@(fs.isCompleted),@(fs.recordId)];
         if ([db hadError])
         {
             *rollback = YES;
             success = NO;
             return ;
         }
     }];
    return success;
}
@end
