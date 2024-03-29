//
//  ParserUtil.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 12/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCView.h"
#import "ZCForm.h"
#import "ZCRecordUtil.h"
#import "ZCComponent.h"

@class ZCForm,ZCView,ZCComponent;

@interface ParserUtil : NSObject

+ (ZCForm*) convertToZCForm : (ZCComponent*) component;
+ (ZCView*) convertToZCView : (ZCComponent*) component;
+ (NSString*) getURL : (NSString*) rawString;
+ (NSString*) getImageLocationURLString : (NSString*) rawString;
+ (NSMutableDictionary*) getURLString : (NSString*) rawString;
+ (NSString*) extractEmailFromLink : (NSString*) rawString;


+ (NSString*) extactSringFormSubformData : (NSString*) rawString;
+(NSString *) stringByStrippingHTML:(NSString *)string;
@end
