//
//  ZCRecords.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCRecords.h"

@implementation ZCRecords

@synthesize records=_records;

- (ZCRecords*) initZCRecords {

    self = [super init];
    if(self)  {
        _records = [[NSMutableArray alloc] init];
        _eventDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) addZCRecord : (ZCRecord*) record {
    [_eventDict setObject:record forKey:record.recordID];
    [_records addObject:record];
}

- (ZCRecord *) getZCRecord : (NSString*) recordID
{
    //////// //NSLog(@"SOlai zcrecord :::: %d, %d", [_records count], [_records indexOfObject:[_eventDict objectForKey:recordID]]);
    return [_eventDict objectForKey:recordID];
}

-(id) copyWithZone:(NSZone *)zone {
    
    ZCRecords *records = [[[self class] alloc] initZCRecords];
    if(records) {
        
        [records setRecords:_records];
    }
    return records;
}@end
