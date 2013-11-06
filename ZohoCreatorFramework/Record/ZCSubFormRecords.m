//
//  ZCSubFormRecords.m
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 09/09/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCSubFormRecords.h"
#import "ZCRecord.h"

@implementation ZCSubFormRecords
@synthesize recordsToAdd=_recordsToAdd,recordsToUpdate=_recordsToUpdate,recordsToDelete=_recordsToDelete,zcSubForm=_zcSubForm,temporaryRecords=_temporaryRecords;
-(id)init{
    self=[super init];
    if (self) {
        
        _recordsToUpdate=[[NSMutableArray alloc]init];
        _recordsToAdd=[[NSMutableArray alloc]init];
        _recordsToDelete=[[NSMutableArray alloc]init];
        _temporaryRecords=[[NSMutableArray alloc]init];
        
    }
    return self;
    
}
-(void)addRecordToAdd:(ZCRecord *)record
{
    [_recordsToAdd addObject:record];
    
}
-(void)addRecordToUpdate:(ZCRecord *)record
{
    [_recordsToUpdate addObject:record];
    
}
-(void)addRecordToDelete:(ZCRecord *)record
{
    [_recordsToDelete addObject:record];
}
-(void)addTemporaryRecords:(ZCRecord *)record
{

    [_temporaryRecords addObject:record];
}
-(void)clearTemporaryRecords
{
    [_temporaryRecords removeAllObjects];    
}
@end
