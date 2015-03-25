//
//  DetailCell.m
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "DetailCell.h"

@interface DetailCell ()
{
    UILabel *vSepLabel1;
    UILabel *vSepLabel2;
}

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
        
        _myScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(65+5, 0, 120, 35)];
        _myScoreLabel.backgroundColor = [UIColor clearColor];
        _myScoreLabel.font = [UIFont systemFontOfSize:17];
        _myScoreLabel.textColor = [UIColor blackColor];
        
        _bestScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(190+5, 0, 120, 35)];
        _bestScoreLabel.backgroundColor = [UIColor clearColor];
        _bestScoreLabel.font = [UIFont systemFontOfSize:17];
        _bestScoreLabel.textColor = [UIColor blackColor];
        
        vSepLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(62-6, 5, 2, 25)];
        vSepLabel1.backgroundColor = [UIColor grayColor];
        vSepLabel1.font = [UIFont systemFontOfSize:17];
        
        vSepLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(187-6, 5, 2, 25)];
        vSepLabel2.backgroundColor = [UIColor grayColor];
        vSepLabel2.font = [UIFont systemFontOfSize:17];
        
        [self.contentView addSubview:_recordLabel];
        [self.contentView addSubview:_myScoreLabel];
        [self.contentView addSubview:_bestScoreLabel];
//        [self.contentView addSubview:vSepLabel1];
//        [self.contentView addSubview:vSepLabel2];

    }
    return self;
}
@end
