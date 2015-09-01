//
//  GraphicsView.m
//  Polynomial
//
//  Created by iTMiNus on 11/25/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "GraphicsView.h"
#import "GCMathParser.h"
#import "Polynomial.h"

@implementation GraphicsView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        canvas=NSMakeRect(-40,-40,80,80);
        backgroundColor=[NSColor whiteColor];
        markInterval=2;
        
        
        NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(obtainDataToPaint:)
                   name:@"DataToPaint"
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(refresh:)
                   name:@"Refresh"
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(preferencesChange:)
                   name:@"PreferencesChange"
                 object:nil];

    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [backgroundColor setFill];
    [NSBezierPath fillRect:[self bounds]];
    [NSBezierPath strokeRect:[self bounds]];
    
    NSAffineTransform *tf=[NSAffineTransform transform];
    [tf translateXBy:[self bounds].size.width/(canvas.size.width/(ABS(canvas.origin.x)))
                 yBy:[self bounds].size.height/(canvas.size.height/(ABS(canvas.origin.y)))];
    [tf scaleXBy:[self bounds].size.width/canvas.size.width
             yBy:[self bounds].size.height/canvas.size.height];
    [tf concat];
    
    [self drawAxis:canvas];

    for(Polynomial *p in functionsToDraw)
    {
        [p.plot setLineWidth:0.1];
        [p.drawingColor setStroke];
        [p.plot stroke];
    }
}

-(void)drawAxis:(NSRect)rect
{
    NSPoint point;
    NSBezierPath *brush=[[NSBezierPath alloc] init];
    
    [brush setLineWidth:0.3];
    
    //Eje de coordenadas x
    point.x=0;
    point.y=0;
    point.x+=rect.origin.x;
    [brush moveToPoint:point];
    point.x=rect.size.width+rect.origin.x;
    [brush lineToPoint:point];
    [brush stroke];

        
    //Marks eje x
    point.x=0;
    point.y=0;
    
    for(int i=0;i<(rect.size.width+rect.origin.x)/markInterval;i++)
    {
        point.x+=markInterval;
        [self marksAux:point orientation:0];
    }
    
    point.x=0;
    
    for(int i=0;i<(ABS(rect.origin.x))/markInterval;i++)
    {
        point.x-=markInterval;
        [self marksAux:point orientation:0];
    }
    
    //Eje de coordenadas y
    point.x=0;
    point.y=0;
    point.y+=rect.origin.y;
    [brush moveToPoint:point];
    point.y=rect.size.height+rect.origin.y;
    [brush lineToPoint:point];
    [brush stroke];
    
    
    point.x=0;
    point.y=0;
    
    for(int i=0;i<(rect.size.height+rect.origin.y)/markInterval;i++)
    {
        point.y+=markInterval;
        [self marksAux:point orientation:1];
    }
    
    point.y=0;
    
    for(int i=0;i<(ABS(rect.origin.y))/markInterval;i++)
    {
        point.y-=markInterval;
        [self marksAux:point orientation:1];
    }
     
}

-(void)marksAux:(NSPoint)point
    orientation:(int)eje
{
    NSBezierPath *brush=[[NSBezierPath alloc] init];
    
    [brush setLineWidth:0.070];

    [brush moveToPoint:point];
    if(!eje)
        point.y+=1;
    else
        point.x+=1;
    [brush lineToPoint:point];
    [brush stroke];
    if(!eje)
        point.y-=2;
    else
        point.x-=2;
    [brush lineToPoint:point];
    [brush stroke];
}

-(void)obtainDataToPaint:(NSNotification *)aNotification
{
    NSDictionary *dict=[aNotification userInfo];
    functionsToDraw=[dict valueForKey:@"data"];
}

-(void)refresh:(NSNotification *)aNotification
{
    [self setNeedsDisplay:TRUE];
}

-(void)preferencesChange:(NSNotification *)aNotification
{
    double xMin,xMax,yMin,yMax;
    
    NSDictionary *dict=[aNotification userInfo];
    xMin=[[dict valueForKey:@"xMin"] doubleValue];
    xMax=[[dict valueForKey:@"xMax"] doubleValue];
    yMin=[[dict valueForKey:@"yMin"] doubleValue];
    yMax=[[dict valueForKey:@"yMax"] doubleValue];
    markInterval=[[dict valueForKey:@"markIntervale"] intValue];
    
    backgroundColor=[dict valueForKey:@"backgroundColor"];
    
    canvas=NSMakeRect(xMin,yMin, xMax-xMin, yMax-yMin);
    [self setNeedsDisplay:TRUE];
}


@end
