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
#import "ZCComponent.h"

@class ZCForm,ZCView,ZCComponent;

@interface ParserUtil : NSObject

+ (ZCForm*) convertToZCForm : (ZCComponent*) component;
+ (ZCView*) convertToZCView : (ZCComponent*) component;
+ (NSString*) getURL : (NSString*) rawString;
+ (NSString*) getImageLocation : (NSString*) rawString;
+ (NSMutableDictionary*) getURLString : (NSString*) rawString;
+ (NSString*) extractEmailFromLink : (NSString*) rawString;

@end
