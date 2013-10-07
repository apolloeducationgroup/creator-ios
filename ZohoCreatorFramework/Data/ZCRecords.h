//
//  ZCRecords.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCRecord.h"

@class ZCRecord;

@interface ZCRecords : NSObject
{
    @private NSMutableDictionary *_eventDict;
}

@property (nonatomic,retain) NSMutableArray *records;

- (ZCRecords*) initZCRecords;
- (void) addZCRecord : (ZCRecord*) record;
- (ZCRecord *) getZCRecord : (NSString*) recordID;

-(id) copyWithZone:(NSZone *)zone ;
@end
