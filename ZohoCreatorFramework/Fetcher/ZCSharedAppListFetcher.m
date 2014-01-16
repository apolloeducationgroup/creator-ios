//
//  ZCSharedAppListFetcher.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 18/01/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCSharedAppListFetcher.h"

@implementation ZCSharedAppListFetcher

@synthesize applicationList=_applicationList;

- (ZCSharedAppListFetcher*) initSharedAppListFetcher  {
    
    self = [super init];
    //////// ////NSLog@"Init Applist fetcher");
    if (self) {
        
        NSString *zcAppListFile = [ArchiveUtil appListPath];
        //////// ////NSLog@"Coming to App Fetcher");
        if([ConnectionChecker isServerActive])
        {
            NSString *myappListURL = [URLConstructor sharedAppListURL];
            URLConnector *fetcher = [[URLConnector alloc] initFetcherPost:myappListURL:[URLConnector GETMETHOD]];
            NSString *xmlString = [fetcher apiResponse];
            //// ////NSLog@" appList XML : %@",xmlString);
            ZCApplicationParser *parser = [[ZCApplicationParser alloc ]initApplicationParser:xmlString];
            self->_applicationList = [parser applicationList];
            [EncodeObject encode:zcAppListFile :@"SharedAppList" :self->_applicationList];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
            
            //   self->_applicationList = (ZCApplicationList*) [DecodeObject decode :zcAppListFile:@"SharedAppList"];
        }
    }
    return self;
}

- (ZCSharedAppListFetcher*) initSharedAppListFetcherForGroup : (NSString *) groupId  {
    
    self = [super init];
    //////// ////NSLog@"Init Applist fetcher");
    if (self) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        NSString *zcAppListFile = [ArchiveUtil appListPath];
        //////// ////NSLog@"Coming to App Fetcher");
        if([ConnectionChecker isServerActive])
        {
            NSString *myappListURL = [URLConstructor sharedAppListURL:groupId];
            URLConnector *fetcher = [[URLConnector alloc] initFetcherPost:myappListURL:[URLConnector GETMETHOD]];
            NSString *xmlString = [fetcher apiResponse];
            //// ////NSLog@" appList XML : %@",xmlString);
            ZCApplicationParser *parser = [[ZCApplicationParser alloc ]initApplicationParser:xmlString];
            self->_applicationList = [parser applicationList];
            [EncodeObject encode:zcAppListFile :@"SharedAppList" :self->_applicationList];
        }
        else
        {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
            
            //   self->_applicationList = (ZCApplicationList*) [DecodeObject decode :zcAppListFile:@"SharedAppList"];
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    return self;
}



@end
