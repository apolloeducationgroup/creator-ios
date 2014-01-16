//
//  ZCCalendarEvents.m
//  ZohoCreator
//
//  Created by Solai Murugan on 13/12/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ZCCalendarEvents.h"

@implementation ZCCalendarEvents

@synthesize eventsForDate=_eventsForDate;

- (ZCCalendarEvents*) initZCCalendarEvents {
    
    self = [super init];
    if(self)  {
        _events = [[NSMutableArray alloc] init];
        
        ////NSLog@"events counts is : %d",[_events count]);
        
        
        _eventsForDate = [[NSMutableDictionary alloc] init];
        
        _mapDateFormat = [[NSDateFormatter alloc] init];
        [_mapDateFormat setDateFormat:@"MM/dd/yyyy"];
    }
    return self;
}

- (void) addZCCalendarEvent:(ZCCalendarEvent *)event {
    
    [_events addObject:event];
    NSString *key = [_mapDateFormat stringFromDate:event.start];
    
    NSMutableArray *eventArray = [[NSMutableArray alloc] init];
    if ([_eventsForDate objectForKey:key]) {
        [eventArray addObjectsFromArray:[_eventsForDate objectForKey:key]];
    }
    [eventArray addObject:event];
    [_eventsForDate setObject:eventArray forKey:key];
    
}

- (NSMutableArray *) getEventsDate: (NSDate *) fromDate andToDate: (NSDate *) toDate;
{
    //  ////// ////NSLog@"Solai eventsDagetEventsDatete :::: %@ :::: %@ :::: %d :::: ", fromDate, toDate, [_eventsForDate count]);
    
    NSString *keydate = [_mapDateFormat stringFromDate:fromDate];
    NSMutableArray *eventsDate = [[NSMutableArray alloc] init];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit |
                                              NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit)
                                    fromDate:fromDate];
	NSDate *startDate = [cal dateFromComponents:comp];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setDay:1];
    
    
    while (YES) {
        if ([startDate compare:toDate] == NSOrderedDescending) {
            break;
        }
        keydate = [_mapDateFormat stringFromDate:startDate];
        
        if ([_eventsForDate objectForKey:keydate] ) {
            [eventsDate addObject:[NSNumber numberWithBool:YES]];
        } else {
            [eventsDate addObject:[NSNumber numberWithBool:NO]];
        }
        startDate = [cal dateByAddingComponents:offsetComponents toDate:startDate options:0];
    }
    return eventsDate;
}

- (NSMutableArray *) fetchEventsForDate : (NSDate*) forDate
{
    
    /* The below has commented for warning */
    //    NSDate *keyDate = [_mapDateFormat stringFromDate:forDate];
    NSString *keyDate = [_mapDateFormat stringFromDate:forDate];
    return [_eventsForDate objectForKey:keyDate];
}

+ (NSDate *) getDateFromDisplayValue : (NSString *) datestr
{
    NSDateFormatter *_strDateFormat = [[NSDateFormatter alloc] init];
    [_strDateFormat setDefaultDate:[NSDate date]];
    [_strDateFormat setDateFormat:@"EEE     dd MMM yyyy"];
    return [_strDateFormat dateFromString:datestr];
}

+ (NSString *) getDisplayValueFromDate : (NSDate *) date
{
    NSDateFormatter *_strDateFormat = [[NSDateFormatter alloc] init];
    [_strDateFormat setDateFormat:@"EEE     dd MMM yyyy"];
    return [_strDateFormat stringFromDate:date];
}

+ (NSString *) getDateDisplayValue : (NSString *) datestr
{
    NSDateFormatter *_mapDateFormat = [[NSDateFormatter alloc] init];
    [_mapDateFormat setDateFormat:@"MM/dd/yyyy"];
    NSDate *keyDate = [_mapDateFormat dateFromString:datestr];
    NSDateFormatter *_strDateFormat = [[NSDateFormatter alloc] init];
    [_strDateFormat setDateFormat:@"EEE     dd MMM yyyy"];
    return [_strDateFormat stringFromDate:keyDate];
}

@end


