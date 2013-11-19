//
//  ZCRecordStatus.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 23/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCRecord.h"
#import "ZCRecordError.h"
#import "ZCCriteriaUtil.h"

@class ZCCriteria,ZCRecord;

@interface ZCRecordStatus : NSObject

@property BOOL success;
@property (nonatomic,retain,getter = getRecord) ZCRecord *record;
@property (nonatomic,retain) ZCRecordError *error;
@property (nonatomic,retain,setter = setCriteria:) ZCCriteria *criteria;
@property (nonatomic,retain)NSMutableDictionary * lookUpAddedDataDict;
- (void) setCriteria:(ZCCriteria *) localcriteria : (NSInteger) reloperator;
+ (BOOL) getStatusForBulkRecords : (NSArray*) recordsStatus;
-(void)addvalueToSelectedLookUpValueDict:(NSString *)value key:(NSString *)key;
@end