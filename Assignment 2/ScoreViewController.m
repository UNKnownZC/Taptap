//
//  ScoreViewController.m
//  Assignment 2
//
//  Created by Zuck Chen on 16/5/9.
//  Copyright (c) 2016年 Zekun Chen. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@end

@implementation ScoreViewController

@synthesize nameNo1,nameNo2,nameNo3,scoreNo1,scoreNo2,scoreNo3;
@synthesize name1,name2,name3,score3,score2,score1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    name1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nameNo1"];
    if(name1 == NULL)
    {
        name1 = @" ";
    }
    name2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nameNo2"];
    if(name2 == NULL)
    {
        name2 = @" ";
    }
    name3 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nameNo3"];
    if(name3 == NULL)
    {
        name3 = @" ";
    }
    score1 = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreNo1"];
    score2 = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreNo2"];
    score3 = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreNo3"];
    [self update];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) update
{
    nameNo1.text = [NSString stringWithFormat:@"1. %@", name1];
    nameNo2.text = [NSString stringWithFormat:@"2. %@", name2];
    nameNo3.text = [NSString stringWithFormat:@"3. %@", name3];
    scoreNo1.text = [NSString stringWithFormat:@"%li",(long)score1];
    scoreNo2.text = [NSString stringWithFormat:@"%li",(long)score2];
    scoreNo3.text = [NSString stringWithFormat:@"%li",(long)score3];
}

- (IBAction)resetRecord
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    name1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nameNo1"];
    if(name1 == NULL)
    {
        name1 = @" ";
    }
    name2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nameNo2"];
    if(name2 == NULL)
    {
        name2 = @" ";
    }
    name3 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nameNo3"];
    if(name3 == NULL)
    {
        name3 = @" ";
    }
    score1 = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreNo1"];
    score2 = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreNo2"];
    score3 = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreNo3"];
    [self update];
}

@end
