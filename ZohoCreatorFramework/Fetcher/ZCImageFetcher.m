//
//  ZCImageFetcher.m
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 05/08/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCImageFetcher.h"

@implementation ZCImageFetcher

+  (NSData*) fetchImageWITHFilePath: (NSString*) FilePath withViewLinkName : (NSString*) viewLinkName appLinkName:(NSString *)appLinkname appOwner : (NSString *) appOwner  getOnlyImageURL:(BOOL)getIMageURL{
    
    
    
    
    
    NSURL *validURL = [NSURL URLWithString:FilePath];
    
    NSString* urlString;
    if (validURL && validURL.scheme && validURL.host) {
        
        urlString=FilePath;
        
    }
    
    else {
        
        
urlString = [URLConstructor downloadFile:FilePath viewLinkName:viewLinkName :appLinkname :appOwner];
        
    }
    
    if (getIMageURL)
    {
        return[urlString dataUsingEncoding:[NSString defaultCStringEncoding]];
    }
    
    
    
    
    
    
//    NSString * urlString=[URLConstructor
//                          downloadFile :[NSString stringWithCString:[FilePath cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSUTF8StringEncoding]viewLinkName:viewLinkName :appLinkname :appOwner ];
    
    
    URLConnector *connector = [[URLConnector alloc] initFetcher:urlString];
    //NSLog(@"raw data %@",[connector apiRawData]);
    return [connector apiRawData];
}
@end
