//
//  LogController.h
//  Polynomial
//
//  Created by iTMiNus on 12/3/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Polynomial.h"

@interface LogController : NSWindowController <NSTableViewDelegate,NSTableViewDataSource>
{
    IBOutlet NSTableView *tab;
    IBOutlet NSButton *del;
    NSMutableArray *data;
}

-(id)initWithData:(NSMutableArray *)data;
-(void)handleNotification:(NSNotification *)aNotification;
-(IBAction)delete:(id)sender;

@end
