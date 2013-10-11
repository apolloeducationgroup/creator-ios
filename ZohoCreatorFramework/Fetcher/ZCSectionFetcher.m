//
//  ZCSectionFetcher.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 05/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCSectionFetcher.h"

@interface ZCSectionFetcher (hidden)

- (ZCSections*) fetchFromLocal;
- (ZCSections*) fetchFromServer;
- (void) encodeZCSection;

@end

@implementation ZCSectionFetcher

- (ZCSectionFetcher*) initSectionFetcher : (ZCApplication*) _localApplication {
    
    self= [super init];
    if(self) {
        self->_application = _localApplication;
        self->_appLinkName = [_localApplication appLinkName];
        self->_appowner = [_localApplication appOwner];
        if([ConnectionChecker isServerActive]) {
            self->_zcSections = [self fetchFromServer];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
        }
    }
    return self;
}

- (ZCSectionFetcher*) initSectionFetcher : (NSString*) appLinkName appOwner:(NSString *) appOwner{
    
    //// //NSLog(@"%@",[NSThread callStackSymbols]);
    self = [super init];
    if(self) {
        self->_appLinkName = appLinkName;
        self->_sectionName = NULL;
        self->_appowner = appOwner;
        if([ConnectionChecker isServerActive]) {
            self->_zcSections = [self fetchFromServer];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
        }
    }
    return self;
}

- (ZCSectionFetcher*) initSectionFetcher : (NSString*) appLinkName sectionName: (NSString*) sectionName appOwner:(NSString *) appOwner{
    
    self = [super init];
    if(self) {
        self->_appLinkName = appLinkName;
        self->_sectionName = sectionName;
        self->_appowner = appOwner;
        
        if([ConnectionChecker isServerActive]) {
            
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
            
            
        }
    }
    return self;
}

@end


@implementation ZCSectionFetcher (hidden)

- (ZCSections*) fetchFromLocal {
    
    if(_sectionName == NULL)
    {
        NSString *appPath = [ArchiveUtil applicationPath:_appLinkName];
        ZCSections *sections =  [DecodeObject decode:appPath : @"Sections"];
        return sections;
    }
    else
    {
        NSString *appPath = [ArchiveUtil applicationPath:_appLinkName];
        ZCSections *sections =  [DecodeObject decode:appPath : _sectionName];
        return sections;
    }
}

- (ZCSections*) fetchFromServer {
    
    if(_application == nil) {
        _application = [[ZOHOCreator getObject] getApplication:_appLinkName];
    }
    if(_sectionName == NULL)
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        NSString *sectionURL = [URLConstructor sectionMetaURL:_appLinkName appOwner:_appowner];
        //NSLog(@"Section URL %@",sectionURL);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        URLConnector *connection = [[URLConnector alloc] initFetcher:sectionURL];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSString *sectionXML = [connection apiResponse];
        NSLog(@"Section XML %@",sectionXML);
        @try {
            
            ZCSectionParser *parser = [[ZCSectionParser alloc] initZCSectionParser:sectionXML:_application];
            return [parser zcSections];
        }
        @catch (NSException *exception) {
            //// //NSLog(@"Exception %@",exception);
            return nil;
        }
        @finally {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
        
    }
    else
    {
        NSString *sectionURL = [URLConstructor sectionMetaURL:_appLinkName:_sectionName appOwner:_appowner];
        URLConnector *connection = [[URLConnector alloc] initFetcher:sectionURL];
        NSString *sectionXML = [connection apiResponse];
        ZCSectionParser *parser = [[ZCSectionParser alloc] initZCSectionParser:sectionXML:_application];
        return [parser zcSections];
    }
}

- (void) encodeZCSection {
    
    if (_sectionName== NULL) {
        [EncodeObject encode:[ArchiveUtil applicationPath:_appLinkName] :@"Sections" : _zcSections];
    }
    else {
        [EncodeObject encode:[ArchiveUtil applicationPath:_appLinkName] :_sectionName : _zcSection];
    }
}

@end
