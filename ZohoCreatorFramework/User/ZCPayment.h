//
//  ZCPayment.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 05/06/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchiveUtil.h"
#import "EncodeObject.h"
#import "DecodeObject.h"
#import "ZCLicFetcher.h"

@interface ZCPayment : NSObject<NSCoding>

@property (setter = setMobilePaymentStatus:,nonatomic)BOOL isMobilePaymentEnabled;
@property (nonatomic,retain) NSDate *updateDate;

- (ZCPayment*) initZCPayment;
+ (ZCPayment*) getZCPayment;
+ (ZCPayment*) getZCPaymentForAppOwner : (NSString*) appOwner;

@end
