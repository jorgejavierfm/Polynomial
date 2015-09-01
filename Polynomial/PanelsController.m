//
//  PanelsController.m
//  Polynomial
//
//  Created by iTMiNus on 12/5/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "PanelsController.h"
#import "LogController.h"
#import "PreferencesController.h"

@implementation PanelsController

-(id)init
{
    self=[super init];
    if (self)
    {
        NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(handleNotification:)
                   name:@"DataToPaint"
                 object:nil];
    }
    
    return self;
}

-(IBAction)showLogs:(id)sender
{
    if (!logs)
        logs=[[LogController alloc] initWithData:logData];
    
    [logs showWindow:self];
}

-(IBAction)showPreferences:(id)sender
{
    if (!pref)
        pref=[[PreferencesController alloc] init];
    
    [pref showWindow:self];
}

-(void)handleNotification:(NSNotification *)aNotification
{
    NSDictionary *dict=[aNotification userInfo];
    logData=[dict valueForKey:@"data"];
}



@end
