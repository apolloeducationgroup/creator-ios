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

+ (NSString*) getPrimaryValue : (ZCRecord*) zcRecord;
+ (NSString*) getPrimaryValueByCount : (ZCRecord*) zcRecord : (NSInteger) count;
+ (NSString*) getSubtitleValueByCount : (ZCRecord*) zcRecord : (NSInteger) startIndex : (NSInteger) count;
+ (NSString*) getPrimaryTextField : (ZCView*) zcview : (NSInteger) rowIndex : (NSInteger) columnIndex;

@end
