//
//  UpdateViewController.m
//  HappyDel
//
//  Created by NL on 15-1-16.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "UpdateViewController.h"
#import "HappyDAO.h"
#import "Constants.h"

@interface UpdateViewController ()
@property (strong, nonatomic) IBOutlet UITextField *OldScoreField;
@property (strong, nonatomic) IBOutlet UITextField *NewScoreField;

@end

@implementation UpdateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.OldScoreField.text = [NSString stringWithFormat:@"%ld",(long)self.fourstar.myScore];
}

- (IBAction)savePressed:(id)sender
{
    self.fourstar.myScore = self.NewScoreField.text.integerValue;
    if (self.NewScoreField.text.integerValue > self.fourstar.score)
    {
        self.fourstar.isCompleted = YES;
    }
    else
    {
        self.fourstar.isCompleted = NO;;
    }
    if ([gHappyDAO updateFourstar:self.fourstar])
    {
        NSLog(@"==updateRecord==OK");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        NSLog(@"==updateRecord==error");
    }
}

- (IBAction)backPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
