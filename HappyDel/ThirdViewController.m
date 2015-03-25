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
#import "FriendScore.h"
#import "AddFriendViewController.h"

@interface ThirdViewController ()
@property (nonatomic,strong) NSMutableArray *recordAry;
@end

@implementation ThirdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];

    if(cell== nil)
    {
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
    }

    FriendScore *fs = self.recordAry[indexPath.row];
    cell.recordLabel.text = fs.Name;
    cell.recordLabel.font = [UIFont boldSystemFontOfSize:16];
    cell.myScoreLabel.text = [NSString stringWithFormat:@"    %ld_%ld",(long)fs.MaxMark,(long)fs.TotalScore];
    cell.bestScoreLabel.text = [NSString stringWithFormat:@"%f",(float)fs.TotalScore/(float)(fs.MaxMark-1)];
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
