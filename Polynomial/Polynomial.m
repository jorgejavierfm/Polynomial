//
//  Polynomial.m
//  Polynomial
//
//  Created by iTMiNus on 11/30/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "Polynomial.h"

@implementation Polynomial

@synthesize drawingColor,plot,function,xMin,xMax,yMin,yMax;

-(id)init
{
    self=[super init];
    if(self)
    {
        self.plot=[[NSBezierPath alloc] init];
        self.drawingColor=[NSColor blackColor];
        xMin=-40;
        xMax=40;
        yMin=-40;
        yMax=40;
    }
    return self;
}

@end
