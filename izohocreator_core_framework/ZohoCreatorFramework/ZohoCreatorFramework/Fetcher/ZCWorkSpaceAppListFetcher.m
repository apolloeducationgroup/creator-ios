//
//  ZCWorkSpaceAppListFetcher.m
//  ZohoCreator
//
//  Created by Solai Murugan on 19/03/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCWorkSpaceAppListFetcher.h"

@implementation ZCWorkSpaceAppListFetcher

@synthesize applicationList=_applicationList;

- (ZCWorkSpaceAppListFetcher*) initWorkSpaceAppListFetcher:(NSString *)workspaceowner  {
    
    self = [super init];
    //////// //NSLog(@"Init Applist fetcher");
    if (self) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        NSString *zcAppListFile = [ArchiveUtil appListPath];
        //////// //NSLog(@"Coming to App Fetcher");
        if([ConnectionChecker isServerActive])
        {
            NSString *myappListURL = [URLConstructor workSpaceAppListURL:workspaceowner];
            URLConnector *fetcher = [[URLConnector alloc] initFetcherPost:myappListURL:[URLConnector GETMETHOD]];
            NSString *xmlString = [fetcher apiResponse];
            //////// //NSLog(@" appList XML : %@",xmlString);
            ZCApplicationParser *parser = [[ZCApplicationParser alloc ]initApplicationParser:xmlString];
            self->_applicationList = [parser applicationList];
            [EncodeObject encode:zcAppListFile :@"WorkSpaceAppList" :self->_applicationList];        }
        else
        {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
            
            //self->_applicationList = (ZCApplicationList*) [DecodeObject decode :zcAppListFile:@"WorkSpaceAppList"];
        }
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return self;
}


@end
