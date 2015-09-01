//
//  DrawSheetController.h
//  Polynomial
//
//  Created by iTMiNus on 11/25/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FunctionOptionController;

@interface DrawSheetController : NSWindowController
{
    NSMutableDictionary *dictNotification;
    IBOutlet NSComboBox *input;
    IBOutlet NSButton *draw;
    IBOutlet NSButton *options;
    FunctionOptionController *functionOptions;
}


-(IBAction)addFunction:(id)sender;
-(IBAction)drawFunction:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)showFunctionOptions:(id)sender;
-(void)handleNotification:(NSNotification *)aNotification;

@end
