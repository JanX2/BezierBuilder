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
			CGPoint endPoint = {[point mainPoint].x-startPoint.x, [point mainPoint].y-startPoint.y};
			CGPoint control1 = {[point controlPoint1].x-startPoint.x, [point controlPoint1].y-startPoint.y};
			CGPoint control2 = {[point controlPoint2].x-startPoint.x, [point controlPoint2].y-startPoint.y};
			[lines addObject:[NSString stringWithFormat:@"\t[CCActionBezierBy actionWithDuration:%c#(CCTime)#%c bezier:{\n\t\tccp(%0.2f, %0.2f), ccp(%0.2f, %0.2f), ccp(%0.2f, %0.2f)\t}]\t // normalized control points: %0.2f, %0.2f, %0.2f, %0.2f",
							  60, 62, // ascii codes for '<' and '>'
							  endPoint.x, endPoint.y,
							  control1.x, control1.y,
							  control2.x, control2.y,
							  // normalized control points
							  control1.x/endPoint.x, control1.y/endPoint.y,
							  control2.x/endPoint.x, control2.y/endPoint.y]];
		}
		startPoint = CGPointMake([point mainPoint].x, [point mainPoint].y);
	}
	
	[lines addObject:@"nil];"];
	
	return [lines componentsJoinedByString:@"\n"];
}

@end
