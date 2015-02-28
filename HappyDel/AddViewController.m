//
//  AddViewController.m
//  HappyDel
//
//  Created by NL on 15-1-15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "AddViewController.h"
#import "Constants.h"
#import "HappyDAO.h"

@interface AddViewController ()

@property (strong, nonatomic) IBOutlet UITextField *idField;
@property (strong, nonatomic) IBOutlet UITextField *myRankField;
@property (strong, nonatomic) IBOutlet UITextField *myScoreField;
@property (strong, nonatomic) IBOutlet UITextField *bestRankField;
@property (strong, nonatomic) IBOutlet UITextField *bestScoreField;
@property (strong, nonatomic) IBOutlet UITextField *threeStar;
@property (strong, nonatomic) IBOutlet UISwitch *statusSlide;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation AddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.happyDetail)
    {
        self.happyDetail = [[HappyDetail alloc] init];
    }
    else
    {
        self.idField.text = [NSString stringWithFormat:@"%d",self.happyDetail.recordId];
        self.myRankField.text = [NSString stringWithFormat:@"%d",self.happyDetail.curRank];
        self.myScoreField.text = self.happyDetail.curScore;
        self.bestScoreField.text = self.happyDetail.bestScore;
        self.threeStar.text = self.happyDetail.threeStar;
        self.statusSlide.on = self.happyDetail.isCompleted;
    }
    self.bestRankField.text = @"1";
}

- (IBAction)savePressed:(id)sender
{
    [self.view endEditing:YES];
    self.happyDetail.recordId = self.idField.text.integerValue;
    self.happyDetail.curRank = self.myRankField.text.integerValue;
    self.happyDetail.curScore = [self _dealData:self.myScoreField.text];
    self.happyDetail.bestRank = 1;
    self.happyDetail.bestScore = [self _dealData:self.bestScoreField.text];
    self.happyDetail.threeStar = self.threeStar.text;
    self.happyDetail.isCompleted = self.statusSlide.on;
    if (self.isAdd)
    {
        if ([gHappyDAO addRecord:self.happyDetail])
        {
            NSLog(@"==addRecord==OK");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            NSLog(@"==addRecord==error");
        }

    }
    else
    {
        if ([gHappyDAO updateRecord:self.happyDetail])
        {
            NSLog(@"==updateRecord==OK");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            NSLog(@"==updateRecord==error");
        }
    }
}


- (NSString *)_dealData:(NSString *)text
{
    if (text.length == 0)
    {
        return @"0";
    }
    else
    {
        return text;
    }
}

- (IBAction)backPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
