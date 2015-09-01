//
//  PreferencesController.h
//  Polynomial
//
//  Created by iTMiNus on 12/5/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferencesController : NSWindowController
{
    IBOutlet NSTextField *xMin;
    IBOutlet NSTextField *xMax;
    IBOutlet NSTextField *yMin;
    IBOutlet NSTextField *yMax;
    IBOutlet NSTextField *markIntervale;
    IBOutlet NSColorWell *backgroundColor;
}

-(IBAction)apply:(id)sender;

@end
