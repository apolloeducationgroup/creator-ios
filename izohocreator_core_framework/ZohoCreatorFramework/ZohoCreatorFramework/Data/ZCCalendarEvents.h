//
//  ZCCalendarEvents.h
//  ZohoCreator
//
//  Created by Solai Murugan on 13/12/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ZCCalendarEvent.h"

@interface ZCCalendarEvents : NSObject
{
    @private NSMutableArray *_events;
    @private NSDateFormatter *_mapDateFormat;
}

@property (nonatomic, retain) NSMutableDictionary *eventsForDate;

- (ZCCalendarEvents*) initZCCalendarEvents;
- (void) addZCCalendarEvent : (ZCCalendarEvent*) event;
- (NSMutableArray *) getEventsDate: (NSDate *) fromDate andToDate: (NSDate *) toDate;
- (NSMutableArray *) fetchEventsForDate : (NSDate *) forDate;
+ (NSString *) getDateDisplayValue : (NSString *) datestr;
+ (NSString *) getDisplayValueFromDate : (NSDate *) date;
+ (NSDate *) getDateFromDisplayValue : (NSString *) datestr;


@end
