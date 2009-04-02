//
//  iLightPainterAppDelegate.h
//  iLightPainter
//
//  Created by bnb on 18/02/09.
//  Copyright 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iLightPainterViewController;

@interface iLightPainterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	iLightPainterViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iLightPainterViewController *viewController;

@end

