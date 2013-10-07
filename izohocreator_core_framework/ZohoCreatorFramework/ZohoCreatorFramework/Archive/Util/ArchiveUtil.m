//
//  ArchiveUtil.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ArchiveUtil.h"

@implementation ArchiveUtil

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (NSString*) appListPath
{

    NSArray *availablePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *currentDocumentDir = [availablePaths objectAtIndex:0];
    NSString *filePath = [currentDocumentDir stringByAppendingFormat:@"/AppList"];
    return filePath;

}

+ (NSString*) applicationPath : (NSString*) appLinkName {
    
    NSArray *availablePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *currentDocumentDir = [availablePaths objectAtIndex:0];
    NSString *filePath = [currentDocumentDir stringByAppendingFormat:@"/%@",appLinkName];
    return filePath;
}

+ (NSString*) archiveFilePath : (NSString*) fileName
{
    NSArray *availablePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *currentDocumentDir = [availablePaths objectAtIndex:0];
    NSString *filePath = [currentDocumentDir stringByAppendingFormat:@"/%@",fileName];
    return filePath;
}

+ (BOOL) deleteEncodeFile : (NSString*) fileName {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    [fileManager removeItemAtPath:fileName error:&error];
    if(error == nil) {
        return YES;
    }
    else {
        return NO;
    }    
}


@end
