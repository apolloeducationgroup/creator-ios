//
//  ZCCalendarEvent.m
//  ZohoCreator
//
//  Created by Solai Murugan on 13/12/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//



#import "ZCCalendarEvent.h"

@implementation ZCCalendarEvent

@synthesize zcRecord = _zcRecord, eventType = _eventType, end = _end, start = _start, title = _title, subTitle=_subTitle;

+ (NSInteger) EVENT_SHORT  {
    return 1;
}

+ (NSInteger) EVENT_ALLDAY  {
    return 2;
}

+ (NSInteger) EVENT_LONG_STARTS  {
    return 3;
}

+ (NSInteger) EVENT_LONG_ENDS  {
    return 4;
}

@end

