//
//  YXBaseCell.m
//  BizYixin
//
//  Created by NL on 15-3-3.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "YXBaseCell.h"

@implementation YXBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellData:(NSDictionary *)cellDataAry
{
    //子类自己实现
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (UITableViewCell *)setupCell:(UITableView *)tblView
                    withCellID:(NSString *)cellID
{
    UITableViewCell *cell = (UITableViewCell *)[self _gotTableViewCell:tblView withCellID:cellID];
    
    return cell;
}

+ (UITableViewCell *)_gotTableViewCell:(UITableView *)tblView withCellID:(NSString *)cellID
{
    NSString *cellClassName = [cellID substringToIndex:cellID.length - 2];
    UITableViewCell *cell = (UITableViewCell *)[tblView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellClassName owner:self options:nil] lastObject];
        if (cell == nil)
        {
            NSAssert(NO, @"init cell fail");
        }
    }
    
    return cell;
}



@end
