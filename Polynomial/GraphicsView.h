//
//  GraphicsView.h
//  Polynomial
//
//  Created by iTMiNus on 11/25/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GraphicsView : NSView
{
    int markInterval;
    NSRect canvas;
    NSColor *backgroundColor;
    NSMutableArray *functionsToDraw;
}

-(void)drawAxis:(NSRect)canvas;
-(void)marksAux:(NSPoint)point
    orientation:(int)eje;

@end
