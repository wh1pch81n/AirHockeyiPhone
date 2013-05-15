//
//  AirHocky_AppDelegate.h
//  AirHockeyTake2
//
//  Created by Derrick Ho on 5/3/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AirHocky_ViewController;
@class Title_ViewController;

@interface AirHocky_AppDelegate : UIResponder <UIApplicationDelegate>
-(void) showTitle;
/*will allocate a new AirHockey_viewController object*/
-(void) playGame: (int) computer;

@property (strong, nonatomic) UIWindow *window;

/*loades the selection screen that lets you choose computer or 2 players*/
@property (strong, nonatomic) Title_ViewController *viewController;

@property (strong, nonatomic) AirHocky_ViewController * gameController;



@end
