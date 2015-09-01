//
//  AppController.h
//  Polynomial
//
//  Created by iTMiNus on 11/26/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCMathParser.h"
#import "Polynomial.h"



@interface AppController : NSObject 
{
    NSMutableArray *functions;

}

-(void)calculateBezierPathFor:(Polynomial *)poly
                   fromString:(NSString *)function
                  usingParser:(GCMathParser *)parser;

-(void)needToDrawPolynomial:(Polynomial *)poly;


@end
