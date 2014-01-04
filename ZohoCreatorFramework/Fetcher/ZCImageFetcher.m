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
    
    
    NSData * imagedata=[ZCImageFetcher fetchImageFromURLString:urlString];
    
    NSLog(@"imagedata present %@",imagedata);
    if (!imagedata)
    {

    
    URLConnector *connector = [[URLConnector alloc] initFetcher:urlString];
        imagedata=[connector apiRawData];
        [ZCImageFetcher storeimage:imagedata urlstring:urlString];
        NSLog(@"imagedata not present %@",imagedata);

        
    }
    
    
//    NSString * urlString=[URLConstructor
//                          downloadFile :[NSString stringWithCString:[FilePath cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSUTF8StringEncoding]viewLinkName:viewLinkName :appLinkname :appOwner ];
    
    
    //NSLog(@"raw data %@",[connector apiRawData]);
    return imagedata;
}
+(void)storeimage:(NSData *) imagedata urlstring:(NSString *)url
{
    
    
    NSString *filePath = [ArchiveUtil archiveFilePath:@"imageStroage"];
    [EncodeObject encode:filePath :url :imagedata];

}
+(NSData *)fetchImageFromURLString:(NSString *)url
{
    
    
    NSString *appPath = [ArchiveUtil applicationPath:@"imageStroage"];
    NSData *imagedata =  [DecodeObject decode:appPath :url ];

    return imagedata;
    

}
+(void)deteteimagedata
{
    
    [ArchiveUtil deleteEncodeFile:@"imageStroage"];

}
@end
