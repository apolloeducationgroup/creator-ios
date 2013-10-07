//
//  ZCImageFetcher.m
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 05/08/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCImageFetcher.h"

@implementation ZCImageFetcher

+  (NSData*) fetchImageWITHFilePath: (NSString*) FilePath withViewLinkName : (NSString*) viewLinkName appLinkName:(NSString *)appLinkname appOwner : (NSString *) appOwner {
    
    NSString * urlString=[URLConstructor downloadFile:FilePath viewLinkName:viewLinkName :appLinkname :appOwner ];
    
    URLConnector *connector = [[URLConnector alloc] initFetcher:urlString];
    //NSLog(@"raw data %@",[connector apiRawData]);
    return [connector apiRawData];
}
@end
