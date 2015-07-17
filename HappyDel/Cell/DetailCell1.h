//
//  DetailCell.h
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HappyDetail.h"

@interface DetailCell1 : UITableViewCell
@property (strong, nonatomic) UIImageView *recordImage;
@property (strong, nonatomic) UILabel *myScoreLabel;
@property (strong, nonatomic) UILabel *bestScoreLabel;
@property (strong, nonatomic) UILabel *threeScoreLabel;

- (void)setupCell:(HappyDetail *)detail;

@end
