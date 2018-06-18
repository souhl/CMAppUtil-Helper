//
//  NSCImageView.m
//  CMAppUtil Helper
//
//  Created by Sascha Uhl on 12/07/14.
//  Copyright (c) 2014 Flaschengeist Studios. All rights reserved.
//

#import "NSCImageView.h"
#import "AppDelegate.h"

@implementation NSCImageView


- (id)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
    }
    
        return self;
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask])
		== NSDragOperationGeneric)
    {
        //this means that the sender is offering the type of operation we want
        //return that we want the NSDragOperationGeneric operation that they
		//are offering
        return NSDragOperationGeneric;
    }
    else
    {
        //since they aren't offering the type of operation we want, we have
		//to tell them we aren't interested
        return NSDragOperationNone;
    }
}



- (void)draggingExited:(id <NSDraggingInfo>)sender
{
    //we aren't particularily interested in this so we will do nothing
    //this is one of the methods that we do not have to implement
	NSLog(@"%@", sender);
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    [self setNeedsDisplay: YES];
    return YES;
}


- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSArray *draggedFilenames = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
    AppDelegate *appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    
    if ([[[draggedFilenames objectAtIndex:0] lastPathComponent] isEqual:@"CMAppUtil"]){
        [appDelegate.cmapputilHelper setCMAppUtilPath:[draggedFilenames lastObject]];

        return YES;
    } else {
        
        if ([[[draggedFilenames objectAtIndex:0] pathExtension] isEqual:@"pkg"] ||
            [[[draggedFilenames objectAtIndex:0] pathExtension] isEqual:@"dmg"] ||
            [[[draggedFilenames objectAtIndex:0] pathExtension] isEqual:@"mpkg"] ||
            [[[draggedFilenames objectAtIndex:0] pathExtension] isEqual:@"app"])
        {
            NSLog(@"%@",[draggedFilenames lastObject]);
            
            [appDelegate.cmapputilHelper convert2cmmac:[draggedFilenames lastObject]];
            return YES;
        } else {
            return NO;
        }
    }
}



@end
