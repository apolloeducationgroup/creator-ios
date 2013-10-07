//
//  ZCImageFetcher.h
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 05/08/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "URLConstructor.h"
#import "URLConnector.h"
#import "ZCComponent.h"

@interface ZCImageFetcher : NSObject
{
@private
    NSString *_appLinkName;
    NSString *_appOwner;
}
+  (NSData*) fetchImageWITHFilePath: (NSString*) FilePath withViewLinkName : (NSString*) viewLinkName appLinkName:(NSString *)appLinkname appOwner : (NSString *) appOwner;

@end
