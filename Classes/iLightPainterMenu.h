//
//  iLightPainterMenu.h
//  iLightPainter
//
//  Created by bnb on 18/02/09.
//  Copyright 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class iLightPainterMainView;
@class iLightPainterDisplay;

@interface iLightPainterMenu : UIView <UITextFieldDelegate> {
    IBOutlet UIButton *bbiColor;
    IBOutlet UIButton *bbiRainbow;
    IBOutlet UIButton *bbiStrobe;
    IBOutlet UIButton *bbiText;
    IBOutlet UISlider *sldPeriod;
    IBOutlet UIWindow *winMain;
    IBOutlet UIToolbar *tlbMode;
    IBOutlet UILabel *lblPeriod;
	IBOutlet UILabel *lblText;
    IBOutlet iLightPainterMainView *viewMain;
    IBOutlet iLightPainterDisplay *viewDisplay;
    IBOutlet UITextField *txtText;
    IBOutlet UISlider *sldColor;
    IBOutlet UILabel *lblColor;
	IBOutlet UINavigationBar *titleBar;
	NSDictionary *params;
}

- (void) init;

- (IBAction) handleSliderColor: (id)sender;
- (IBAction) handleSliderPeriod:(id)sender;

- (IBAction) helpClicked;
- (void) displayGo;

- (IBAction) setModeStrobe;
- (IBAction) setModeRainbow;
- (IBAction) setModeColor;
- (IBAction) setModeText;




@end
