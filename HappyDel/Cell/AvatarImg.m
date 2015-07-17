//
//  AvatarImg.m
//  BizYixin
//
//  Created by NL on 15-3-16.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "AvatarImg.h"


@implementation AvatarImg

+ (UIImage *)renderImageWithColor:(UIColor *)color title:(NSString *)sting inSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillEllipseInRect(context, rect);
    
    //写字
    CGContextSetLineWidth(context, 1.0);
    UIFont  *font = [UIFont boldSystemFontOfSize:11.0];
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSParagraphStyleAttributeName:paragraphStyle ,
                                 NSForegroundColorAttributeName:[UIColor whiteColor]};
    [sting drawInRect:CGRectMake(0, 9, 30, 16) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
