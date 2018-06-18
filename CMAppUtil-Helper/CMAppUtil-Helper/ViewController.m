//
//  ViewController.m
//  CMAppUtil Helper
//
//  Created by Sascha Uhl on 25/02/15.
//  Copyright (c) 2015 Flaschengeist Studios. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(checkCMAppUtilSet)
                                           userInfo:nil
                                            repeats:YES];

}

- (void) viewWillAppear{
    [super viewWillAppear];
    [self checkCMAppUtilSet];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (void) checkCMAppUtilSet
{
    AppDelegate *appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    if ([appDelegate.cmapputilHelper cMAppUtilPathSet])
    {
        [image setImage:[NSImage imageNamed:@"drag-drop.002"]];
        [timer invalidate];
        timer = nil;
        
    } else {
        //[image setImage:[NSImage imageNamed:@"drag-drop.001"]];
    }
}


@end
