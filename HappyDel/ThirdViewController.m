//
//  ThirdViewController.m
//  HappyDel
//
//  Created by NL on 15-1-15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "ThirdViewController.h"
#import "DetailCell.h"
#import "HappyDAO.h"
#import "Constants.h"
#import "AddFriendViewController.h"
#import "FriendCell.h"

@interface ThirdViewController ()
@property (nonatomic,strong) NSMutableArray *recordAry;
@property (strong, nonatomic) IBOutlet UITabBarItem *thirdItem;
@end

@implementation ThirdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.thirdItem setFinishedSelectedImage:[UIImage imageNamed:@"thirdPress.png"]
                 withFinishedUnselectedImage:[UIImage imageNamed:@""]];
    self.recordAry = [[NSMutableArray alloc] init];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self.view sendSubviewToBack:self.tableview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.recordAry removeAllObjects];
    __block ThirdViewController *weakself = self;
    [gHappyDAO getAllFriendScore:^(NSMutableArray *records)
     {
         weakself.recordAry = records;
         [weakself.tableview reloadData];
     }];
}
- (IBAction)addFriend:(id)sender
{
    AddFriendViewController *avc = [[AddFriendViewController alloc] init];
    avc.isAdd = YES;
    [self presentViewController:avc animated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCell *cell = (FriendCell *)[YXBaseCell setupCell:tableView withCellID:@"FriendCellID"];
//    DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
//
//    if(cell== nil)
//    {
//        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
//    }

    FriendScore *fs = self.recordAry[indexPath.row];
    [cell setCellData:fs];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FriendScore *fs = self.recordAry[indexPath.row];
    AddFriendViewController *avc = [[AddFriendViewController alloc] init];
    avc.friendScore = fs;
    avc.isAdd = NO;
    [self presentViewController:avc animated:YES completion:nil];
}

- (IBAction)sortByStars:(id)sender
{
    NSArray *reversedArray = [self.recordAry sortedArrayUsingSelector:@selector(compareByStar:)];
    self.recordAry = [NSMutableArray arrayWithArray:reversedArray];
    [self.tableview reloadData];
}

- (IBAction)sortByPoint:(id)sender
{
    NSArray *reversedArray = [self.recordAry sortedArrayUsingSelector:@selector(compareByPoint:)];
    self.recordAry = [NSMutableArray arrayWithArray:reversedArray];
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
