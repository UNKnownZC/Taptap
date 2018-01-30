//
//  GameViewController.h
//  Assignment 2
//
//  Created by Zuck Chen on 16/5/5.
//  Copyright (c) 2016年 Zekun Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController
{
    //score relative
    IBOutlet UILabel *currentScore;
    IBOutlet UILabel *highScore;
    BOOL inLeaderBoard;
    NSString *name1;
    NSString *name2;
    NSString *name3;
    NSInteger score1;
    NSInteger score2;
    NSInteger score3;
    NSInteger score;
    NSInteger lastTapScore;
    
    //layout relative
    IBOutlet UILabel *playerLabel;
    IBOutlet UILabel *name;
    IBOutlet UILabel *seconds;
    IBOutlet UILabel *countDownLabel;
    IBOutlet UIButton *startButton;
    IBOutlet UIButton *stopButton;
    IBOutlet UIButton *settingButton;
    IBOutlet UIButton *leaderBoardButton;
    NSTimer *timer;
    NSTimer *gameTimer;
    NSTimer *refreshTimer;
    NSTimer *threeTwoOneTimer;
    
    //game and bubbles relative
    UIColor *pinkColor;
    NSInteger screenWidth;
    NSInteger screenLenth;
    NSMutableArray *bubbles;
    NSMutableArray *removedBubbles;
    NSInteger nextNumOfBubbles;
    NSInteger stopTime;
    NSInteger refreshTime;
    NSInteger threeTwoOneGo;


}

@property (weak, nonatomic) NSString *playerName;
@property NSInteger timeleft;
@property NSUInteger maxNumOfBubbles;
-(IBAction)startGame;
-(IBAction)stopGame;


@end
