//
//  ZCRecordStatus.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 23/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ZCRecordStatus.h"
#import "ZCCriteria.h"

@implementation ZCRecordStatus

@synthesize criteria=_criteria,record=_record,success=_success;

- (void) setCriteria:(ZCCriteria *) localcriteria {

    if(self->_criteria==nil) {
        self->_criteria = [localcriteria copy];
    }
    else {
    }
}

- (void) setCriteria:(ZCCriteria *) localcriteria : (NSInteger) reloperator {
    
    if (self->_criteria != nil) {

    }
         else {
    
         }
}

- (ZCRecord*) getRecord {
    
    //// //NSLog(@"record object %@",_record);
    return _record;
}

+ (BOOL) getStatusForBulkRecords : (NSArray*) recordsStatus {
    
    return YES;
}

@end
