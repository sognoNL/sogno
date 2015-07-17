//
//  FriendCell.m
//  HappyDel
//
//  Created by NL on 15-3-26.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "FriendCell.h"
#import "Constants.h"

@interface FriendCell()
@property (strong, nonatomic) IBOutlet UIImageView *nameImgView;
@property (strong, nonatomic) IBOutlet UIImageView *guankaImgView;
@property (strong, nonatomic) IBOutlet UIImageView *scoreImgView;
@property (strong, nonatomic) IBOutlet UILabel *percentLabel;

@end

@implementation FriendCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setCellData:(id)detail
{
    FriendScore *fs = (FriendScore *)detail;
    self.nameImgView.image = [AvatarImg renderImageWithColor:UIColorWithHex(0x1FBFA8,1.0f)
                                                       title:fs.Name
                                                      inSize:self.nameImgView.frame.size];
    self.guankaImgView.image = [AvatarImg renderImageWithColor:UIColorWithHex(0xfea854,1.0f)
                                                       title:[NSString stringWithFormat:@"%d",fs.MaxMark]
                                                      inSize:self.guankaImgView.frame.size];
    self.scoreImgView.image = [AvatarImg renderImageWithColor:UIColorWithHex(0x5a9cea,1.0f)
                                                       title:[NSString stringWithFormat:@"%d",fs.TotalScore]
                                                      inSize:self.scoreImgView.frame.size];
    self.percentLabel.text = [NSString stringWithFormat:@"%f",(float)fs.TotalScore/(float)(fs.MaxMark-1)];
}
@end
