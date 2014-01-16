//
//  ZCSectionFetcher.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 05/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCHTMLViewFetcher.h"
#import "ZCEncodeUtil.h"
@interface ZCHTMLViewFetcher (hidden)

- (ZCHTMLView*) fetchFromLocal;
- (ZCHTMLView*) fetchFromServer;

@end

@implementation ZCHTMLViewFetcher

@synthesize zcHtmlView=_zcHtmlView;

- (ZCHTMLViewFetcher*) initHTMLViewFetcher : (NSString*) appLinkName htmlViewLinkName : (NSString*) viewLinkName appOwner:(NSString *) appOwner urlParam:(NSString *)urlParam
{

    self = [super init];
    if(self) {
        
        self->_appLinkName = appLinkName;
        self->_appOwner = appOwner;
        self->_componentName = viewLinkName;
        self->_urlparameters=urlParam;
        self->_zcHtmlView = [self fetchFromServer];

    }
    return self;
}

@end

@implementation ZCHTMLViewFetcher (hidden)

- (ZCHTMLView*) fetchFromLocal {
    
    return nil;
}

- (ZCHTMLView*) fetchFromServer {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *htmlViewURL = [URLConstructor htmlView:self->_appLinkName htmlViewLinkName:self->_componentName applicationOwner:self->_appOwner];
    if (_urlparameters.length) {
        
        htmlViewURL =[htmlViewURL stringByAppendingFormat:@"&%@",[ZCEncodeUtil encodeStringUsingUT8:_urlparameters]];
    }
    URLConnector *connection = [[URLConnector alloc] initFetcher:htmlViewURL];
    NSString *rawHTML = [connection apiResponse];
    ZCHTMLView *htmlView = [[ZCHTMLView alloc] init];
    [htmlView setHtmlContent:rawHTML];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //// ////NSLog@"raw html %@",rawHTML);
    return htmlView;
}

@end
