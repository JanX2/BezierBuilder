//
//  BezierPoint.m
//  BezierBuilder
//
//  Created by Dave DeLong on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BezierPoint.h"


@implementation BezierPoint
@synthesize mainPoint;
@synthesize controlPoint1, controlPoint2;

- (void) encodeWithCoder:(NSCoder *)encoder {
	[encoder encodePoint:self.mainPoint forKey:@"MainPoint"];
	[encoder encodePoint:self.controlPoint1 forKey:@"ControlPoint1"];
	[encoder encodePoint:self.controlPoint2 forKey:@"ControlPoint2"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.mainPoint = [decoder decodePointForKey:@"MainPoint"];
		self.controlPoint1 = [decoder decodePointForKey:@"ControlPoint1"];
		self.controlPoint2 = [decoder decodePointForKey:@"ControlPoint2"];
	}
	return self;
}

@end
