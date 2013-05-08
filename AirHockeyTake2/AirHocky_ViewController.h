//
//  AirHocky_ViewController.h
//  AirHockeyTake2
//
//  Created by Derrick Ho on 5/3/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>
#import "Paddle.h"
@interface AirHocky_ViewController : UIViewController{
	//UITouch *touch1_top;
	//UITouch *touch2_bot;
	UIAlertView *alert;
	float dx,dy,speed;
	NSTimer * timer;
	int numPaddleCollisions;
	SystemSoundID sounds[3];
	Paddle * paddle1_top;
	Paddle * paddle2_bot;
}
@property (strong, nonatomic) IBOutlet UIView *viewPaddle1_top;
@property (strong, nonatomic) IBOutlet UIView *viewPaddle2_bot;
@property (strong, nonatomic) IBOutlet UIView *viewPuck;
@property (strong, nonatomic) IBOutlet UILabel *viewScore1_top;
@property (strong, nonatomic) IBOutlet UILabel *viewScore2_bot;


@property (strong, nonatomic) IBOutlet UILabel *Player_1_label;
@property (strong, nonatomic) IBOutlet UILabel *Player_2_label;

//barriers/walls
@property (strong, nonatomic) IBOutlet UIView *WallBarrierLeft;
@property (strong, nonatomic) IBOutlet UIView *WallBarrierRight;
@property (strong, nonatomic) IBOutlet UIView *WallGoalBarrierTopLeft;
@property (strong, nonatomic) IBOutlet UIView *WallGoalBarrierTopRight;
@property (strong, nonatomic) IBOutlet UIView *WallInnerGoalBarrierTopLeft;
@property (strong, nonatomic) IBOutlet UIView *WallInnerGoalBarrierTopRight;
@property (strong, nonatomic) IBOutlet UIView *WallGoalBarrierBottomLeft;
@property (strong, nonatomic) IBOutlet UIView *WallGoalBarrierBottomRight;
@property (strong, nonatomic) IBOutlet UIView *WallInnerGoalBarrierBottomLeft;
@property (strong, nonatomic) IBOutlet UIView *WallInnerGoalBarrierBottomRight;





//public methods
-(void) pause;
-(void) resume;
@end