//
//  AddViewController.h
//  HappyDel
//
//  Created by NL on 15-1-15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HappyDetail.h"

@interface AddViewController : UIViewController
@property (strong, nonatomic) HappyDetail *happyDetail;
@property (assign,nonatomic) BOOL isAdd;
@end
