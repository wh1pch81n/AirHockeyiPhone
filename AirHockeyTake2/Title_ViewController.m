//
//  Title_ViewController.m
//  AirHockeyTake2
//
//  Created by Derrick Ho on 5/13/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import "Title_ViewController.h"
#import "AirHocky_AppDelegate.h"

@interface Title_ViewController ()

@end

@implementation Title_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

- (IBAction)onPlay:(id)sender {
	NSLog(@"onPlay begin");
	AirHocky_AppDelegate * app = (AirHocky_AppDelegate*)
	[UIApplication sharedApplication].delegate;
	UIButton *button =(UIButton*) sender;
	[app playGame: button.tag];
	//question... it looks like "app" is a pointer to a delegate.
	//the delegate starts by playing the game.
	//interpretation: the title_viewController makes relinquishes its
	//place when the current function is called.  The object for the
	//"game" is created and then ran via the playGame method.
	NSLog(@"onPlay end");
}


@end
