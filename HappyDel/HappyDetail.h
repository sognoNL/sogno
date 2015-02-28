//
//  HappyDetail.h
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HappyDetail : NSObject
@property (nonatomic,assign) NSInteger recordId;
@property (nonatomic,strong) NSString *curScore;
@property (nonatomic,assign) NSInteger curRank;
@property (nonatomic,strong) NSString *bestScore;
@property (nonatomic,assign) NSInteger bestRank;
@property (nonatomic,strong) NSString *threeStar;
@property (nonatomic,assign) BOOL isCompleted;
@end
