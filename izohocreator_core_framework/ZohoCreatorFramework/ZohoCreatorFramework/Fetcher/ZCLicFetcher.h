//
//  ZCLicFetcher.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 22/08/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLConstructor.h"
#import "URLConnector.h"
#import "ZCPaymentParser.h"

@class ZCPayment;

@interface ZCLicFetcher : NSObject

@property (nonatomic,retain) ZCPayment *zcPayment;

-  (ZCLicFetcher*) initLicfetcher;
- (ZCLicFetcher*) initLicfetcher : (NSString*)  appOwner;

@end
