//
//  HappyDAO.h
//  HappyDel
//
//  Created by NL on 15-1-15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "HappyDetail.h"
#import "FriendScore.h"
#import "FourStar.h"


@interface HappyDAO : NSObject
@property (nonatomic, retain) FMDatabaseQueue *dbQueue;

+ (HappyDAO *)sharedDAO;
- (BOOL)initDatabase;
//未达三星的关卡及分数
- (BOOL)addRecord:(HappyDetail *)detail;

- (BOOL)updateRecord:(HappyDetail *)detail;

- (void)getAllRecord:(void(^)(NSMutableArray *records))finish;

- (void)getRecordByRand:(void(^)(NSMutableArray *records))finish;

- (void)getRecordByRecordId:(void(^)(NSMutableArray *records))finish;

- (NSInteger)numberOfRecord;
//好友分数排名
- (BOOL)addFriend:(FriendScore *)fs;

- (BOOL)updateFriend:(FriendScore *)fs;

- (void)getAllFriendScore:(void(^)(NSMutableArray *records))finish;

//四星关卡分数，及我的分数

- (void)getAllFourStar:(void(^)(NSMutableArray *records))finish;
- (BOOL)updateFourstar:(FourStar *)fs;
@end
