//
//  ZCRecordCountFetcher.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 31/01/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCRecordCountFetcher.h"


@interface ZCRecordCountFetcher(hidden)

- (NSInteger) fetchFromServer;
- (NSInteger) fetchFromLocal;

@end


@implementation ZCRecordCountFetcher

@synthesize recordCount=_recordCount;

+  (ZCRecordCountFetcher*) initRecordCountFetcher : (NSString*) appLinkName withViewLinkName : (NSString*) viewLinkName viewParams : (ZCViewParam*) viewParams appOwner : (NSString *) appOwner {
    
    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:viewLinkName];
    [_comp setDisplayName:viewLinkName];
    [_comp setType:2];
    ZCRecordCountFetcher *fetcher = [[ZCRecordCountFetcher alloc] initRecordCountFetcher:appLinkName withViewComponent :_comp viewParams : viewParams appOwner:appOwner];
    return fetcher;
}

- (ZCRecordCountFetcher*) initRecordCountFetcher : (NSString*) appLinkName withViewComponent :(ZCComponent *) component viewParams : (ZCViewParam*) viewParams  appOwner : (NSString *) appOwner  {
    
    self = [super init];
    if(self) {
        
        self->_appLinkName = appLinkName;
        self->_component = component;
        self->_appOwner = appOwner;
        self->_viewParam = viewParams;
        if([ConnectionChecker isServerActive]) {
            
            self->_recordCount = [self fetchFromServer];
            
        }
        else
        {
            self->_recordCount = [self fetchFromLocal];
        }
    }
    return self;
}

@end

@implementation ZCRecordCountFetcher(hidden)

- (NSInteger) fetchFromLocal {
    
    return 10;
}


- (NSInteger) fetchFromServer {
    
    NSString *formMetaURL = [URLConstructor recordCountURL:_appLinkName :[_component linkName] withParam : _viewParam appOwner:_appOwner];
    //     //NSLog(@"form Meta URL %@",formMetaURL);
    URLConnector *connector = [[URLConnector alloc] initFetcher:formMetaURL];
    ViewRecordCountParser *parser =  [[ViewRecordCountParser alloc] initViewRecordCountParser:[connector apiResponse]];
    return [parser recordCount];
}

@end
