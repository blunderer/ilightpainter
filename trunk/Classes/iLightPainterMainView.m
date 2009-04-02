//
//  iLightPainterMainView.m
//  iLightPainter
//
//  Created by bnb on 18/02/09.
//  Copyright 2009. All rights reserved.
//

#import "iLightPainterMainView.h"
#import "iLightPainterHelp.h"
#import "iLightPainterDisplay.h"
#import "iLightPainterMenu.h"

#define kAnimDuration 0.2

@implementation iLightPainterMainView

- (void) awakeFromNib {
	/* first loaded callback : load main window */
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
	
	/* load menu */
	[self addSubview:viewMenu];
	
	/* init menu */
	[viewMenu init];
}


- (void) showHelp {
	CGRect view_position;

	/* init help vie */
	[viewHelp init];
	
	/* calculate help view show animation */
	view_position = [viewHelp frame];
	view_position.origin.x = 0;
	view_position.origin.y = 460;
	[viewHelp setFrame:view_position];

	/* load view */
	[self addSubview:viewHelp];

	/* exec animation */
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:kAnimDuration];
	[UIView setAnimationDelegate:self];
	view_position.origin.x = 0;
	view_position.origin.y = 0;
	[viewHelp setFrame:view_position];
	[UIView commitAnimations];
}

- (void) hideDisplay {
	/* calculate display view hide animation and exec it */
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:kAnimDuration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(displayHidden)];
	[viewDisplay setAlpha:0.f];	
	[UIView commitAnimations];	
}

- (void) displayHidden {
	/* end of animation: hide display view */
	[viewDisplay removeFromSuperview];
}

- (void) hideHelp {
	CGRect view_position;
		
	/* calcule hide help view animation */
	view_position = [viewHelp frame];
	view_position.origin.x = 0;
	view_position.origin.y = 0;
	[viewHelp setFrame:view_position];
		
	/* exec animation */
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:kAnimDuration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(helpHidden)];
	view_position.origin.x = 0;
	view_position.origin.y = 460;
	[viewHelp setFrame:view_position];
	[UIView commitAnimations];	
}

- (void) helpHidden {
	/* end of animation: hide help view */
	[viewHelp removeFromSuperview];
}

- (void) showDisplay {
	/* calculate display view show animation and exec it */
	[viewDisplay setAlpha:0.f];
	[self addSubview:viewDisplay];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:kAnimDuration];
	[UIView setAnimationDelegate:self];
	[viewDisplay setAlpha:1.f];	
	[UIView commitAnimations];
}

- (void) showMenu {
	/* end of animation: hide menu view */
	[viewMenu removeFromSuperview];
	[self addSubview:viewMenu];
}

@end
