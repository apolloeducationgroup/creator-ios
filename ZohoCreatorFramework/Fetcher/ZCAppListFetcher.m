//
//  ZCAppListFetcher.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCAppListFetcher.h"

@implementation ZCAppListFetcher

@synthesize applicationList=_applicationList;

- (ZCAppListFetcher*) initAppListFetcher  {
    
    self = [super init];
    if (self) {
        NSString *zcAppListFile = [ArchiveUtil appListPath];
        if([ConnectionChecker isServerActive])
        {
            NSString *myappListURL = [URLConstructor appListURL];
            //// //NSLog(@"my url %@",myappListURL);
            URLConnector *fetcher = [[URLConnector alloc] initFetcherPost:myappListURL:[URLConnector GETMETHOD]];
            NSString *xmlString = [fetcher apiResponse];
            // //NSLog(@"xml string %@",xmlString);
            ZCApplicationParser *parser = [[ZCApplicationParser alloc ]initApplicationParser:xmlString];
            self->_applicationList = [parser applicationList];
            [EncodeObject encode:zcAppListFile :@"MyAppList" :self->_applicationList];        }
        else
        {
            //// //NSLog(@"\n\nnot net\n\n");
            
            //self->_applicationList = (ZCApplicationList*) [DecodeObject decode :zcAppListFile:@"MyAppList"];
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
        }
    }
    return self;
}
@end
