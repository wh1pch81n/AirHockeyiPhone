//
//  AirHocky_AppDelegate.m
//  AirHockeyTake2
//
//  Created by Derrick Ho on 5/3/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import "AirHocky_AppDelegate.h"

#import "AirHocky_ViewController.h"
#import "Title_ViewController.h"


@implementation AirHocky_AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]
				   initWithFrame:[[UIScreen mainScreen] bounds]];
	self.viewController = [[Title_ViewController alloc]
						   initWithNibName:@"Title_ViewController"
						   bundle:nil];
	
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active
	//to inactive state. This can occur for certain types of
	//temporary interruptions (such as an incoming phone call or
	//SMS message) or when the user quits the application and it
	//begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and
	//throttle down OpenGL ES frame rates. Games should use this
	//method to pause the game.
	if( self.gameController){
	[self.gameController pause];
	}
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	if(self.gameController){
		[self.gameController resume];//resume app where it left off
	}
}
- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) showTitle{
	//dismiss the game controller
	if( self.gameController){
		[self.viewController dismissModalViewControllerAnimated:NO];
		[self setGameController:nil];
	}
}
/*will allocate a new AirHockey_viewController object*/
-(void) playGame: (int) computer{
	//present the game over the title
	if( [self gameController] == nil){
		[self setGameController: [[AirHocky_ViewController alloc]
							  initWithNibName:@"AirHocky_ViewController"
							  bundle:nil]];
		[[self gameController] setComputer:computer];
		[[self viewController] presentModalViewController:
											   self.gameController
											   animated:NO];
	}
}

@end

