//
//  PanelsAndSheetsController.m
//  Polynomial
//
//  Created by iTMiNus on 12/5/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "PanelsAndSheetsController.h"

@implementation PanelsAndSheetsController

-(IBAction)showLogs:(id)sender
{
    if (!logs)
        logs=[[LogController alloc] initWithData:functions];
    
    [logs showWindow:self];
}

-(IBAction)showPreferences:(id)sender
{
    if (!pref)
        pref=[[PreferencesController alloc] init];
    
    [pref showWindow:self];
}

@end
