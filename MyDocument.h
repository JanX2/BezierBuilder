//
//  MyDocument.h
//  BezierBuilder
//
//  Created by Dave DeLong on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "BezierView.h"

@interface MyDocument : NSDocument <BezierViewDelegate> {	
	BezierView * bezierView;
	NSTextView * bezierCodeView;
	NSPopUpButton *codeOption;
	NSSegmentedControl *__weak originControl;
	NSSegmentedControl *__weak codeStyleControl;
}

@property (nonatomic, strong) IBOutlet BezierView * bezierView;
@property (nonatomic, strong) IBOutlet NSTextView * bezierCodeView;
@property (nonatomic, strong) IBOutlet NSPopUpButton *codeOption;

@property (weak) IBOutlet NSSegmentedControl *originControl;
@property (weak) IBOutlet NSSegmentedControl *codeStyleControl;

- (IBAction) codeOptionChanged:(id)sender;
- (IBAction) delleteAll:(id)sender;

@end
