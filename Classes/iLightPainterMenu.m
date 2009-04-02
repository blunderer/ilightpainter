//
//  iLightPainterMenu.m
//  iLightPainter
//
//  Created by bnb on 18/02/09.
//  Copyright 2009. All rights reserved.
//
#import "iLightPainterMenu.h"
#import "iLightPainterMainView.h"
#import "iLightPainterDisplay.h"

/* keys into i18n file */
NSString *kParamName	= @"param";
NSString *kParamExt		= @"plist";
NSString *kParamPeriod	= @"Period";
NSString *kParamColor	= @"Color";
NSString *kParamText	= @"Text";
NSString *kPeriodLabel	= @"period";
NSString *kColorLabel	= @"color";
NSString *kTextLabel	= @"text";
NSString *kTextBtn		= @"btntext";
NSString *kColorBtn		= @"btncolor";
NSString *kStrobeBtn	= @"btnstrobe";
NSString *kRainbowBtn	= @"btnrainbow";


@implementation iLightPainterMenu

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	/* hide keyboard when return is pressed */
	if(textField == txtText)	{
		/* tell display what text to display */
		[viewDisplay setText:textField.text];
		[textField resignFirstResponder];
		
		/* save setting for next launch */
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		[prefs setObject:[textField text] forKey:kParamText];
	}
	return YES;
}

- (void)handleSliderPeriod:(id)sender {
	/* get the i18n ressource */
	NSString *path = [[NSBundle mainBundle] pathForResource:@"ilightpainter" ofType:@"strings"];
	NSDictionary *strings = [NSDictionary dictionaryWithContentsOfFile:path];
	
	/* set period value to label */
	[lblPeriod setText:[NSString stringWithFormat:[strings valueForKey:kPeriodLabel], sldPeriod.value]];

	/* tell display what period/freq to use */
	[viewDisplay setPeriod:sldPeriod.value];

	/* save setting for next launch */
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setFloat:[sldPeriod value] forKey:kParamPeriod];
}

- (void) handleSliderColor: (id)sender {
	/* slider color callback */
	
	/* set labels colors */
	[lblColor setTextColor:[viewDisplay generateColorInt:sldColor.value]];
	[lblText setTextColor:[viewDisplay generateColorInt:sldColor.value]];
	[lblPeriod setTextColor:[viewDisplay generateColorInt:sldColor.value]];
	
	/* tell display what color to use */
	[viewDisplay setStartColor:sldColor.value];
	
	/* save setting for next launch */
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setFloat:[sldColor value] forKey:kParamColor];
}

-(void)init {
	float l_period;
	float l_color;
	NSString *l_text;
	
	/* load all ressources from i18n file */
	NSString *path = [[NSBundle mainBundle] pathForResource:@"ilightpainter" ofType:@"strings"];
	NSDictionary *strings = [NSDictionary dictionaryWithContentsOfFile:path];
	[lblColor setText:[NSString stringWithFormat:[strings valueForKey:kColorLabel]]];
	[lblText setText:[NSString stringWithFormat:[strings valueForKey:kTextLabel]]];
	[bbiText setTitle:[NSString stringWithFormat:[strings valueForKey:kTextBtn]] forState:UIControlStateNormal];
	[bbiText setTitle:[NSString stringWithFormat:[strings valueForKey:kTextBtn]] forState:UIControlStateHighlighted];
	[bbiColor setTitle:[NSString stringWithFormat:[strings valueForKey:kColorBtn]] forState:UIControlStateNormal];
	[bbiColor setTitle:[NSString stringWithFormat:[strings valueForKey:kColorBtn]] forState:UIControlStateHighlighted];
	[bbiStrobe setTitle:[NSString stringWithFormat:[strings valueForKey:kStrobeBtn]] forState:UIControlStateNormal];
	[bbiStrobe setTitle:[NSString stringWithFormat:[strings valueForKey:kStrobeBtn]] forState:UIControlStateHighlighted];
	[bbiRainbow setTitle:[NSString stringWithFormat:[strings valueForKey:kRainbowBtn]] forState:UIControlStateNormal];
	[bbiRainbow setTitle:[NSString stringWithFormat:[strings valueForKey:kRainbowBtn]] forState:UIControlStateHighlighted];
	
	// get default params 
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	l_text = [prefs stringForKey:kParamText];
	l_color = [prefs floatForKey:kParamColor];
	l_period = [prefs floatForKey:kParamPeriod];
		
	// init color slider
	[sldColor setMinimumValue:0.f];
	[sldColor setMaximumValue:6.f];
	[sldColor setValue:l_color];

	// init period slider
	[sldPeriod setMinimumValue:1.f];
	[sldPeriod setMaximumValue:60.f];
	[sldPeriod setValue:l_period];
	
	// init text value
	[txtText setText:l_text];
	
	// call callbacks to have correct values diplayed
	[self handleSliderPeriod:NULL];
	[self handleSliderColor:NULL];
	[viewDisplay setText:txtText.text];
}

- (IBAction) helpClicked {
	/* launch help view */
	[viewMain showHelp];
}

- (IBAction) displayGo {
	/* launch display */
	[viewDisplay init];
	[viewMain showDisplay];
}

- (IBAction) setModeStrobe {
	/* warn display what mode is selected */
	[viewDisplay setFunction:MODE_STROBE];
	[self displayGo];
}

- (IBAction) setModeText {
	/* warn display what mode is selected */
	[viewDisplay setFunction:MODE_TEXT];
	[self displayGo];
}

- (IBAction) setModeColor {
	/* warn display what mode is selected */
	[viewDisplay setFunction:MODE_COLOR];
	[self displayGo];
}
	
- (IBAction) setModeRainbow {
	/* warn display what mode is selected */
	[viewDisplay setFunction:MODE_RAINBOW];
	[self displayGo];
}


@end
