//
//  AvatarImg.h
//  BizYixin
//
//  Created by NL on 15-3-16.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarImg : UIView
+ (UIImage *)renderImageWithColor:(UIColor *)color title:(NSString *)sting inSize:(CGSize)size;
@end
