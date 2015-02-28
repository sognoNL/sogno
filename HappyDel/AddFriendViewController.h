//
//  AddFriendViewController.h
//  HappyDel
//
//  Created by NL on 15-1-15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendScore.h"

@interface AddFriendViewController : UIViewController
<UITextFieldDelegate>
@property (strong, nonatomic) FriendScore *friendScore;
@property (assign,nonatomic) BOOL isAdd;
@end
