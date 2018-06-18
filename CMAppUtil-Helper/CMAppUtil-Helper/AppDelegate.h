//
//  AppDelegate.h
//  CMAppUtil Helper
//
//  Created by Sascha Uhl on 25/02/15.
//  Copyright (c) 2015 Flaschengeist Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CMAppUtilHelper.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{

}

@property (strong, nonatomic) CMAppUtilHelper * cmapputilHelper;

- (IBAction)visitFGSdotcom:(id)sender;
- (IBAction)visitSupport:(id)sender;


@end

