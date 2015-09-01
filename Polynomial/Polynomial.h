//
//  Polynomial.h
//  Polynomial
//
//  Created by iTMiNus on 11/30/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Polynomial : NSObject

@property (copy) NSString *name;
@property(copy) NSColor *drawingColor;
@property(copy) NSString *function;
@property(copy) NSBezierPath *plot;
@property(assign) double xMin;
@property(assign) double xMax;
@property(assign) double yMin;
@property(assign) double yMax;
@property(assign) NSRect bounds;

-(void)calculateBounds;

@end
