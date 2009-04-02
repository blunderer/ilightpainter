#import "iLightPainterHelp.h"
#import "iLightPainterMainView.h"

@implementation iLightPainterHelp

-(void)init {
	/* locate the i18n ressource */
	NSString *path = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"txt"];
	NSString *string = [NSString stringWithContentsOfFile:path usedEncoding:NULL error:NULL];

	/* set help text */
	[txtHelp setText:string];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	/* check if text is scrolled to end */
	CGPoint pos = [txtHelp contentOffset];
	CGSize size = [txtHelp contentSize];
	CGRect t = [txtHelp frame];
	
	/* if end is reached, hide slide indicator arrow */
	if(pos.y+t.size.height >= size.height)	{
		[imgArrow setHidden:YES];
	} else {
		[imgArrow setHidden:NO];
	}
}


- (IBAction) backClicked {
	/* go back to main menu */
	[viewMain hideHelp];
}

@end
