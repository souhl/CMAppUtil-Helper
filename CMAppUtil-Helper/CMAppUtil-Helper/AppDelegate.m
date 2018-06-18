//
//  AppDelegate.m
//  CMAppUtil Helper
//
//  Created by Sascha Uhl on 25/02/15.
//  Copyright (c) 2015 Flaschengeist Studios. All rights reserved.
//

#import "AppDelegate.h"
//#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize cmapputilHelper;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    self.cmapputilHelper = [[CMAppUtilHelper alloc] init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString * object = [prefs objectForKey:@"cmappUtilPath"];
    if(object != nil){
        //object is there
        [self.cmapputilHelper setCMAppUtilPath:object];
    }
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename
{
    if (self.cmapputilHelper.cMAppUtilPathSet)
    {
    
    if ([[filename pathExtension] isEqual:@"pkg"] ||
        [[filename pathExtension] isEqual:@"dmg"] ||
        [[filename pathExtension] isEqual:@"mpkg"] ||
        [[filename pathExtension] isEqual:@"app"])
    {
        NSLog(@"%@",filename);
        [self.cmapputilHelper convert2cmmac:filename];
        
        return YES;
    } else {
        return NO;
    }
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"CMAppUtil not set"];
        [alert setInformativeText:@"CMAppUtil not available. Drag & drop CMAppUtil binary on the application window."];
        [alert setAlertStyle:NSWarningAlertStyle];
    }
    return NO;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (IBAction)visitFGSdotcom:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.flaschengeist-studios.com"]];
}


- (IBAction)visitSupport:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.flaschengeist-studios.com/support"]];
}

- (IBAction)agentDL2012SP1:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.microsoft.com/en-us/download/details.aspx?id=36212"]];
}

- (IBAction)agentDL2012R2:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.microsoft.com/en-us/download/details.aspx?id=39360"]];
}


@end
