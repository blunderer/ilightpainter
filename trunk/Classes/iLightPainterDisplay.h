//
//  iLightPainterDisplay.h
//  iLightPainter
//
//  Created by bnb on 18/02/09.
//  Copyright 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define MODE_COLOR		0
#define MODE_STROBE		1
#define MODE_RAINBOW	2
#define MODE_TEXT		3

@class iLightPainterMainView;

@interface iLightPainterDisplay : UIView {
    IBOutlet UILabel *lblHelp;
    IBOutlet UILabel *lblDisplay;
	IBOutlet iLightPainterMainView *viewMain;
	IBOutlet UIWindow *mainWindow;
	int Mode;
	float Period;
	float StartColor;
	float Internal;
	NSString *Text;
	NSTimer *timer;
}

@property (nonatomic) int Mode;
@property (nonatomic) float Period;
@property (nonatomic) float StartColor;
@property (nonatomic) float Internal;
@property (nonatomic, retain) NSString *Text;
@property (nonatomic, retain) NSTimer *timer;

- (IBAction) backClicked;
- (IBAction) ScreenSlided;

- (UIColor*)generateColorInt:(float)value;

- (void) setFunction:(int)m;
- (void) init;
- (void) Begin;
- (void) execColor;
- (void) execStrobe;
- (void) execText;
- (void) execRainbow;
- (void) execTextHide;
- (void) hidelblhelp;

@end
