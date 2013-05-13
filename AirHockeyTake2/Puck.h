//
//  Puck.h
//  AirHockeyTake2
//
//  Created by Derrick Ho on 5/8/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Paddle.h"
@interface Puck : NSObject{
	UIView* view; // puck view this object controls
	CGRect rect[3]; // contains our boundary goal1 and goal 2 rects
	int box; // box the puck is confined to ( index into rect)
	
}
@property (readonly) float maxSpeed;
@property (readonly) float speed;
@property (readonly) float dx;
@property (readonly) float dy;
@property (readonly) int winner;

//initialize object
-(id) initWithPuck: (UIView*) puck
		  Boundary: (CGRect) boundary
			 Goal1:(CGRect) goal1
			 Goal2:(CGRect) goal2
		  MaxSpeed: (float) max;

//reset position to middle of boundry
-(void) reset;

//returns current center position of puck
-(CGPoint) center;

//animate the puck and return true if a wall was hit
-(bool) animate;

//check for collision with paddle and alter path of puck if so
-(bool) handleCollision: (Paddle*) paddle;
@end
