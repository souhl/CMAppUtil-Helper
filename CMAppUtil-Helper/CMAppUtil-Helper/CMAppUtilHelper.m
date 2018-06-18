//
//  CMAppUtilHelper.m
//  CMAppUtil Helper
//
//  Created by Sascha Uhl on 25/02/15.
//  Copyright (c) 2015 Flaschengeist Studios. All rights reserved.
//

#import "CMAppUtilHelper.h"
#import <Carbon/Carbon.h>

@implementation CMAppUtilHelper


- (void) convert2cmmac:(NSString*)filepath
{
    if (cmappUtilPath)
    {
        dispatch_queue_t taskQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        dispatch_async(taskQueue, ^
                       {
                           NSLog(@"Convert 2 .CMMAC");
                           
                           NSUserNotification *notification1 = [[NSUserNotification alloc] init];
                           notification1.title = [[[filepath lastPathComponent] stringByDeletingPathExtension] stringByRemovingPercentEncoding];
                           notification1.informativeText = @"Converting...";
                           notification1.soundName = NSUserNotificationDefaultSoundName;
                           [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification1];

                           NSString * downloadPath = [NSString stringWithFormat:@"/Users/%@/Downloads",NSUserName()];
                           
                           // Create Folder
                           NSDate *today = [NSDate date];
                           NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                           [dateFormat setDateFormat:@"MMddyyyyHHmmss"];
                           NSString *dateString = [dateFormat stringFromDate:today];
                           NSLog(@"date: %@", dateString);
                           
                           NSString * cmmacFilePath = [NSString stringWithFormat:@"%@/%@-%@",downloadPath,[[filepath lastPathComponent] stringByDeletingPathExtension],dateString];
                           
                           BOOL isDir;
                           NSFileManager *fileManager= [NSFileManager defaultManager];
                           if(![fileManager fileExistsAtPath:cmmacFilePath isDirectory:&isDir])
                               if(![fileManager createDirectoryAtPath:cmmacFilePath withIntermediateDirectories:YES attributes:nil error:NULL])
                                   NSLog(@"Error: Create folder failed %@", cmmacFilePath);
                           
                           // Convert
                           NSError *error;
                           NSLog(@"Error: %@",error.description);
                           
                           NSTask *task = [[NSTask alloc] init];
                           
                           NSArray *args = [NSArray arrayWithObjects:@"-c",filepath,@"-o",cmmacFilePath,@"-a", nil];
                           NSLog(@"Arguments: %@",args);
                           
                           NSLog(@"CMAppUtilPath: %@",cmappUtilPath);
                           
                           [task setLaunchPath:cmappUtilPath];
                           [task setArguments:args];
                           
                           NSPipe *pipe;
                           pipe = [NSPipe pipe];
                           [task setStandardOutput: pipe];
                           
                           NSFileHandle *file;
                           file = [pipe fileHandleForReading];
                           
                           [task launch];
                           
                           NSData *data;
                           data = [file readDataToEndOfFile];
                           NSString *response = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                           
                           [task waitUntilExit];
                           int status = [task terminationStatus];
                           
                           NSLog(@"Response: \n%@",response);
                 
                           
                           if ([response rangeOfString:@"CMAppUtil successfully processed"].location == NSNotFound) {
                               NSLog(@"conversion with error");
                               status = 1;
                           } else {
                               NSLog(@"conversion successful");
                               status = 0;
                           }
                           
                           NSLog(@"Task Status: %i",status);
                           
                           if (status == 0)
                           {
                               NSLog(@"Task succeeded.");
                               NSUserNotification *notification1 = [[NSUserNotification alloc] init];
                               notification1.title = [[[filepath lastPathComponent] stringByDeletingPathExtension] stringByRemovingPercentEncoding];
                               notification1.informativeText = @"Conversion done & file placed in your \"Downloads\" folder.";
                               notification1.soundName = NSUserNotificationDefaultSoundName;
                               [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification1];
                               
                               
                           }
                           else
                           {
                               NSLog(@"Task failed.");
                               NSUserNotification *notification1 = [[NSUserNotification alloc] init];
                               notification1.title = [[[filepath lastPathComponent] stringByDeletingPathExtension] stringByRemovingPercentEncoding];
                               notification1.informativeText = @"Conversion failed.";
                               notification1.soundName = NSUserNotificationDefaultSoundName;
                               [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification1];
                               
                               if ([fileManager fileExistsAtPath:cmmacFilePath] == YES) {
                                   [fileManager removeItemAtPath:cmmacFilePath error:&error];
                               }

                               //return NO;
                           }
                       });
        //return YES;
    } else {
        //return NO;
    }
}

- (void) setCMAppUtilPath:(NSString *) filepath
{
    cmappUtilPath = filepath;
    
    [[NSUserDefaults standardUserDefaults] setValue:cmappUtilPath forKey:@"cmappUtilPath"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (bool) cMAppUtilPathSet
{
    if (cmappUtilPath)
        return YES;
    return NO;
}

@end
