//
//  ZCRecordUtil.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 12/12/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCRecord.h"

@interface ZCRecordUtil : NSObject

+ (NSString*) getPrimaryValue : (ZCRecord*) zcRecord viewFields:(NSMutableDictionary *)viewFields;
+ (NSString*) getPrimaryValueByCount : (ZCRecord*) zcRecord : (NSInteger) count viewFields:(NSMutableDictionary *)viewFields;
+ (NSString*) getSubtitleValueByCount : (ZCRecord*) zcRecord : (NSInteger) startIndex : (NSInteger) count viewFields:(NSMutableDictionary *)viewFields;
+ (NSString*) getPrimaryTextField : (ZCView*) zcview : (NSInteger) rowIndex : (NSInteger) columnIndex viewFields:(NSMutableDictionary *)viewFields;
@end
