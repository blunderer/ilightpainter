//
//  iLightPainterDisplay.m
//  iLightPainter
//
//  Created by bnb on 18/02/09.
//  Copyright 2009. All rights reserved.
//

#import "iLightPainterDisplay.h"
#import "iLightPainterMainView.h"

@implementation iLightPainterDisplay

#define kFPSMax 0.01

NSString *kHelpLabel	= @"press";

@synthesize Mode;
@synthesize Period;
@synthesize StartColor;
@synthesize Internal;
@synthesize Text;
@synthesize timer;


- (void) setFunction:(int)m {
	/* internal set painting function */
	Mode = m;
}

- (void) execColor {
	/* static color display */
	Internal = 0;
	[mainWindow setBackgroundColor:[self generateColorInt:StartColor]];
	[lblDisplay setBackgroundColor:[self generateColorInt:StartColor]];
}

- (void) execStrobe {	
	/* strobe color display */
	if(Internal == 0)	{
		/* if internal was 0, display was black */
		[mainWindow setBackgroundColor:[self generateColorInt:StartColor]];
		[lblDisplay setBackgroundColor:[self generateColorInt:StartColor]];
		Internal = 1;
	} else if(Internal == 1)	{
		/* if display was 1, display was colored */
		[mainWindow setBackgroundColor:[UIColor blackColor]];
		[lblDisplay setBackgroundColor:[UIColor blackColor]];
		Internal = 0;
	} else {
		// init
		Internal = 0;
		timer = [NSTimer scheduledTimerWithTimeInterval:(1.f/Period) target:self selector:@selector(execStrobe) userInfo:nil repeats:YES];
	}
}

- (void) execText {
	/* text display */
	NSRange rnk;
	
	/* calculate duration between letters */
	float it = Period / ([Text length]+1);

	if(Internal == -1)	{
		// init 
		Internal = 0;
		[lblDisplay setTextColor:[self generateColorInt:StartColor]];
		timer = [NSTimer scheduledTimerWithTimeInterval:it target:self selector:@selector(execText) userInfo:nil repeats:YES];
		return;
	}

	if(Internal >= [Text length])	{
		/* end of text; do nothing else */
	} else {
		/* else calculate letter illumination duration */ 
		float flashP = (0.02 > 0.1*it)?0.02:(0.1*it);
		rnk.location = Internal++;
		rnk.length = 1;
		
		/* extract letter to display */
		[lblDisplay setText:[[Text uppercaseString] substringWithRange:rnk]];
		
		/* launch timer that will hide letter */
		[NSTimer scheduledTimerWithTimeInterval:flashP target:self selector:@selector(execTextHide) userInfo:nil repeats:NO];
	}
}

- (void) execRainbow {
	/* gradian display */
	float timer_period;
	float color_increment;
	
	// there are 1024 steps at max for a round trip and max fps is 100
	timer_period = Period/1024.f;
	timer_period = (timer_period > kFPSMax)?timer_period:kFPSMax;
	
	// calculate color increment */
	color_increment = 6.f * timer_period / Period;
	
	if(Internal == -1)	{
		// init
		Internal = StartColor;
		timer = [NSTimer scheduledTimerWithTimeInterval:timer_period target:self selector:@selector(execRainbow) userInfo:nil repeats:YES];
	} else {
		/* increase color */
		Internal += color_increment;
	}
	
	if(Internal >= 6.f)	{
		/* round color gradian */
		Internal = 0;
	}
	
	/* set color to display */
	[mainWindow setBackgroundColor:[self generateColorInt:Internal]];
	[lblDisplay setBackgroundColor:[self generateColorInt:Internal]];
}

- (UIColor*)generateColorInt:(float)value {
	/* color hue calculation from a [0 6] float because ColorWithHue doesn't work */
	float redcompo = 0.f;
	float greencompo = 0.f;
	float bluecompo = 0.f;
	
	// regenerate hue variations
	if((value >= 0.f)&&(value < 1.f))	{
		redcompo = 1.f;
		greencompo = value;
	} else if((value >= 1.f)&&(value < 2.f))	{
		greencompo = 1.f;
		redcompo = 1.f - (value - 1.f);
	} else if((value >= 2.f)&&(value < 3.f))	{
		greencompo = 1.f;
		bluecompo = value - 2.f;
	} else if((value >= 3.f)&&(value < 4.f))	{
		bluecompo = 1.f;
		greencompo = 1.f - (value - 3.f);	
	} else if((value >= 4.f)&&(value < 5.f))	{
		bluecompo = 1.f;
		redcompo = value - 4.f;
	} else if((value >= 5.f)&&(value < 6.f))	{
		redcompo = 1.f;
		bluecompo = 1.f - (value - 5.f);
	} else {
		bluecompo = 1.f;
		greencompo = 1.f;
		redcompo = 1.f;
	}
	return 	[UIColor colorWithRed:redcompo green:greencompo blue:bluecompo alpha:1.0];
}

- (void) Begin {
	
	/* clean display and select mode */
	[lblHelp setText:@""];
	timer = NULL;
	
	if(Mode == MODE_TEXT) {
		[self execText];
	} else if(Mode == MODE_RAINBOW) {
		[self execRainbow];
	} else if(Mode == MODE_STROBE) {
		[self execStrobe];
	} else if(Mode == MODE_COLOR) {
		[self execColor];
	}
}

- (void) init {
	/* get the i18n ressource file */
	NSString *path = [[NSBundle mainBundle] pathForResource:@"ilightpainter" ofType:@"strings"];
	NSDictionary *strings = [NSDictionary dictionaryWithContentsOfFile:path];

	/* indicate that init is pending */
	Internal = -1.f;
	
	/* disable sleep mode and hide status bar */
	[UIApplication sharedApplication].idleTimerDisabled = YES;
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	
	/* set display color to black */
	[mainWindow setBackgroundColor:[UIColor blackColor]];
	[lblDisplay setBackgroundColor:[UIColor blackColor]];
	[lblDisplay setText:@""];
	
	/* display the "touch to begin help text" */
	[lblHelp setText:[NSString stringWithFormat:[strings valueForKey:kHelpLabel]]];
	[lblHelp setTextColor:[UIColor whiteColor]];

	/* add the hide help text timer */
	[NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(hidelblhelp) userInfo:nil repeats:NO];
}

- (IBAction) backClicked {
	/* start/end of lightpainting requested */
	
	if(Internal < 0)	{
		/* start light painting */
		timer = NULL;
		[self Begin];
	} else {
		/* stop light painting */
		
		/* kill timer */
		if([timer isValid]) {
			[timer invalidate];
			timer = NULL;
		}	
		
		/* show status bar and reactivate sleep mode */
		[[UIApplication sharedApplication] setStatusBarHidden:NO];
		[UIApplication sharedApplication].idleTimerDisabled = NO;
		[mainWindow setBackgroundColor:[UIColor blackColor]];
		
		/* go back to main menu */
		[viewMain hideDisplay];
	}
}

- (void) hidelblhelp {
	/* hide help text callback */
	[lblHelp setText:@""];
}

- (void) execTextHide {
	/* hide text callback */
	[lblDisplay setText:@""];
}

@end
