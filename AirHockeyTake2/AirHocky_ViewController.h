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
@interface PaddlesViewController : UIViewController{
	UITouch *touch1_top;
	UITouch *touch2_bot;
	UIAlertView *alert;
	float dx,dy,speed;
	NSTimer * timer;
	int numPaddleCollisions;
	SystemSoundID sounds[3];
}
@property (strong, nonatomic) IBOutlet UIView *viewPaddle1_top;
@property (strong, nonatomic) IBOutlet UIView *viewPaddle2_bot;
@property (strong, nonatomic) IBOutlet UIView *viewPuck;
@property (strong, nonatomic) IBOutlet UILabel *viewScore1_top;
@property (strong, nonatomic) IBOutlet UILabel *viewScore2_bot;


@property (strong, nonatomic) IBOutlet UILabel *Player_1_label;
@property (strong, nonatomic) IBOutlet UILabel *Player_2_label;

//@property (strong, nonatomic) IBOutlet UIView *viewPuck_0;//do not use.  I don't know how to get rid of this without crashing the program

//public methods
-(void) pause;
-(void) resume;