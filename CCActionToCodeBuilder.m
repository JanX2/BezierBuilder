//
//  CCActionToCodeBuilder.m
//  BezierBuilder
//
//  Created by Dave DeLong on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCActionToCodeBuilder.h"
#import "BezierPoint.h"


@implementation CCActionToCodeBuilder

- (NSString *) codeForBezierPoints {
	NSArray *points = [self effectiveBezierPoints];
	NSMutableArray *lines = [NSMutableArray array];
	
	[lines addObject:@"id action =\n[CCActionSequence actions:"];
	
	for (NSUInteger i = 0; i < points.count; ++i) {
		BezierPoint *point = points[i];
		if (i == 0) {
			[lines addObject:[NSString stringWithFormat:@"\t[CCActionMoveTo actionWithDuration:0 position:ccp(%0.2f, %0.2f)],",
							  point.mainPoint.x, point.mainPoint.y]];
		} else {
			[lines addObject:[NSString stringWithFormat:@"\t[CCActionBezierTo actionWithDuration:%c#(CCTime)#%c bezier:{\n\t\tccp(%0.2f, %0.2f), ccp(%0.2f, %0.2f), ccp(%0.2f, %0.2f)\t}],",
							  60, 62, // ascii codes for '<' and '>'
							  point.mainPoint.x, point.mainPoint.y,
							  point.controlPoint1.x, point.controlPoint1.y,
							  point.controlPoint2.x, point.controlPoint2.y]];
		}
	}
	
	[lines addObject:@"nil];"];
	
	return [lines componentsJoinedByString:@"\n"];
}

@end
