//
//  ZCGroup.m
//  ZohoCreator
//
//  Created by Solai Murugan on 13/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCGroup.h"

@implementation ZCGroup

@synthesize zcGroupFields=_zcGroupFields, zcRecords=_zcRecords;

-(ZCGroup *) initWithZCGroup
{
    self = [super init];
    if (self) {
        _zcRecords = [[NSMutableArray alloc] init];
        _zcGroupFields = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addZCGroupFields:(ZCFieldData *) fieldData
{
    [_zcGroupFields addObject:fieldData];
}

- (BOOL) removeZCGroupField : (ZCFieldData*) fieldData {
    
    BOOL status = NO;
    for(NSInteger index=0;index< [_zcGroupFields count];index++) {
        
        ZCFieldData *tempData = [_zcGroupFields objectAtIndex:index];
        if([[tempData fieldName] isEqualToString:[fieldData fieldName]]) {
            [_zcGroupFields removeObjectAtIndex:index];
            status = YES;
        }
    }
    return status;
}

- (BOOL) removeAllZCGroupField {
    
    [_zcGroupFields removeAllObjects];
    return YES;
}

- (id) copyWithZone:(NSZone *)zone {
    
    ZCGroup *selfObject = [[ZCGroup alloc] initWithZCGroup];
    if(selfObject) {
        [[selfObject zcGroupFields] addObjectsFromArray:_zcGroupFields];
        [[selfObject zcRecords] addObjectsFromArray:_zcRecords];
    }
    return selfObject;
}

-(void) addZCRecordInGroup:(ZCRecord *) zcRecord
{
    [zcRecord setZCGroup:self];
    [_zcRecords addObject:zcRecord];
}

@end
