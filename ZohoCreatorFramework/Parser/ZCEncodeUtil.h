//
//  ZCEncodeUtil.h
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 07/01/14.
//  Copyright (c) 2014 mathankumar vv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCEncodeUtil : NSObject

+(NSString *) encodeStringUsingUT8:(NSString *)string;
+(NSString *)encodeStringUsingASCII:(NSString *)string;
@end
