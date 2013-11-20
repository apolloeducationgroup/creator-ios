//
//  ZCUserDetailsFetcher.m
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 28/08/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCUserDetailsFetcher.h"
#import "URLConnector.h"
#import "URLConstructor.h"
#import "ZCUserParser.h"
@implementation ZCUserDetailsFetcher

@synthesize userObject=_userObject;

- (ZCUserDetailsFetcher*) initUserDetailFetcher {
    
    self = [super init];
    if(self) {
        
        if([ConnectionChecker isServerActive])
        {
            NSString * urlString=[URLConstructor userDetailsURL];
            URLConnector *connector = [[URLConnector alloc] initFetcher:urlString];
            ZCUserParser *parser = [[ZCUserParser alloc]initZCUserParser:[connector apiResponse] ];
            _userObject = [parser userObject];
            NSLog(@"_useer obj %@",[_userObject zuid]);
            [ZOHOCreator constructZOHOCreator:[ZOHOUser userObject]];
            NSLog(@"_useer obj %@",[[ZOHOCreator userObject]zuid]);

            NSString *filePath = [ArchiveUtil archiveFilePath:@"Login"];
            [EncodeObject encode:filePath :@"Login" :[ZOHOUser userObject]];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
        }
    }
    return self;
}
@end
