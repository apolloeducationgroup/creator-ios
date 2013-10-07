//
//  ZCCalendarEvent.h
//  ZohoCreator
//
//  Created by Solai Murugan on 13/12/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//


#import <Foundation/Foundation.h>

@class ZCRecord;

@interface ZCCalendarEvent : NSObject

@property (nonatomic,retain) ZCRecord *zcRecord;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *subTitle;
@property (nonatomic,assign) NSInteger eventType;
@property (nonatomic,retain) NSDate *start;
@property (nonatomic,retain) NSDate *end;


+ (NSInteger) EVENT_ALLDAY;
+ (NSInteger) EVENT_LONG_STARTS;
+ (NSInteger) EVENT_LONG_ENDS;
+ (NSInteger) EVENT_SHORT;

@end
