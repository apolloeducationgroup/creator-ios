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

+ (NSString*) getPrimaryValue : (ZCRecord*) zcRecord viewFields:(NSMutableArray *)viewFields;
+ (NSString*) getPrimaryValueByCount : (ZCRecord*) zcRecord : (NSInteger) count viewFields:(NSMutableArray *)viewFields;
+ (NSString*) getSubtitleValueByCount : (ZCRecord*) zcRecord : (NSInteger) startIndex : (NSInteger) count viewFields:(NSMutableArray *)viewFields;
+ (NSString*) getPrimaryTextField : (ZCView*) zcview : (NSInteger) rowIndex : (NSInteger) columnIndex viewFields:(NSMutableArray *)viewFields;
@end
