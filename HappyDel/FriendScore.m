//
//  FriendScore.m
//  HappyDel
//
//  Created by NL on 15-1-15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "FriendScore.h"

@implementation FriendScore

- (NSComparisonResult)compareByStar:(FriendScore *)fs
{
    return self.TotalScore < fs.TotalScore;
}

- (NSComparisonResult)compareByPoint:(FriendScore *)fs
{
    return self.Point < fs.Point;
}


@end
