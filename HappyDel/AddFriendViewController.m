//
//  AddFriendViewController.m
//  HappyDel
//
//  Created by NL on 15-1-15.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "AddFriendViewController.h"
#import "HappyDAO.h"
#import "Constants.h"

@interface AddFriendViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UITextField *markField;
@property (strong, nonatomic) IBOutlet UITextField *totleScoreField;
@property (strong, nonatomic) IBOutlet UITextField *pointField;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation AddFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.markField.delegate = self;
    self.totleScoreField.delegate = self;
    if (!self.friendScore)
    {
        self.friendScore = [[FriendScore alloc] init];
    }
    else
    {
        self.nameText.text = self.friendScore.Name;
        self.markField.text = [NSString stringWithFormat:@"%ld",(long)self.friendScore.MaxMark];
        self.totleScoreField.text = [NSString stringWithFormat:@"%ld",(long)self.friendScore.TotalScore];
        self.pointField.text = [NSString stringWithFormat:@"%f",(float)self.friendScore.TotalScore/(float)(self.friendScore.MaxMark-1)];
    }
}

- (IBAction)savePressed:(id)sender
{
    [self.view endEditing:YES];
    self.friendScore.Name = self.nameText.text;
    self.friendScore.MaxMark = [self _dealData:self.markField.text].integerValue;
    self.friendScore.TotalScore = [self _dealData:self.totleScoreField.text].integerValue;
    self.friendScore.Point = (float) [self _dealData:self.pointField.text].doubleValue;
    if (self.isAdd)
    {
        if ([gHappyDAO addFriend:self.friendScore])
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else
    {
        if ([gHappyDAO updateFriend:self.friendScore])
        {
            [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)textChanged:(id)sender
{
    if (self.markField.text.length > 0 && self.totleScoreField.text.length > 0)
    {
        self.pointField.text = [NSString stringWithFormat:@"%f",self.totleScoreField.text.doubleValue / (self.markField.text.doubleValue-1)];
    }
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
