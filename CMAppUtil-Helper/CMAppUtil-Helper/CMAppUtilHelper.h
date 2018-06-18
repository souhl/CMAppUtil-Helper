//
//  CMAppUtilHelper.h
//  CMAppUtil Helper
//
//  Created by Sascha Uhl on 25/02/15.
//  Copyright (c) 2015 Flaschengeist Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMAppUtilHelper : NSObject
{
    NSString * cmappUtilPath;
}

- (void) convert2cmmac:(NSString*)filepath;
- (void) setCMAppUtilPath:(NSString *) filepath;
- (bool) cMAppUtilPathSet;

@end
