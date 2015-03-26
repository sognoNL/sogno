//
//  SecondViewController.m
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "SecondViewController.h"
#import "HappyDAO.h"
#import "Constants.h"
#import "DetailCell.h"
#import "UpdateViewController.h"
@interface SecondViewController ()
@property (nonatomic,strong) NSMutableArray *recordAry;
@property (strong, nonatomic) IBOutlet UITabBarItem *secondItem;
@end

@implementation SecondViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.secondItem setFinishedSelectedImage:[UIImage imageNamed:@"secondPress.png"]
                 withFinishedUnselectedImage:[UIImage imageNamed:@""]];
    self.recordAry = [[NSMutableArray alloc] init];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [[UIView alloc] init];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.recordAry removeAllObjects];
    __block SecondViewController *weakself = self;
    [gHappyDAO getAllFourStar:^(NSMutableArray *records)
     {
         weakself.recordAry = records;
         [weakself.tableview reloadData];
     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if(cell== nil)
    {
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
    }
    FourStar *fs = self.recordAry[indexPath.row];
    [cell setupFourStarCell:fs];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FourStar *fs = self.recordAry[indexPath.row];
    UpdateViewController *uvc = [[UpdateViewController alloc] init];
    uvc.fourstar = fs;
    [self presentViewController:uvc animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
