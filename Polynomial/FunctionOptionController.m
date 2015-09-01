//
//  FunctionOptionController.m
//  Polynomial
//
//  Created by iTMiNus on 11/25/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "FunctionOptionController.h"

@interface FunctionOptionController ()

@end

@implementation FunctionOptionController

-(id)initWithParametersActivated:(NSString *)sToAnalize
{
    if (![super initWithWindowNibName:@"FunctionOption"]) {
        return nil;
    }
    
    stringToAnalize=sToAnalize; 
    
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(handleNotification:)
               name:@"stringHasChanged"
             object:nil];
    
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
    
    [self analizeString:stringToAnalize];
    [xMin setDoubleValue:-40.0];
    [xMax setDoubleValue:40.0];
    [yMin setDoubleValue:-40.0];
    [yMax setDoubleValue:40.0];
}


-(IBAction)apply:(id)sender
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    
    //Resumen corto de este if: Si algun outlet esta activado y no se ha introducido nada abrir un panel indicando al usuario k no puede kedar vacio
    
    if(([parameterA isEnabled]==TRUE && [[parameterA stringValue] length]==0) || ([parameterB isEnabled]==TRUE && [[parameterB stringValue] length]==0) || ([parameterN isEnabled]==TRUE && [[parameterN stringValue] length]==0) || ([parameterC isEnabled]==TRUE && [[parameterC stringValue] length]==0)|| [[functionName stringValue] length]==0)
        NSRunAlertPanel(@"Information", @"Please fill the remaining fields", @"Ok", nil, nil);
    else
    {
        [dict setValue:[functionName stringValue] forKey:@"functionName"];
        [dict setValue:[colorControl color] forKey:@"functionColor"];
            
        if([parameterA isEnabled]==TRUE)
        {
            NSNumber *parameterAWrap=[NSNumber numberWithDouble:[parameterA doubleValue]];
            [dict setValue:parameterAWrap forKey:@"a"];
        }
        if([parameterB isEnabled]==TRUE)
        {
            NSNumber *parameterBWrap=[NSNumber numberWithDouble:[parameterB doubleValue]];
            [dict setValue:parameterBWrap forKey:@"b"];
        }
        if([parameterC isEnabled]==TRUE)
        {
            NSNumber *parameterCWrap=[NSNumber numberWithDouble:[parameterC doubleValue]];
            [dict setValue:parameterCWrap forKey:@"c"];
        }
        if([parameterN isEnabled]==TRUE)
        {
            NSNumber *parameterNWrap=[NSNumber numberWithDouble:[parameterN doubleValue]];
            [dict setValue:parameterNWrap forKey:@"n"];
        }
        
        [dict setValue:xMin forKey:@"xMin"];
        [dict setValue:xMax forKey:@"xMax"];
        [dict setValue:yMin forKey:@"yMin"];
        [dict setValue:yMax forKey:@"yMax"];
        
        [nc postNotificationName:@"OptionsEntered"
                          object:self
                        userInfo:dict];
        
        [self close];
        
    }
    
   

}

-(void)analizeString:(NSString *)sToAnalize
{
    unichar before;
    unichar next;
    NSCharacterSet *letterSet=[NSCharacterSet letterCharacterSet];
    
    for(int i=0;i<[sToAnalize length];i++)
    {
        if(i!=0)
            before=[sToAnalize characterAtIndex:i-1];
        
        if (i+1<[sToAnalize length])
            next=[sToAnalize characterAtIndex:i+1];
        
        switch ([sToAnalize characterAtIndex:i])
        {
            case 'a':
                if(i+1==[sToAnalize length]){
                   [parameterA setEnabled:TRUE];
                    break;
                }
                if([letterSet characterIsMember:before] || [letterSet characterIsMember:next]){
                    [parameterA setEnabled:FALSE];
                    break;
                }
                [parameterA setEnabled:TRUE];
                break;
            case 'b':
                if(i+1==[sToAnalize length]){
                    [parameterB setEnabled:TRUE];
                    break;
                }
                if([letterSet characterIsMember:before] || [letterSet characterIsMember:next]){
                    [parameterB setEnabled:FALSE];
                    break;
                }
                [parameterB setEnabled:TRUE];
                break;
            case 'c':
                if(i+1==[sToAnalize length]){
                    [parameterC setEnabled:TRUE];
                    break;
                }
                if([letterSet characterIsMember:before] || [letterSet characterIsMember:next]){
                    [parameterC setEnabled:FALSE];
                    break;
                }
                [parameterC setEnabled:TRUE];
                break;
            case 'n':
                if(i+1==[sToAnalize length]){
                    [parameterN setEnabled:TRUE];
                    break;
                }
                if([letterSet characterIsMember:before] || [letterSet characterIsMember:next]){
                    [parameterN setEnabled:FALSE];
                    break;
                }
                [parameterN setEnabled:TRUE];
                break;
            default:
                break;
        }
    }
}

-(void)handleNotification:(NSNotification *)aNotification
{
    [parameterA setEnabled:FALSE];
    [parameterB setEnabled:FALSE];
    [parameterC setEnabled:FALSE];
    [parameterN setEnabled:FALSE];
    NSDictionary *dict=[aNotification userInfo];
    [self analizeString:[dict valueForKey:@"newstring"]];
}


@end
