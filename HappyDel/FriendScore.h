//
//  FriendScore.h
//  HappyDel
//
//  Created by NL on 15-1-15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendScore : NSObject
@property (nonatomic,strong) NSString *Name;
@property (nonatomic,assign) NSInteger MaxMark;
@property (nonatomic,assign) NSInteger TotalScore;
@property (nonatomic,assign) float Point;

- (NSComparisonResult)compareByStar:(FriendScore *)fs;
- (NSComparisonResult)compareByPoint:(FriendScore *)fs;
@end
