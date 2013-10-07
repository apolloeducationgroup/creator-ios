//
//  ArchiveUtil.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZohoUser.h"

@interface ArchiveUtil : NSObject  {
    
}
+ (NSString*) applicationPath : (NSString*) appLinkName;
+ (NSString*) appListPath;
+ (NSString*) archiveFilePath : (NSString*) fileName;
+ (BOOL) deleteEncodeFile : (NSString*) fileName;

@end
