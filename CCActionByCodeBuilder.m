//
//  CCActionByCodeBuilder.m
//  BezierBuilder
//
//  Created by Dave DeLong on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCActionByCodeBuilder.h"
#import "BezierPoint.h"


@implementation CCActionByCodeBuilder

- (NSString *) codeForBezierPoints {
	NSArray *points = [self effectiveBezierPoints];
	NSMutableArray *lines = [NSMutableArray array];
	
	[lines addObject:@"id action =\n[CCActionSequence actions:"];
	
	CGPoint startPoint;
	
	for (NSUInteger i = 0; i < [points count]; ++i) {
		BezierPoint *point = [points objectAtIndex:i];
		if (i != 0) {
			[lines addObject:[NSString stringWithFormat:@"\t[CCActionBezierBy actionWithDuration:%c#(CCTime)#%c bezier:{\n\t\tccp(%0.2f, %0.2f), ccp(%0.2f, %0.2f), ccp(%0.2f, %0.2f)\t}],",
							  60, 62, // ascii codes for '<' and '>'
							  [point mainPoint].x-startPoint.x, [point mainPoint].y-startPoint.y,
							  [point controlPoint1].x-startPoint.x, [point controlPoint1].y-startPoint.y,
							  [point controlPoint2].x-startPoint.x, [point controlPoint2].y-startPoint.y]];
		}
		startPoint = CGPointMake([point mainPoint].x, [point mainPoint].y);
	}
	
	[lines addObject:@"nil];"];
	
	return [lines componentsJoinedByString:@"\n"];
}

@end
