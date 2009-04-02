//
//  iLightPainterHelp.h
//  iLightPainter
//
//  Created by bnb on 18/02/09.
//  Copyright 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class iLightPainterMainView;

@interface iLightPainterHelp : UIView <UIScrollViewDelegate> {
    IBOutlet UIBarButtonItem *btnBack;
    IBOutlet UITextView *txtHelp;
    IBOutlet UILabel *lblAuthors;
	IBOutlet UIImageView *imgArrow;
	IBOutlet iLightPainterMainView *viewMain;
}

- (IBAction) backClicked;
- (void)init;

@end
