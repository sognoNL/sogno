//
//  DetailCell.h
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourStar.h"
#import "FriendScore.h"

@interface DetailCell : UITableViewCell
@property (strong, nonatomic) UILabel *recordLabel;
@property (strong, nonatomic) UIImageView *recordImage;
@property (strong, nonatomic) UILabel *myScoreLabel;
@property (strong, nonatomic) UILabel *bestScoreLabel;

- (void)setupFourStarCell:(FourStar *)detail;
- (void)setupFriendCell:(FriendScore *)fs;
@end
