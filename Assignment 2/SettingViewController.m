//
//  SettingViewController.m
//  Assignment 2
//
//  Created by Zuck Chen on 16/5/5.
//  Copyright (c) 2016年 Zekun Chen. All rights reserved.
//

#import "SettingViewController.h"
#import "GameViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

@synthesize timeField;
@synthesize maxBubbleField;
@synthesize nameEnter;


- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backgroundTap:(UITapGestureRecognizer *)sender
{
    [self exitKeyboard:sender];
}

- (IBAction)exitKeyboard:(id)sender
{
    [nameEnter resignFirstResponder];
    [timeField resignFirstResponder];
    [maxBubbleField resignFirstResponder];
}

- (IBAction)playGame
{
    if([timeField.text isEqualToString: @"0"])
    {
        UIAlertView *errorMessage =[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Time cannot be 0" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorMessage show];
    }
    else if([timeField.text integerValue] > 90 ||[timeField.text integerValue] < 5)
    {
        UIAlertView *errorMessage =[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Recommended game time: 5s to 90s" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorMessage show];
    }
    else if([maxBubbleField.text isEqualToString:@"0"])
    {
        UIAlertView *errorMessage =[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Maximum number of bubbles cannot be 0" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorMessage show];
    }
    else if([maxBubbleField.text integerValue] > 20 ||[maxBubbleField.text integerValue] < 5)
    {
        UIAlertView *errorMessage =[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Recommended maximum number of bubbles: 5 to 20" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorMessage show];
    }
    else if([nameEnter.text  isEqual: @""])
    {
        UIAlertView *errorMessage =[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please enter a name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorMessage show];
    }
    else if((nameEnter.text.length) > 10)
    {
        UIAlertView *errorMessage =[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Name should be under 10 charactors" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorMessage show];
    }
    else
    {
        [self performSegueWithIdentifier:@"PlayGame" sender:self];
    }
}

// pass time and maxBubble setting to game view
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PlayGame"])
    {
        GameViewController *gvc = segue.destinationViewController;
        NSString *t = timeField.text;
        NSString *m = maxBubbleField.text;
        NSString *n = nameEnter.text;
        gvc.timeleft = t.integerValue;
        gvc.maxNumOfBubbles = m.integerValue;
        gvc.playerName = [NSString stringWithFormat:@"%@", n];
    }
}

- (IBAction)defaultSetting
{
    timeField.text = @"60";
    maxBubbleField.text = @"15";
}

@end
