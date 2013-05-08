//
//  Paddle.m
//  AirHockeyTake2
//
//  Created by Derrick Ho on 5/7/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import "Paddle.h"

@implementation Paddle

@synthesize  touch;
@synthesize speed;
@synthesize maxSpeed;
-(id) initWithView:(UIView*) paddle Boundry: (CGRect) rect
		  MaxSpeed: (float) max
{
	self = [super init];
	if(self){
		//custom initialiation
		view = paddle;
		boundry =rect;
		maxSpeed = max;
	}
	return self;
}
//-(void) dealloc{
//	[super dealloc];
//}
//reset position to middle of boundry
-(void) reset{
	pos.x = boundry.origin.x + boundry.size.width/2;
	pos.y = boundry.origin.y + boundry.size.height/2;
	view.center = pos;
}

//set where the paddle should move to
-(void) move: (CGPoint) pt{
	//adjust x position to state within box
	if(pt.x < boundry.origin.x){
		pt.x = boundry.origin.x;
	}else if( pt.x > boundry.origin.x + boundry.size.width){
		pt.x = boundry.origin.x + boundry.size.width;
	}
	
	//adjust y position to stay within box
	if( pt.y < boundry.origin.y){
		pt.y = boundry.origin.y;
	}else if( pt.y > boundry.origin.y + boundry.size.height){
		pt.y = boundry.origin.y + boundry.size.height;
	}
	//update the position
	pos = pt;
}

//center point of paddle
-(CGPoint) center{
	return view.center;
}

//check of the paddle intersects with the rectangle
-(bool) intersects: (CGRect) rect{
	return  CGRectIntersectsRect(view.frame, rect);
}

//get distance between paddle postion and point
-(float) distance: (CGPoint) pt{
	float diffx = (view.center.x) -(pt.x);
	float diffy = view.center.y - pt.y;
	return sqrt(diffx*diffx + diffy*diffy);
}

//animate puck view to next position without exceeding max speed
-(void) animate{
	//check if movement is needed
	if( CGPointEqualToPoint(view.center, pos) == false){
		//calculate distance we need to move
		float d = [self distance:pos];
		
		//check the maximum distance paddle is allowed to move
		if( d > maxSpeed){
			//modify the position to the max allowed
			float r = atan2(pos.y - view.center.y,
							pos.x - view.center.x);
			float x = view.center.x + cos(r) * maxSpeed;
			float y = view.center.y + sin(r) * maxSpeed;
			view.center = CGPointMake(x, y);
			speed = maxSpeed;
		}else{
			//set position of paddle as it does not exceed
			//maxium speed
			view.center = pos;
			speed = d;
		}
	}else{
		//not moving
		speed = 0;
	}
}

@end
