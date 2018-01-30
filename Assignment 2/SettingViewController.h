//
//  SettingViewController.h
//  Assignment 2
//
//  Created by Zuck Chen on 16/5/5.
//  Copyright (c) 2016年 Zekun Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UITextField *maxBubbleField;
@property (weak, nonatomic) IBOutlet UITextField *nameEnter;

- (IBAction)exitKeyboard:(id)sender;

- (void)backgroundTap: (UITapGestureRecognizer*)sender;

-(IBAction)defaultSetting;

-(IBAction)playGame;

@end
