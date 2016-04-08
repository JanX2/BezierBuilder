//
//  MyDocument.m
//  BezierBuilder
//
//  Created by Dave DeLong on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MyDocument.h"
#import "BezierPoint.h"

#import "CodeBuilder.h"
#import "NSBezierPathCodeBuilder.h"
#import "CGPathRefCodeBuilder.h"
#import "CCActionToCodeBuilder.h"
#import "CCActionByCodeBuilder.h"

@implementation MyDocument

@synthesize bezierView, bezierCodeView;
@synthesize codeOption;
@synthesize originControl;
@synthesize codeStyleControl;

- (void) rebuildSteps {
	
	Class builderClass = Nil;
	
	switch (codeStyleControl.selectedSegment) {
		case 0:
			builderClass = [NSBezierPathCodeBuilder class];
			break;
			
		case 1:
			builderClass = [CGPathRefCodeBuilder class];
			break;
			
		case 2:
			builderClass = [CCActionToCodeBuilder class];
			break;
			
		case 3:
			builderClass = [CCActionByCodeBuilder class];
			break;
			
		default:
			break;
	}
	
	CodeBuilder *builder = [[builderClass alloc] init];
	builder.bezierPoints = bezierView.bezierPoints;
	if (originControl.selectedSegment == 1) {
		builder.yOrigin = bezierView.bounds.size.height;
	}
	else {
		builder.yOrigin = 0.0;
	}
	bezierCodeView.string = [builder codeForBezierPoints];
	[builder release];
	
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:bezierView.bezierPoints];
	[[NSUserDefaults standardUserDefaults] setObject:data forKey:kDataKey];
}

- (void) codeOptionChanged:(id)sender {
	[self rebuildSteps];
}

- (IBAction)delleteAll:(id)sender {
	[bezierView deleteAll:sender];
}

- (void) elementsDidChangeInBezierView:(BezierView *)view {
	[self rebuildSteps];
	[bezierView setNeedsDisplay:YES];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
 
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.

    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.

    // For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.

    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type.  If the given outError != NULL, ensure that you set *outError when returning NO.

    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead. 
    
    // For applications targeted for Panther or earlier systems, you should use the deprecated API -loadDataRepresentation:ofType. In this case you can also choose to override -readFromFile:ofType: or -loadFileWrapperRepresentation:ofType: instead.
    
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
    return YES;
}

@end
