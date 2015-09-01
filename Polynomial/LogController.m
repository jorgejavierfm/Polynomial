//
//  LogController.m
//  Polynomial
//
//  Created by iTMiNus on 12/3/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "LogController.h"

@interface LogController ()

@end

@implementation LogController

-(id)initWithData:(NSMutableArray *)functions
{
    if (![super initWithWindowNibName:@"Logs"]) {
        return nil;
    }
    
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(handleNotification:)
               name:@"NewFunction"
             object:nil];
    
    data=functions;
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
}

-(void)handleNotification:(NSNotification *)aNotification
{
    [tab reloadData];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *) atableview
{
    return [data count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Polynomial *p= [data objectAtIndex:row];
    NSString *identificador=[tableColumn identifier];
    
    return [p valueForKey:identificador];
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    if([data count]>0)
        [del setEnabled:TRUE];
    else
        [del setEnabled:FALSE];
}

-(IBAction)delete:(id)sender
{
    [data removeObjectAtIndex:[tab selectedRow]];
    [tab reloadData];
    
    [del setEnabled:FALSE];
    
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"Refresh"
                      object:self];
}

@end
