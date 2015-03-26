//
//  DetailCell.m
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "DetailCell.h"
#import "AvatarImg.h"

#define UIColorWithHex(c,a)       [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:a]

@interface DetailCell ()

@end
@implementation DetailCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _recordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
        _recordLabel.backgroundColor = [UIColor clearColor];
        _recordLabel.textAlignment = NSTextAlignmentCenter;
        _recordLabel.font = [UIFont systemFontOfSize:20];
        _recordLabel.textColor = [UIColor blackColor];
        
        
        _recordImage = [[UIImageView alloc] initWithFrame:CGRectMake(13, 2, 30, 30)];

        _myScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(65+5, 0, 120, 35)];
        _myScoreLabel.backgroundColor = [UIColor clearColor];
        _myScoreLabel.font = [UIFont systemFontOfSize:17];
        _myScoreLabel.textColor = [UIColor blackColor];
        
        _bestScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(190+5, 0, 120, 35)];
        _bestScoreLabel.backgroundColor = [UIColor clearColor];
        _bestScoreLabel.font = [UIFont systemFontOfSize:17];
        _bestScoreLabel.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_recordImage];
           [self.contentView addSubview:_recordLabel];
        [self.contentView addSubview:_myScoreLabel];
        [self.contentView addSubview:_bestScoreLabel];
    }
    return self;
}

- (void)setupFourStarCell:(FourStar *)detail
{
    self.recordLabel.frame = CGRectZero;
    self.recordImage.image = [AvatarImg renderImageWithColor:UIColorWithHex(0x1FBFA8,1.0f)
                                                       title:[NSString stringWithFormat:@"%d",detail.recordId]
                                                      inSize:self.recordImage.frame.size];
    self.myScoreLabel.text = [NSString stringWithFormat:@"    %d",detail.score];
    self.bestScoreLabel.text = [NSString stringWithFormat:@"    %d",detail.myScore];
    if (detail.isCompleted)
    {
        self.backgroundColor = UIColorWithHex(0x1FBFA8,0.2);
    }
    else
    {
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)setupFriendCell:(FriendScore *)fs
{
    self.recordLabel.frame = CGRectZero;
    self.recordImage.image = [AvatarImg renderImageWithColor:UIColorWithHex(0x1FBFA8,1.0f)
                                                       title:fs.Name
                                                      inSize:self.recordImage.frame.size];
//    self.recordLabel.text = fs.Name;
//    self.recordImage.frame = CGRectZero;
    self.recordLabel.font = [UIFont boldSystemFontOfSize:16];
    self.myScoreLabel.text = [NSString stringWithFormat:@"    %ld_%ld",(long)fs.MaxMark,(long)fs.TotalScore];
    self.bestScoreLabel.text = [NSString stringWithFormat:@"%f",(float)fs.TotalScore/(float)(fs.MaxMark-1)];
}

@end
