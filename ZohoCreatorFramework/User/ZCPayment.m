//
//  ZCPayment.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 05/06/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCPayment.h"

@implementation ZCPayment

@synthesize isMobilePaymentEnabled=_isMobilePaymentEnabled;

static ZCPayment *zcPaymentObj = nil;

+ (ZCPayment*) getZCPayment {
    
    BOOL needToFetch = NO;
    if(zcPaymentObj == nil)
    {
        NSString *filePath = [ArchiveUtil archiveFilePath:@"Payment"];
        ZCPayment *_zcPay = [DecodeObject decode:filePath :@"Payment"];
        if(_zcPay != nil) {
            zcPaymentObj = _zcPay;
            NSCalendar *cal = [NSCalendar currentCalendar];
            NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
            [components setHour:-[components hour]];
            [components setMinute:-[components minute]];
            [components setSecond:-[components second]];
            NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now
            if([[zcPaymentObj updateDate] compare:today] != NSOrderedSame) {
                needToFetch = YES;
            }
        }
        else {
            needToFetch = YES;
        }
    }
    
    if(needToFetch == YES ) {
        
        ZCLicFetcher *lic = [[ZCLicFetcher alloc] initLicfetcher];
        zcPaymentObj = [lic zcPayment];
        //  NSString *filePath = [ArchiveUtil archiveFilePath:@"Payment"];
        //        [EncodeObject encode:filePath :@"Payment" :self];
    }
    return zcPaymentObj;
}


+ (ZCPayment*) getZCPaymentForAppOwner : (NSString*) appOwner {
    
    ZCLicFetcher *lic = [[ZCLicFetcher alloc] initLicfetcher:appOwner];
    return [lic zcPayment];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self->_isMobilePaymentEnabled=[aDecoder decodeBoolForKey:@"isMobile"];
    self->_updateDate=[aDecoder decodeObjectForKey:@"date"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeBool:_isMobilePaymentEnabled forKey:@"isMobile"];
    [aCoder encodeObject:_updateDate forKey:@"date"];
}


- (ZCPayment*) initZCPayment {
    
    self = [super init];
    return self;
}

- (void) setMobilePaymentStatus : (BOOL) status
{
    _isMobilePaymentEnabled = status;
}

@end
