//
//  YXBaseCell.h
//  BizYixin
//
//  Created by NL on 15-3-3.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CellDefine.h"

@interface YXBaseCell : UITableViewCell

- (void)setCellData:(id)detail;

+ (UITableViewCell *)setupCell:(UITableView *)tblView
                    withCellID:(NSString *)cellID;

@end
