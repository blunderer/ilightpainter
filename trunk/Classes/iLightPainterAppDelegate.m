//
//  iLightPainterAppDelegate.m
//  iLightPainter
//
//  Created by blunderer on 18/02/09.
//  Copyright 2009. All rights reserved.
//

#import "iLightPainterAppDelegate.h"
#import "iLightPainterViewController.h"

@implementation iLightPainterAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    // Override point for customization after application launch
	[window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[viewController release];
    [window release];
    [super dealloc];
}


@end
