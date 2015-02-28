//
//  FirstViewController.h
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

