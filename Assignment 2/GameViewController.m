//
//  GameViewController.m
//  Assignment 2
//
//  Created by Zuck Chen on 16/5/5.
//  Copyright (c) 2016年 Zekun Chen. All rights reserved.
//

#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GameViewController ()

@end


@implementation GameViewController

@synthesize playerName;
@synthesize timeleft, maxNumOfBubbles;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initScoreBoard];
    name.text = playerName;
    
    // get screen size
    screenWidth = self.view.frame.size.width;
    screenLenth = self.view.frame.size.height;
    
    // other initialization
    [stopButton setBackgroundColor:[UIColor redColor]];
    stopButton.hidden = YES;
    countDownLabel.hidden = YES;
    seconds.text = [NSString stringWithFormat:@"%li s", (long)timeleft];
    pinkColor = [UIColor colorWithRed:254/255.0 green:192/255.0 blue:203/255.0 alpha:1];
    stopTime = timeleft;
    refreshTime = timeleft;
    threeTwoOneGo = 4;
    
}

- (void) initScoreBoard
{
    name1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nameNo1"];
    name2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nameNo2"];
    name3 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nameNo3"];
    [[NSUserDefaults standardUserDefaults] setObject:name1 forKey:@"nameNo1"];
    [[NSUserDefaults standardUserDefaults] setObject:name2 forKey:@"nameNo2"];
    [[NSUserDefaults standardUserDefaults] setObject:name3 forKey:@"nameNo3"];
    
    score1 = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreNo1"];
    score2 = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreNo2"];
    score3 = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreNo3"];
    [[NSUserDefaults standardUserDefaults] setInteger:score1 forKey:@"scoreNo1"];
    [[NSUserDefaults standardUserDefaults] setInteger:score2 forKey:@"scoreNo2"];
    [[NSUserDefaults standardUserDefaults] setInteger:score3 forKey:@"scoreNo3"];
    highScore.text = [NSString stringWithFormat:@"%li",(long)score1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//touch event (recognise tapped color and score)
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchedLocation = [touch locationInView:self.view];
    for(int i = 0; i < (bubbles.count) ; i++)
    {
        UIView *touchedView = [bubbles objectAtIndex:i];
        if(CGRectContainsPoint([[bubbles objectAtIndex:i] frame], touchedLocation))
        {
            if((touchedView.backgroundColor) == [UIColor redColor])
            {
                if(lastTapScore == 1)
                {
                    score = score + 2;
                }
                else
                {
                    score = score + 1;

                }
                lastTapScore = 1;
                currentScore.text = [NSString stringWithFormat:@"%li", (long)score];
            }
            else if([touchedView.backgroundColor isEqual:pinkColor])
            {
                if(lastTapScore == 2)
                {
                    score = score + 3;
                }
                else
                {
                    score = score + 2;
                }
                lastTapScore = 2;
                currentScore.text = [NSString stringWithFormat:@"%li", (long)score];
            }
            else if((touchedView.backgroundColor) == [UIColor greenColor])
            {
                if(lastTapScore == 5)
                {
                    score = score + 8;
                }
                else
                {
                    score = score + 5;
                }
                lastTapScore = 5;
                currentScore.text = [NSString stringWithFormat:@"%li", (long)score];
            }
            else if((touchedView.backgroundColor) == [UIColor blueColor])
            {
                if(lastTapScore == 8)
                {
                    score = score + 12;
                }
                else
                {
                    score = score + 8;
                }
                lastTapScore = 8;
                currentScore.text = [NSString stringWithFormat:@"%li", (long)score];
            }
            else if((touchedView.backgroundColor) == [UIColor blackColor])
            {
                if(lastTapScore == 10)
                {
                    score = score + 15;
                }
                else
                {
                    score = score + 10;
                }
                lastTapScore = 10;
                currentScore.text = [NSString stringWithFormat:@"%li", (long)score];
            }
            [[bubbles objectAtIndex:i] removeFromSuperview];
            [bubbles removeObjectAtIndex:i];
        }
    }
}

//game functions
- (void) gameBeginCountDown
{
    threeTwoOneGo = threeTwoOneGo - 1;
    countDownLabel.text = [NSString stringWithFormat:@"%li", (long)(threeTwoOneGo - 1)];
    if(threeTwoOneGo == 1)
    {
        countDownLabel.text = [NSString stringWithFormat:@"GO!"];
    }
    if(threeTwoOneGo == 0)
    {
        countDownLabel.hidden = YES;
        [threeTwoOneTimer invalidate];
    }
}

- (void) fireTimer
{
    bubbles = [[NSMutableArray alloc] initWithCapacity:maxNumOfBubbles];
    [self initGame];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target: self selector:@selector(countDown) userInfo:nil repeats:YES];
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:1 target: self selector:@selector(initGame) userInfo:nil repeats:YES];
    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:1 target: self selector:@selector(refreshBubbles) userInfo:nil repeats:YES];
}

- (IBAction)startGame
{
    stopButton.hidden = NO;
    startButton.hidden = YES;
    settingButton.hidden = YES;
    leaderBoardButton.hidden = YES;
    playerLabel.hidden = YES;
    name.hidden = YES;
    countDownLabel.hidden = NO;
    countDownLabel.text = [NSString stringWithFormat:@"%li",(long)(threeTwoOneGo - 1)];
    
    threeTwoOneTimer = [NSTimer scheduledTimerWithTimeInterval:1 target: self selector:@selector(gameBeginCountDown) userInfo:nil repeats:YES];
    
    [self performSelector:@selector(fireTimer) withObject:nil afterDelay:3];
}

- (IBAction)stopGame
{
    UIAlertView *warningMessage =[[UIAlertView alloc] initWithTitle:@"Attention!" message:@"Stop game?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles: @"Cancel", nil];
    [warningMessage show];
    [self recordScore];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [timer invalidate];
        [gameTimer invalidate];
        stopButton.hidden = YES;
        leaderBoardButton.hidden = NO;
        
        UIView *clearView;
        for(clearView in bubbles)
        {
            [clearView removeFromSuperview];
        }
        [bubbles removeAllObjects];
        settingButton.hidden = NO;
        // display message
        if(inLeaderBoard == true)
        {
            UIAlertView *overMessage =[[UIAlertView alloc] initWithTitle:@"GAME OVER!" message:([NSString stringWithFormat:@"Your Final Score: %li \nYou are in Leader Board", (long)score]) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [overMessage show];
        }
        else
        {
            UIAlertView *overMessage =[[UIAlertView alloc] initWithTitle:@"GAME OVER!" message:([NSString stringWithFormat:@"Your Final Score: %li \nTry Again!", (long)score]) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [overMessage show];
        }
    }
}

- (void)countDown
{
    timeleft = timeleft - 1;
    seconds.text = [NSString stringWithFormat:@"%li s", (long)timeleft];
    if(timeleft <= 0)
    {
        [timer invalidate];
        [self recordScore];
        stopButton.hidden = YES;
        leaderBoardButton.hidden = NO;
        // clear subview
        UIView *clearView;
        for(clearView in bubbles)
        {
            [clearView removeFromSuperview];
        }
        // display message
        if(inLeaderBoard == true)
        {
            UIAlertView *overMessage =[[UIAlertView alloc] initWithTitle:@"GAME OVER!" message:([NSString stringWithFormat:@"Your Final Score: %li \nYou are in Leader Board", (long)score]) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [overMessage show];
        }
        else
        {
            UIAlertView *overMessage =[[UIAlertView alloc] initWithTitle:@"GAME OVER!" message:([NSString stringWithFormat:@"Your Final Score: %li \nTry Again!", (long)score]) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [overMessage show];
        }
    }
}

- (void)recordScore
{
    if(score >= score1)
    {
        inLeaderBoard = true;
        highScore.text = [NSString stringWithFormat:@"%li",(long)score];
        [[NSUserDefaults standardUserDefaults] setObject:name2 forKey:@"nameNo3"];
        [[NSUserDefaults standardUserDefaults] setObject:name1 forKey:@"nameNo2"];
        [[NSUserDefaults standardUserDefaults] setObject:playerName forKey:@"nameNo1"];
        [[NSUserDefaults standardUserDefaults] setInteger:score2 forKey:@"scoreNo3"];
        [[NSUserDefaults standardUserDefaults] setInteger:score1 forKey:@"scoreNo2"];
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"scoreNo1"];
    }
    else if(score >= score2 && score < score1)
    {
        inLeaderBoard = true;
        [[NSUserDefaults standardUserDefaults] setObject:name2 forKey:@"nameNo3"];
        [[NSUserDefaults standardUserDefaults] setObject:playerName forKey:@"nameNo2"];
        [[NSUserDefaults standardUserDefaults] setInteger:score2 forKey:@"scoreNo3"];
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"scoreNo2"];
    }
    else if(score >= score3 && score < score2)
    {
        inLeaderBoard = true;
        [[NSUserDefaults standardUserDefaults] setObject:playerName forKey:@"nameNo3"];
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"scoreNo3"];
    }
    else
    {
        inLeaderBoard = false;
    }
}

- (void)initGame
{
    float rn = 0;
    if(rn < nextNumOfBubbles)
    {
        rn = arc4random() % nextNumOfBubbles + 1;
    }
    else
    {
        rn = 0;
    }
    for(int i = 0; i < rn; i++)
    {
        [self createBubble:i];
    }
    nextNumOfBubbles = maxNumOfBubbles - bubbles.count;
    
    stopTime = stopTime - 1;
    if(stopTime <= 0)
    {
        [gameTimer invalidate];
    }
    [self recordScore];
}

-(void) createBubble: (int)n
{
    float rX = (arc4random() % (screenWidth - 65) + 5);
    float rY = (arc4random() % (screenLenth - 110) + 50);
    float color = (arc4random() % 20)+ 1;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(rX, rY, 60, 60)];
    if(color >= 1 && color <= 8)
    {
        view.backgroundColor = [UIColor redColor];
    }
    else if(color >= 9 && color <= 14)
    {
        view.backgroundColor = pinkColor;
    }
    else if(color >= 15 && color <= 17)
    {
        view.backgroundColor = [UIColor greenColor];
    }
    else if(color >= 18 && color <= 19)
    {
        view.backgroundColor = [UIColor blueColor];
    }
    else if(color == 20)
    {
        view.backgroundColor = [UIColor blackColor];
    }
    view.layer.cornerRadius = 30;
    if([self checkOverlap:view] != 0)
    {
        [self createBubble:n];
    }
    else if([self checkOverlap:view] == 0)
    {
        [self.view addSubview: view];
        [bubbles addObject: view];
    }
}

- (int) checkOverlap: (UIView*) view
{
    int check = 0;
    for (int n = 0; n < bubbles.count; n++)
    {
        if((CGRectIntersectsRect([[bubbles objectAtIndex:n] frame], view.frame)))
        {
            check = check + 1;
        }
        else
        {
            check = check + 0;
        }
    }
    return check;
}

- (void) refreshBubbles
{
    refreshTime = refreshTime - 1;
    UIView *refreshView;
    for(refreshView in bubbles)
    {
        float refreshOrNot = arc4random() % 2;
        if(refreshOrNot == 0)
        {
            [self newColorAndPosition:refreshView];
        }
    }
    if(refreshTime == 0)
    {
        [refreshTimer invalidate];
    }
}

- (void) newColorAndPosition:(UIView*) view
{
    float newX = (arc4random() % (screenWidth - 65) + 5);
    float newY = (arc4random() % (screenLenth - 110) + 50);
    UIView *checkView = [[UIView alloc] initWithFrame:CGRectMake(newX, newY, 60, 60)];
    if([self checkOverlap:checkView] == 0)
    {
        view.frame = CGRectMake(newX, newY, 60, 60);
        float color = (arc4random() % 20)+ 1;
        if(color >= 1 && color <= 8)
        {
            view.backgroundColor = [UIColor redColor];
        }
        else if(color >= 9 && color <= 14)
        {
            view.backgroundColor = pinkColor;
        }
        else if(color >= 15 && color <= 17)
        {
            view.backgroundColor = [UIColor greenColor];
        }
        else if(color >= 18 && color <= 19)
        {
            view.backgroundColor = [UIColor blueColor];
        }
        else if(color == 20)
        {
            view.backgroundColor = [UIColor blackColor];
        }
    }
    else if([self checkOverlap:checkView] == 1)
    {
        [self newColorAndPosition:view];
    }
}


@end
