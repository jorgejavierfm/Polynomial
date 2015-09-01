//
//  DrawSheetController.m
//  Polynomial
//
//  Created by iTMiNus on 11/25/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "DrawSheetController.h"
#import "FunctionOptionController.h"

@interface DrawSheetController ()

@end

@implementation DrawSheetController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        dictNotification=[[NSMutableDictionary alloc] init];
        NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(handleNotification:)
                   name:@"OptionsEntered"
                 object:nil];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(IBAction)addFunction:(id)sender
{
    if (!self.window)
        [NSBundle loadNibNamed:@"DrawSheet" owner:self];
    
    [NSApp beginSheet:self.window
       modalForWindow:[NSApp mainWindow]
        modalDelegate:nil
       didEndSelector:nil
          contextInfo:nil];
    
}

-(IBAction)drawFunction:(id)sender
{
    if ([[input stringValue]length]!=0)
    {
       
        [dictNotification setValue:[input stringValue] forKey:@"input"];
        
        NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"NewFunction"
                          object:self
                        userInfo:dictNotification];
        
        [self cancel:nil];
    }
}

-(IBAction)cancel:(id)sender
{
    [NSApp endSheet:self.window];
    [self.window close];
    self.window=nil;
}

-(IBAction)showFunctionOptions:(id)sender
{
    if (!functionOptions)
        functionOptions=[[FunctionOptionController alloc] initWithParametersActivated:[input stringValue]];
    
    [functionOptions showWindow:self];
}

- (void)controlTextDidChange:(NSNotification *)aNotification
{
     if ([[input stringValue]length]==0)
        [options setEnabled:FALSE];
    else
    {
        if (functionOptions)
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
            [dict setValue:[input stringValue] forKey:@"newstring"];
            
            NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
            [nc postNotificationName:@"stringHasChanged"
                              object:self
                            userInfo:dict];
        }
        [options setEnabled:TRUE];
    }
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setValue:[input itemObjectValueAtIndex:[input indexOfSelectedItem]] forKey:@"newstring"];

    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"stringHasChanged"
                      object:self
                    userInfo:dict];
    
    [options setEnabled:TRUE];
}


-(void)handleNotification:(NSNotification *)aNotification
{
    [draw setEnabled:TRUE];
    NSDictionary *dict=[aNotification userInfo];
    for(NSString *iterator in dict)
        [dictNotification setValue:[dict valueForKey:iterator] forKey:iterator];
}






















@end
