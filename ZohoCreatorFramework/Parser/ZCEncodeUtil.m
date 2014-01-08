//
//  ZCEncodeUtil.m
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 07/01/14.
//  Copyright (c) 2014 mathankumar vv. All rights reserved.
//

#import "ZCEncodeUtil.h"

@implementation ZCEncodeUtil
+(NSString *)encodeStringUsingUT8:(NSString *)string
{

    string= (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) string,NULL,CFSTR("+&"),kCFStringEncodingUTF8));

    return string;
}
+(NSString *)encodeStringUsingASCII:(NSString *)string
{
    
    string= (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) string,NULL,CFSTR("+&"),kCFStringEncodingASCII));

    return string;
    
}

@end
