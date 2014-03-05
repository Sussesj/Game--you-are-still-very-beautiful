//
//  ViewController.h
//  Eddie
//
//  Created by Jah Jah Bing on 14/03/13.
//  Copyright (c) 2013 Jah Jah Bing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController :
UIViewController <UIAccelerometerDelegate>
{
    CGPoint ballVelocity;
    CGPoint trianglVelocity;
    CGPoint tcenter; 
    
    CADisplayLink* gameTimer;
    
    UIImageView* ball;
    UIImageView* tiger;
    UIImageView* triangl;
    UIImageView* nLetter;
    UIImageView* yLetter;
    CGFloat lastTime;
    CGFloat timeDelta;
    int score;
    int level; 
    int scoreTime;
    SystemSoundID sounds[10];
    
     
}
-(void) updateDisplay:(CADisplayLink*)sender; 
-(void) checkCollisionWithTiger;
-(void) endGameWithMessage:(NSString*) message;
-(void) winGameWithMessage:(NSString*) message;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UILabel *myScore;
@property (weak, nonatomic) IBOutlet UILabel *myLabelTo;
@property (weak, nonatomic) IBOutlet UILabel *myLevel;

@end