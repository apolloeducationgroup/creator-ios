//
//  ZCGroup.h
//  ZohoCreator
//
//  Created by Solai Murugan on 13/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCFieldData.h"
#import "ZCRecord.h"

@interface ZCGroup : NSObject <NSCopying>

@property (nonatomic,retain) NSMutableArray *zcGroupFields;
@property (nonatomic,retain) NSMutableArray *zcRecords;

-(ZCGroup *) initWithZCGroup;
-(void) addZCGroupFields:(ZCFieldData *) fieldData;
-(void) addZCRecordInGroup:(ZCRecord *) zcRecord;
-(id)copyWithZone:(NSZone *)zone;
@end
