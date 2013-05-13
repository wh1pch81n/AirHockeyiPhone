//
//  Puck.m
//  AirHockeyTake2
//
//  Created by Derrick Ho on 5/8/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import "Puck.h"
#define rBOUNDRY_0 0
#define rGOAL1_1 1
#define rGOAL2_2 2
@implementation Puck
@synthesize maxSpeed, speed, dx, dy, winner;
//initialize object
-(id) initWithPuck: (UIView*) puck
		  Boundary: (CGRect) boundary
			 Goal1:(CGRect) goal1
			 Goal2:(CGRect) goal2
		  MaxSpeed: (float) max{
	self = [super init];
	if(self){
		//custom initialization boundry
		view = puck;
		rect[0] = boundary;
		rect[1] = goal1;
		rect[2] = goal2;
		maxSpeed = max;
	}
	return self;
}

//reset position to middle of boundry
-(void) reset{
	float x = rect[rGOAL1_1].origin.x + arc4random() % ((int)rect[rGOAL1_1 ].size.width );
	float y = rect[rBOUNDRY_0].origin.x + rect[rBOUNDRY_0].size.height/2;
	view.center = CGPointMake(x, y);
	
	box = 0;
	speed = 0;
	dx = 0;
	dy = 0;
	winner = 0;
}

//returns current center position of puck
-(CGPoint) center{
	return  view.center;
}

//animate the puck and return true if a wall was hit
-(bool) animate{
	//if there is a winner there is no more animation to do
	if(winner != 0) return false;
	bool hit = false;
	//slow the puck speed due to table fricktion but always keep
	//it in motion after initial hit
	//otherwise it could get trapped inside a players goal
	if( speed > 0.1){
		speed *= 0.99;
	}
	else{
		speed = 0.1;
	}
	
	//move the ball to a new position based on current direction and speed
	CGPoint pos = CGPointMake(view.center.x + dx * speed,
							  view.center.y + dy * speed);
	//check if we are in the goal boxes
	if(box == 0 && CGRectContainsPoint(rect[rGOAL1_1], pos) )		{
		//puck now in goal box 1
		box = 1;
	}
	else if( box == 0 && CGRectContainsPoint(rect[rGOAL2_2], pos)){
		//puck now in goal box 2
		box = 2;
	}
	else if( CGRectContainsPoint(rect[box], pos) == false)	{
		//handle wall collisions in our current box
		if( view.center.x < rect[box].origin.x){
			pos.x = rect[box].origin.x;
			dx = fabs(dx);
			hit = true;
		}
		else if( pos.x > rect[box].origin.x + rect[box].size.width){
			pos.x = rect[box].origin.x + rect[box].size.width;
			dx = -fabs(dx);
			hit = true;
		}
		if (pos.y < rect[box].origin.y) {
			pos.y = rect[box].origin.y;
			dy = fabs(dy);
			hit = true;
			//check for win
			if(box == 1) winner = 2;
		}
		else if( pos.y > rect[box].origin.y + rect[box].size.height){
			pos.y = rect[box].origin.y + rect[box].size.height;
			dy = -fabs(dy);
			hit = true;
			//check for win
			if(box == 2) winner = 1;
		}
	}
	//put puck into new position
	view.center = pos;
	return hit;
	
}

//check for collision with paddle and alter path of puck if so
-(bool) handleCollision: (Paddle*) paddle{
	//max distance that a puck and paddle could be for
	//intersection is half of each size
	//paddle is ( 64x 64) = 32 and puck is ( 40x40) = 20
	//= max distance of 52
	static float maxDistance = 52;
	
	//get our current distance from center point of rectangle
	float currentDistance = [ paddle distance: view.center];
	
	//check for true contact
	if( currentDistance <= maxDistance){
		//check the direction of the puck
		dx = ( view.center.x - paddle.center.x) /32.0;
		dy = ( view.center.y - paddle.center.y) /32.0;
		
		//adjust ball speed to reflect current speed
		//plus paddle speed
		speed = 0.2 + speed/ 2.0 + paddle.speed;
		
		//limit to max speed
		if( speed > maxSpeed) speed = maxSpeed;
		
		//reposition puck outside the paddle radius
		//so we don't hit it again
		float r = atan2( dy, dx);
		float x = paddle.center.x + cos(r) * (maxDistance + 1);
		float y = paddle.center.y + sin(r) * (maxDistance + 1);
		view.center = CGPointMake(x, y);
		
		return true;
	}
	return false;
}

@end
