//
//  ScoreViewController.h
//  Assignment 2
//
//  Created by Zuck Chen on 16/5/9.
//  Copyright (c) 2016年 Zekun Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreViewController : UIViewController

//layout relative
@property (weak, nonatomic) IBOutlet UILabel *nameNo1;
@property (weak, nonatomic) IBOutlet UILabel *nameNo2;
@property (weak, nonatomic) IBOutlet UILabel *nameNo3;
@property (weak, nonatomic) IBOutlet UILabel *scoreNo1;
@property (weak, nonatomic) IBOutlet UILabel *scoreNo2;
@property (weak, nonatomic) IBOutlet UILabel *scoreNo3;

//top3 leader board data
@property (weak, nonatomic) NSString *name1;
@property (weak, nonatomic) NSString *name2;
@property (weak, nonatomic) NSString *name3;
@property NSInteger score1;
@property NSInteger score2;
@property NSInteger score3;

- (IBAction)resetRecord;
@end
