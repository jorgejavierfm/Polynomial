//
//  PanelsController.h
//  Polynomial
//
//  Created by iTMiNus on 12/5/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LogController;
@class PreferencesController;

@interface PanelsController : NSObject
{
    NSMutableArray *logData;
    LogController *logs;
    PreferencesController *pref;
}

-(IBAction)showPreferences:(id)sender;
-(IBAction)showLogs:(id)sender;

@end
