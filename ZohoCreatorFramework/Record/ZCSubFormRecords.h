//
//  ZCSubFormRecords.h
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 09/09/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCRecord.h"
@interface ZCSubFormRecords : NSObject
@property (nonatomic,retain) NSMutableArray * recordsToUpdate;
@property (nonatomic,retain) NSMutableArray * recordsToAdd;
@property (nonatomic,retain) NSMutableArray * recordsToDelete;
@property (nonatomic,retain) ZCForm * zcSubForm;
-(void)addRecordToAdd:(ZCRecord *)record;
-(void)addRecordToUpdate:(ZCRecord *)record;
-(void)addRecordToDelete:(ZCRecord *)record;
@end
