//
//  ZCFormFetcher.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 03/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//


#import "ZCViewFetcher.h"

@interface ZCViewFetcher(hidden)

- (ZCView*) fetchFromServer;
- (ZCView*) fetchFromLocal;
- (void) encodeZCView;

@end

@implementation ZCViewFetcher

@synthesize zcView=_zcView;

+ (ZCViewFetcher*) initViewFetcher : (NSString*) appLinkName : (NSString*) formLinkName appOwner: (NSString *) appOwner {
    
    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:formLinkName];
    [_comp setDisplayName:formLinkName];
    [_comp setType:1];
    ZCViewFetcher *fetcher = [[ZCViewFetcher alloc] initViewFetcher:appLinkName :_comp appOwner:appOwner];
    return fetcher;
}

+ (ZCViewFetcher*) initViewFetcher : (NSString*) appLinkName : (NSString*) formLinkName withParam : (ZCViewParam*) viewParameter appOwner: (NSString *) appOwner {
    
    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:formLinkName];
    [_comp setDisplayName:formLinkName];
    [_comp setType:1];
    ZCViewFetcher *fetcher = [[ZCViewFetcher alloc] initViewFetcher:appLinkName :_comp withParam:viewParameter appOwner:appOwner];
    return fetcher;
}

- (ZCViewFetcher*) initViewFetcher : (NSString*) appLinkName : (ZCComponent*) component appOwner: (NSString *) appOwner  {
    
    self = [super init];
    if(self) {
        ////// //NSLog(@"Coming to initViewFetcher");
        self->_appLinkName = appLinkName;
        self->_component = component;
        self->_zcViewParam = nil;
        self->_appOwner = appOwner;
        
        if([ConnectionChecker isServerActive]) {
            
            self->_zcView = [self fetchFromServer];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
            
            // self->_zcView = [self fetchFromLocal];
        }
        ZOHOCreator *creator = [ZOHOCreator getObject];
        [self->_zcView setApplication:[creator getApplication:appLinkName]];
    }
    return self;
}

- (ZCViewFetcher*) initViewFetcher : (NSString*) appLinkName : (ZCComponent*) component withParam : (ZCViewParam*) viewParameter appOwner: (NSString *) appOwner {
    
    self = [super init];
    if(self) {
        
        // //NSLog(@"init view fetcher : %@ : %@ : %@ :%@",appLinkName,[component displayName],[viewParameter getCalendarCriteria],appOwner);
        self->_appLinkName = appLinkName;
        self->_component = component;
        self->_zcViewParam = viewParameter;
        self->_appOwner = appOwner;
        
        if([ConnectionChecker isServerActive]) {
            self->_zcView = [self fetchFromServer];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
        }
        ZOHOCreator *creator = [ZOHOCreator getObject];
        [self->_zcView setApplication:[creator getApplication:appLinkName]];
    }
    return self;
}

@end

@implementation ZCViewFetcher(hidden)

- (void) encodeZCView {
    
    [EncodeObject encode:[ArchiveUtil applicationPath:_appLinkName] :[_component linkName] :_zcView];
}

- (ZCView*) fetchFromLocal {
    
    NSString *appPath = [ArchiveUtil applicationPath:_appLinkName];
    ZCView *view =  [DecodeObject decode:appPath :[_component linkName]];
    return view;
}

- (ZCView*) fetchFromServer {
    
    NSString *viewURL;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if(self->_zcViewParam==nil)
    {
        viewURL = [URLConstructor viewURL: _appLinkName :[_component linkName] appOwner:_appOwner];
    }
    else
    {
        viewURL = [URLConstructor viewURL: _appLinkName :[_component linkName] withParam : self->_zcViewParam appOwner:_appOwner];
    }
    
    // //NSLog(@"View URL %@",viewURL);
    
    URLConnector *connector = [[URLConnector alloc] initFetcher:viewURL];
    NSString *formMetaXML = [connector apiResponse];
    
    //NSLog(@"view Xml Meta %@",formMetaXML);
    
    ViewRecordParser *view = [[ViewRecordParser alloc] initViewRecordParser:formMetaXML :_component ];
    [[view zcView] setViewParam:_zcViewParam];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return [view zcView];
}

@end

