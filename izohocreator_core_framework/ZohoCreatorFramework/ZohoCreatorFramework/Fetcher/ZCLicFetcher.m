//
//  ZCLicFetcher.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 22/08/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCLicFetcher.h"

@implementation ZCLicFetcher

@synthesize zcPayment=_zcPayment;

- (ZCLicFetcher*) initLicfetcher {
    
    self = [super init];
    if(self) {
        NSString * urlString=[URLConstructor paymentDetails:[[ZOHOUser userObject] userName]];
        URLConnector *connector = [[URLConnector alloc] initFetcher:urlString];
        ZCPaymentParser *parser = [[ZCPaymentParser alloc] initRecordParser:[connector apiResponse]];
        self->_zcPayment = [parser zcPayment];
        return self;
    }
    return self;
}

- (ZCLicFetcher*) initLicfetcher : (NSString*)  appOwner {
    
    self = [super init];
    if(self) {
        NSString * urlString=[URLConstructor paymentDetails:appOwner];
        URLConnector *connector = [[URLConnector alloc] initFetcher:urlString];
        ZCPaymentParser *parser = [[ZCPaymentParser alloc] initRecordParser:[connector apiResponse]];
        self->_zcPayment = [parser zcPayment];
        return self;
    }
    return self;
}

@end
