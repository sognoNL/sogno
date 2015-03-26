//
//  DetailCell.m
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "DetailCell1.h"
#import "AvatarImg.h"
#define UIColorWithHex(c,a)       [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:a]

@interface DetailCell1 ()
@end
@implementation DetailCell1
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _recordImage = [[UIImageView alloc] initWithFrame:CGRectMake(13, 2, 30, 30)];
//        _recordImage.backgroundColor = [UIColor clearColor];
//        _recordImage.textAlignment = NSTextAlignmentCenter;
//        _recordImage.font = [UIFont systemFontOfSize:20];
//        _recordImage.textColor = [UIColor blackColor];
        
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
        _threeScoreLabel.textColor = UIColorWithHex(0x1FBFA8,0.7);
        [self.contentView addSubview:_recordImage];
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
    self.recordImage.image = [AvatarImg renderImageWithColor:UIColorWithHex(0x1FBFA8,1.0f)
                                                    title:[NSString stringWithFormat:@"%d",detail.recordId]
                                                   inSize:self.recordImage.frame.size];
    self.myScoreLabel.text = [NSString stringWithFormat:@"%d/%@",detail.curRank,detail.curScore];
    self.bestScoreLabel.text = [NSString stringWithFormat:@"%d/%@",detail.bestRank,detail.bestScore];
    self.threeScoreLabel.text = detail.threeStar;
    if (detail.isCompleted)
    {
        self.backgroundColor = UIColorWithHex(0x1FBFA8,0.2);
    }
    else
    {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
