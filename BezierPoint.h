//
//  BezierPoint.h
//  BezierBuilder
//
//  Created by Dave DeLong on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDataKey @"DataPoints"

@interface BezierPoint : NSObject <NSCoding> {

}

@property NSPoint mainPoint;
@property NSPoint controlPoint1;
@property NSPoint controlPoint2;

@end
