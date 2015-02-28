//
//  ThirdViewController.h
//  HappyDel
//
//  Created by NL on 15-1-15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@end
