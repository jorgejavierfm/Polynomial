//
//  PreferencesController.m
//  Polynomial
//
//  Created by iTMiNus on 12/5/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "PreferencesController.h"

@interface PreferencesController ()

@end

@implementation PreferencesController

-(id)init
{
    if (![super initWithWindowNibName:@"Preferences"]) {
        return nil;
    }

    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    [xMin setDoubleValue:-40.0];
    [xMax setDoubleValue:40.0];
    [yMin setDoubleValue:-40.0];
    [yMax setDoubleValue:40.0];
    
    [markIntervale setIntegerValue:2];
}

-(IBAction)apply:(id)sender
{
    if([xMin doubleValue]>0 || [yMin doubleValue]>0)
        NSRunAlertPanel(@"Information", @"El valor minimo de los ejes no puede ser mayor que 0", @"Ok", nil, nil);
    else if([markIntervale doubleValue]<=0)
        NSRunAlertPanel(@"Information", @"El intervalo de marcado tiene que ser mayor que 0", @"Ok", nil, nil);
    else
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:xMin forKey:@"xMin"];
        [dict setValue:xMax forKey:@"xMax"];
        [dict setValue:yMin forKey:@"yMin"];
        [dict setValue:xMax forKey:@"yMax"];
        [dict setValue:markIntervale forKey:@"markIntervale"];
        [dict setValue:[backgroundColor color] forKey:@"backgroundColor"];
        
        NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"PreferencesChange"
                          object:self
                        userInfo:dict];
        
        
        [self close];
    }
}

@end
