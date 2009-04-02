//
//  iLightPainterMainView.h
//  iLightPainter
//
//  Created by bnb on 18/02/09.
//  Copyright 2009. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class iLightPainterHelp;
@class iLightPainterDisplay;
@class iLightPainterMenu;

@interface iLightPainterMainView : UIView {
	IBOutlet iLightPainterHelp *viewHelp;
	IBOutlet iLightPainterDisplay *viewDisplay;
	IBOutlet iLightPainterMenu *viewMenu;
}

- (void) showHelp;
- (void) showDisplay;
- (void) hideDisplay;
- (void) displayHidden;
- (void) showMenu;
- (void) helpHidden;
- (void) hideHelp;

@end
