//
//  FirstViewController.m
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "FirstViewController.h"
#import "HappyDetail.h"
#import "AddViewController.h"
#import "HappyDAO.h"
#import "Constants.h"
#import "DetailCell1.h"

@interface FirstViewController ()
@property (nonatomic,strong) NSMutableArray *recordAry;
@property (strong, nonatomic) IBOutlet UILabel *recodrCountLabel;
@property (strong, nonatomic) IBOutlet UITabBarItem *firstItem;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.firstItem setFinishedSelectedImage:[UIImage imageNamed:@"firstPress.png"]
                 withFinishedUnselectedImage:[UIImage imageNamed:@""]];
    self.recordAry = [[NSMutableArray alloc] init];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.tableview.showsVerticalScrollIndicator = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.recordAry removeAllObjects];
    __block FirstViewController *weakself = self;
    [gHappyDAO getRecordByRecordId:^(NSMutableArray *records)
    {
        weakself.recordAry = records;
        [weakself.tableview reloadData];
    }];
    
    self.recodrCountLabel.text = [NSString stringWithFormat:@"%ld",(long)[gHappyDAO numberOfRecord]];
}

- (IBAction)addRecord:(id)sender
{
    AddViewController *avc = [[AddViewController alloc] init];
    avc.isAdd = YES;
    [self presentViewController:avc animated:YES completion:nil];
}

- (IBAction)allRecord:(id)sender {
    __block FirstViewController *weakself = self;
    [gHappyDAO getAllRecord:^(NSMutableArray *records)
     {
         weakself.recordAry = records;
         [weakself.tableview reloadData];
     }];

}

- (IBAction)sortByscore:(id)sender
{
    __block FirstViewController *weakself = self;
    [gHappyDAO getRecordByRand:^(NSMutableArray *records)
     {
         weakself.recordAry = records;
         [weakself.tableview reloadData];
     }];
}

- (IBAction)sortByRecordId:(id)sender
{
    __block FirstViewController *weakself = self;
    [gHappyDAO getRecordByRecordId:^(NSMutableArray *records)
     {
         weakself.recordAry = records;
         [weakself.tableview reloadData];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell1 *cell = (DetailCell1 *)[tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if(cell== nil)
    {
        cell = [[DetailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
    }
    HappyDetail *detail = self.recordAry[indexPath.row];
    [cell setupCell:detail];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HappyDetail *hd = self.recordAry[indexPath.row];
    AddViewController *avc = [[AddViewController alloc] init];
    avc.happyDetail = hd;
    avc.isAdd = NO;
    [self presentViewController:avc animated:YES completion:nil];
}

@end
