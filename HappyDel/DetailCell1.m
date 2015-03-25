//
//  DetailCell.m
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "DetailCell1.h"

@interface DetailCell1 ()
@end
@implementation DetailCell1
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _recordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 35)];
        _recordLabel.backgroundColor = [UIColor clearColor];
        _recordLabel.textAlignment = NSTextAlignmentCenter;
        _recordLabel.font = [UIFont systemFontOfSize:20];
        _recordLabel.textColor = [UIColor blackColor];
        
        _myScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 120, 35)];
        _myScoreLabel.backgroundColor = [UIColor clearColor];
        _myScoreLabel.font = [UIFont systemFontOfSize:17];
        _myScoreLabel.textColor = [UIColor blackColor];
        
        _bestScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 120, 35)];
        _bestScoreLabel.backgroundColor = [UIColor clearColor];
        _bestScoreLabel.font = [UIFont systemFontOfSize:17];
        _bestScoreLabel.textColor = [UIColor blackColor];
 
        _threeScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(320-60, 0, 60, 35)];
        _threeScoreLabel.backgroundColor = [UIColor clearColor];
        _threeScoreLabel.font = [UIFont systemFontOfSize:12];
        _threeScoreLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_recordLabel];
        [self.contentView addSubview:_myScoreLabel];
        [self.contentView addSubview:_bestScoreLabel];
        [self.contentView addSubview:_threeScoreLabel];

    }
    return self;
}

- (void)setupCell:(HappyDetail *)detail
{
    if (detail.isCompleted == 1)
    {
        self.backgroundView.backgroundColor = [UIColor lightGrayColor];
    }
    self.recordLabel.text = [NSString stringWithFormat:@"%d",detail.recordId];
    self.myScoreLabel.text = [NSString stringWithFormat:@"%d/%@",detail.curRank,detail.curScore];
    self.bestScoreLabel.text = [NSString stringWithFormat:@"%d/%@",detail.bestRank,detail.bestScore];
    self.threeScoreLabel.text = detail.threeStar;
//    FourStar *fs = [gHappyDAO getFourStarByRecoard:[NSString stringWithFormat:@"%d",detail.recordId]];
//    if (fs)
//    {
//        self.recordLabel.textColor = [UIColor redColor];
//        self.recordLabel.text = [NSString stringWithFormat:@"%d/%d",detail.recordId,fs.score];
//        self.recordLabel.font = [UIFont systemFontOfSize:12];
//    }
//    else
//    {
        self.recordLabel.textColor = [UIColor blackColor];
        self.recordLabel.font = [UIFont systemFontOfSize:20];
//    }
    if (detail.isCompleted)
    {
        self.backgroundColor = [UIColor grayColor];
    }
    else
    {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
