//
//  AirHocky_ViewController.m
//  AirHockeyTake2
//
//  Created by Derrick Ho on 5/3/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import "AirHocky_ViewController.h"

#define MAX_SCORE 3
#define PLAYER1_TOP_WON 1
#define PLAYER2_BOT_WON 2
#define SOUND_WALL 0
#define SOUND_PADDLE 1
#define SOUND_SCORE 2

@interface PaddlesViewController ()
@end

@implementation PaddlesViewController
@synthesize viewPaddle1_top;
@synthesize viewPaddle2_bot;
//@synthesize viewPuck_0;//do not use
@synthesize viewPuck;
@synthesize viewScore1_top;
@synthesize viewScore2_bot;
@synthesize Player_1_label;
@synthesize Player_2_label;

-(void) pause{
	[self stop];
}
-(void) resume{
	//present a message to continue
	[self displayMessage:@"Game Paused"];
}

-(int) gameOver
{
	if([viewScore1_top.text intValue] >= MAX_SCORE) return PLAYER1_TOP_WON;
	if([viewScore2_bot.text intValue] >= MAX_SCORE) return PLAYER2_BOT_WON;
	return 0;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self initSounds];
	[self newGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setViewPaddle1_top:nil];
    [self setViewPaddle2_bot:nil];
  //  [self setViewPuck_0:nil];//unused.  can't comment out for some reason
	[self setViewPuck:nil];
	[self setViewScore1_top:nil];
	[self setViewScore2_bot:nil];
	[self setPlayer_1_label:nil];
	[self setPlayer_2_label:nil];
    [super viewDidUnload];
}

//multi touch functions
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	//	NSLog(@"touchesBegan");
	//	for(UITouch *touch in touches){
	//		NSLog(@" - %p", touch);
	//	}
	////////
	//iterate through our touch elements
	for (UITouch *touch in touches) {
		//get the point of touch within the view
		CGPoint touchPoint = [touch locationInView:self.view];
		
		//move the paddle based on which half of the screen the touch falls into
		if (!touch1_top && 0< touchPoint.y && touchPoint.y < 100) {
			touch1_top = touch;
			viewPaddle1_top.center = CGPointMake(touchPoint.x, viewPaddle1_top.center.y);
		}else if (!touch2_bot && 379 < touchPoint.y && touchPoint.y < 479){
			touch2_bot = touch;
			viewPaddle2_bot.center = CGPointMake(touchPoint.x, viewPaddle2_bot.center.y);
		}
	}
}
//multi touch functions
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	//	NSLog(@"touchesMoved");
	//	for(UITouch *touch in touches){
	//		NSLog(@" - %p", touch);
	//	}
	
	for (UITouch *touch in touches) {
		//get the point of touch within the view
		CGPoint touchPoint = [touch locationInView:self.view];
		//if the touch is assigned to our paddle then move it
		if(touch == touch1_top){
			viewPaddle1_top.center = CGPointMake(touchPoint.x, viewPaddle1_top.center.y);
		}else if(touch == touch2_bot){
			viewPaddle2_bot.center = CGPointMake(touchPoint.x, viewPaddle2_bot.center.y);
		}else{
			
		}
	}
}
//multi touch functions
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	//	NSLog(@"touchesEnded");
	//	for(UITouch *touch in touches){
	//		NSLog(@" - %p", touch);
	//	}
	for (UITouch *touch in touches) {
		if(touch == touch1_top ) touch1_top = nil;
		else if(touch == touch2_bot) touch2_bot = nil;
	}
}
//multi touch functions
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	//	NSLog(@"touchesEnded");
	//	for(UITouch *touch in touches){
	//		NSLog(@" - %p", touch);
	//	}
	//We enter this function if the phone is interupped ie phone call or alarm.
	//YOu need to remove all touches to prevent the players from losing control
	//of their paddles.
	[self touchesEnded:touches withEvent:event];
}
-(void)reset{
	//set direction of ball to either left or right direction
	dx = ((arc4random()%2) == 0)? -1: 1;
	
	//reverse dy if not 0 as this will send the puck to the
	//player who just scored otherwise set in random direction
	dy = (dy != 0)? -dy:((arc4random() %2) == 0)? -1 : 1;
	
	//move point to random position in center
	viewPuck.center = CGPointMake(15 + arc4random() % (320-30), 240);
	
	//reset speed of puck
	speed = 2;
	
	//reset size of paddles
	CGRect newFrame1 = viewPaddle1_top.frame;
	newFrame1.size.width = 64;
	viewPaddle1_top.frame = newFrame1;
	
	CGRect newFrame2 = viewPaddle2_bot.frame;
	newFrame2.size.width = 64;
	viewPaddle2_bot.frame = newFrame2;
	//reset collisions
	numPaddleCollisions = 0;
}
-(void)start{
	if(timer == nil){
		//create out animation timer
		timer =  [NSTimer
				  scheduledTimerWithTimeInterval:(1.0/60.0)
				  target:self
				  selector:@selector(animate)
				  userInfo:NULL
				  repeats:YES
				  ];
		//		 [[NSTimer
		//				  scheduledTimerWithTimeInterval:1.0/60.0
		//				  target: self
		//				  selector:@selector(animate)
		//				  userInfo:NULL
		//				  repeats:YES] retain];
	}
	//show the puck
	viewPuck.hidden = NO;
}
-(void) stop{
	if (timer != nil) {
		[timer invalidate];
		//[timer release];
		timer = nil;
	}
	//hide the puck
	viewPuck.hidden = YES;
}
-(void) displayMessage:( NSString*) msg{
	//do not display more than one message
	if(alert) return;
	
	//stop animation timer
	[self stop];
	
	//creat and show alert message
	
	alert = [[UIAlertView new] initWithTitle:@"Game"
									 message:msg
									delegate:self
						   cancelButtonTitle:@"ok"
						   otherButtonTitles: nil];
	[alert show];
}
-(void)newGame
{
	[self reset];
	
	//reset score
	viewScore1_top.text = [NSString stringWithFormat: @"%@", @"0"];
	viewScore2_bot.text = [NSString stringWithFormat: @"%@", @"0"];
	
	[Player_1_label setTransform:CGAffineTransformMakeRotation(M_PI/2)];//rotate the label
	[Player_2_label setTransform:CGAffineTransformMakeRotation(M_PI/2)];
	
	//present message to start game
	[self displayMessage:@"ready to play?"];
}

-(void)alertView:(UIAlertView*)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	//message dismissed so reset our game and start animation
	alert = nil;
	
	//check if we should start a new game
	if([self gameOver]){
		[self newGame];
		return;
	}
	
	//reset round
	[self reset];
	//start animation
	[self start];
}
-(BOOL)checkPuckCollision: (CGRect) rect
					 DirX: (float) x
					 DirY: (float) y
{
	//check if the puck intersects with rectable passed
	if (CGRectIntersectsRect(viewPuck.frame, rect))
		{
		//change the direction of the ball
		if(x != 0.0) {dx = x;}
		if(y != 0.0){
			dy = y;
			//count the number of puck collisions with the puck.
			//every ten will cause the paddles of both player to shrink.
			if ((numPaddleCollisions++ % 10)==9) {
				[self shrinkPaddleWidth];
			}
		}
		
		return TRUE;
		}
	return FALSE;
}
-(BOOL)checkGoal{
	//check of ball is out of bounds and reset game if so
	if(viewPuck.center.y <0 || viewPuck.center.y >= 480){
		//get integer value from score label
		int s1 = [viewScore1_top.text intValue];
		int s2 = [viewScore2_bot.text intValue];
		
		//give a point to correct player
		if (viewPuck.center.y <0) {
			++s2;
		}else{
			++s1;
		}
		
		//update score labels
		viewScore1_top.text = [NSString stringWithFormat:@"%u", s1];
		viewScore2_bot.text = [NSString stringWithFormat:@"%u", s2];
		
		//check for winner
		if([self gameOver] == PLAYER1_TOP_WON){
			//report winner
			[self displayMessage:@"player 1 has won"];
		}
		else if([self gameOver] == PLAYER2_BOT_WON){
			//report winner
			[self displayMessage:@"player 2 has won"];
		}else{
			//reset round
			[self reset];
		}
		//return TRUE for goal
		return TRUE;
	}
	//no goal
	return FALSE;
}
-(void)increaseSpeed{
	//NSLog(@"Increase Speed !");
	speed += 0.5;
	if(speed > 10) speed = 10;
}
-(void)shrinkPaddleWidth{
	//NSLog(@"Shink Paddles!");
	//NSLog(@"%f\n",viewPaddle1_top.frame.size.width);
	speed = 2;
	if (viewPaddle1_top.frame.size.width >30) {//set the limit on shrinking
		//shrink both paddles
		CGRect newFrame1 = viewPaddle1_top.frame;
		newFrame1.size.width -=10;
		viewPaddle1_top.frame = newFrame1;
		
		CGRect newFrame2 = viewPaddle2_bot.frame;
		newFrame2.size.width -=10;
		viewPaddle2_bot.frame = newFrame2;
		
	}
	//NSLog(@"%f\n",viewPaddle1_top.frame.size.width);
}



-(void)animate{
	
	//move puch to new position based on direction and speed
	viewPuck.center = CGPointMake(viewPuck.center.x + (dx*speed),
								  viewPuck.center.y + (dy*speed));
	//Quick and dirty AI for top paddle
	//viewPaddle1_top.center = CGPointMake(viewPuck.center.x, viewPaddle1_top.center.y);
	//check puck collision with left and right walls
	if([self checkPuckCollision:CGRectMake(-10, 0, 20, 480)
						   DirX:fabs(dx)
						   DirY:0])
		{
		[self playSound:SOUND_WALL];
		}
	if([self checkPuckCollision:CGRectMake(310, 0, 20, 480)
						   DirX:-fabs(dx)
						   DirY:0])
		{
		[self playSound:SOUND_WALL];
		}
	//check puck collision with player paddles
	if([self checkPuckCollision:viewPaddle1_top.frame
						   DirX:((viewPuck.center.x -viewPaddle1_top.center.x)/13.0)*((arc4random() %2)?-1:1)
						   DirY:1])
		{
		[self playSound:SOUND_PADDLE];
		[self increaseSpeed];
		}
	if([self checkPuckCollision:viewPaddle2_bot.frame
						   DirX:((viewPuck.center.x -viewPaddle2_bot.center.x)/13.0)*((arc4random() %2)?-1:1)
						   DirY:-1])
		{
		[self playSound:SOUND_PADDLE];
		[self increaseSpeed];
		}
	//check for goal
	if( 	[self checkGoal])
		{
		[self playSound:SOUND_SCORE];
		}
}
-(BOOL) canBecomeFirstResponder{
	return YES;
}
-(void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
}
-(void) viewWillDisappear:(BOOL)animated
{
	[self resignFirstResponder];
	[self viewWillDisappear:animated];
}

-(void)motionBegan:(UIEventSubtype)motion
		 withEvent:(UIEvent *)event
{
	if(event.type == UIEventSubtypeMotionShake)
		{
		//NSLog(@"Shake begin");
		//pause the game then resume to desplay message
		[self pause];
		[self resume];
		}
}
-(void) motionEnded:(UIEventSubtype)motion
		  withEvent:(UIEvent *)event
{
	if(event.type == UIEventSubtypeMotionShake)
		{
		//NSLog(@"Shaked ended");
		}
}
-(void) motionCancelled:(UIEventSubtype)motion
			  withEvent:(UIEvent *)event
{
	if(event.type == UIEventSubtypeMotionShake)
		{
		//NSLog(@"Shaked cancel");
		}
}

//load a sound effect into the inex of the sounds array
-(void) loadSound:(NSString*)name
			 Slot: (int) slot
{
	if(sounds[slot] != 0) return;
	
	//	//Creat pathname to sound file
	NSString *sndPath = [[NSBundle mainBundle]
						 pathForResource:name
						 ofType:@"wav"
						 inDirectory:@"/"];
	//creat system sound ID into our sound slot
	AudioServicesCreateSystemSoundID(
									 (__bridge CFURLRef) [NSURL fileURLWithPath:sndPath],
									 &sounds[slot]);
	//	CFBundleRef mainBundle = CFBundleGetMainBundle();
	//soundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR ("") , <#CFStringRef resourceType#>, <#CFStringRef subDirName#>)
}
-(void) initSounds
{
	[self loadSound:@"wall" Slot:SOUND_WALL];
	[self loadSound:@"score" Slot:SOUND_SCORE];
	[self loadSound:@"paddle" Slot:SOUND_PADDLE];
	
}
-(void)playSound: (int) slot
{
	AudioServicesPlaySystemSound(sounds[slot]);
}
@end