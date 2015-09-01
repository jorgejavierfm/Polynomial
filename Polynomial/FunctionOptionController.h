//
//  FunctionOptionController.h
//  Polynomial
//
//  Created by iTMiNus on 11/25/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FunctionOptionController : NSWindowController
{
    NSString *stringToAnalize;
    IBOutlet NSTextField *functionName;
    IBOutlet NSTextField *parameterA;
    IBOutlet NSTextField *parameterB;
    IBOutlet NSTextField *parameterC;
    IBOutlet NSTextField *parameterN;
    IBOutlet NSTextField *xMin;
    IBOutlet NSTextField *xMax;
    IBOutlet NSTextField *yMin;
    IBOutlet NSTextField *yMax;
    IBOutlet NSColorWell *colorControl;
    
}

-(id)initWithParametersActivated:(NSString *)sToAnalize;
-(IBAction)apply:(id)sender;
-(void)analizeString:(NSString *)sToAnalize;
-(void)handleNotification:(NSNotification *)aNotification;

@end
