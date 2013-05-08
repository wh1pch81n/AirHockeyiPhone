//
//  Paddle.h
//  AirHockeyTake2
//
//  Created by Derrick Ho on 5/7/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Paddle : NSObject
{
	UIView* view; //paddle view with current position
	CGRect boundry; //confined boundry
	CGPoint pos; //position paddle is moving to
	float maxSpeed; //max speed
	float speed; //current speed
	//UITouch* _touch; //touch assigned to this paddle
}
@property(assign) UITouch * touch;//touch assigned to this paddle
@property(readonly) float speed;
@property(assign) float maxSpeed;

-(id) initWithView:(UIView*) paddle Boundry: (CGRect) rect
		  MaxSpeed: (float) max;
//reset position to middle of boundry
-(void) reset;

//set where the paddle should move to
-(void) move: (CGPoint) pt;

//center point of paddle
-(CGPoint) center;

//check of the paddle intersects with the rectangle
-(bool) intersects: (CGRect) rect;

//get distance between paddle postion and point
-(float) distance: (CGPoint) pt;

//animate puck view to next position without exceeding max speed
-(void) animate;

@end
