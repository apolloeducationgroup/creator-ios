//
//  ZCAppsCategoryListFetcher.m
//  ZohoCreator
//
//  Created by Solai Murugan on 30/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCAppsCategoryListFetcher.h"

@implementation ZCAppsCategoryListFetcher

- (ZCAppsCategoryListFetcher *)initZCAppsCategoryListFetcher  {
    
    self = [super init];
    //////// ////NSLog@"Init Applist fetcher");
    if (self) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        NSString *zcAppListFile = [ArchiveUtil appListPath];
        //////// ////NSLog@"Coming to App Fetcher");
        if([ConnectionChecker isServerActive])
        {
            NSString *myappListURL = [URLConstructor allAppsCategoryListURL];
            URLConnector *fetcher = [[URLConnector alloc] initFetcherPost:myappListURL:[URLConnector GETMETHOD]];
            NSString *xmlString = [fetcher apiResponse];
            //// ////NSLog@" appList XML : %@",xmlString);
            ZCAppsCategoryParser *parser = [[ZCAppsCategoryParser alloc] initZCAppsCategoryParser:xmlString];
            self->_allAppsCategoryList = [parser allAppsCategory];
            [EncodeObject encode:zcAppListFile :@"AllAppsCategoryList" :self->_allAppsCategoryList];
        }
        else
        {
            
            self->_allAppsCategoryList = (ZCAllAppsCategory *) [DecodeObject decode :zcAppListFile:@"AllAppsCategoryList"];
        }
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return self;
}

@end
