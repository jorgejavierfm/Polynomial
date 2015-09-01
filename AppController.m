//
//  AppController.m
//  Polynomial
//
//  Created by iTMiNus on 11/26/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "AppController.h"


@implementation AppController

-(id)init;
{
    self=[super init];
    if (self)
    {
        functions=[[NSMutableArray alloc] init];
        NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(newFunctionNotification:)
                   name:@"NewFunction"
                 object:nil];
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        [dict setValue:functions forKey:@"data"];
        [nc postNotificationName:@"DataToPaint"
                          object:self
                        userInfo:dict];

    }
    
    return self;
}

-(void)newFunctionNotification:(NSNotification *)aNotification
{
    GCMathParser* parser = [GCMathParser parser];
    NSDictionary *dict=[aNotification userInfo];
    NSString *input=[dict valueForKey:@"input"];
    Polynomial *poly=[[Polynomial alloc] init];
    
    [poly setDrawingColor:[dict valueForKey:@"functionColor"]];
    [poly setName:[dict valueForKey:@"functionName"]];
    
    [poly setXMin:[[dict valueForKey:@"xMin"]doubleValue]];
    [poly setXMax:[[dict valueForKey:@"xMax"]doubleValue]];
    [poly setYMin:[[dict valueForKey:@"yMin"]doubleValue]];
    [poly setYMax:[[dict valueForKey:@"yMax"]doubleValue]];
    
    for(NSString *iterator in dict)
        if([iterator isEqualToString:@"a"] || [iterator isEqualToString:@"b"] || [iterator isEqualToString:@"n"] || [iterator isEqualToString:@"c"])
            [parser setSymbolValue:[[dict valueForKey:iterator]doubleValue] forKey:iterator];
    
    [self calculateBezierPathFor:poly
                      fromString:input
                     usingParser:parser];
    
    poly.function=input;
    [functions addObject:poly];

    [self needToDrawPolynomial:poly];
}

-(void)calculateBezierPathFor:(Polynomial *)poly
                   fromString:(NSString *)function
                  usingParser:(GCMathParser *)parser;
{
    NSPoint point;
    double functionWidth=(ABS(poly.xMin)+poly.xMax);
    float distance=functionWidth/500;
    
    
    point.x=poly.xMin-distance;
    
    do {
        point.x +=distance;
        [parser setSymbolValue:point.x forKey:@"x"];
        point.y=[parser evaluate:function];
    } while (!(point.y>=poly.yMin && point.y<=poly.yMax));
   
    [poly.plot moveToPoint:point];
    
    while (point.x <= poly.xMin + functionWidth)
    {
        [parser setSymbolValue:point.x forKey:@"x"];
        point.y=[parser evaluate:function];
        if(point.y>=poly.yMin && point.y<=poly.yMax)
            [poly.plot lineToPoint:point];
        point.x +=distance;
    }
}

-(void)needToDrawPolynomial:(Polynomial *)poly
{
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"Refresh"
                      object:self];
}



@end
