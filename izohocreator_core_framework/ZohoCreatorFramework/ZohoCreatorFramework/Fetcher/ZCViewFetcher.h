//
//  ZCViewFetcher.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewRecordParser.h"

@class ZCViewParam;

@interface ZCViewFetcher : NSObject  {
    
    NSString *_appLinkName;
    NSString *_appOwner;
    ZCComponent *_component;
@private ZCViewParam *_zcViewParam;
}

@property (nonatomic,retain) ZCView *zcView;

- (ZCViewFetcher*) initViewFetcher : (NSString*) appLinkName : (ZCComponent*) component appOwner: (NSString *) appOwner;
- (ZCViewFetcher*) initViewFetcher : (NSString*) appLinkName : (ZCComponent*) component withParam : (ZCViewParam*) viewParameter appOwner: (NSString *) appOwner;
+ (ZCViewFetcher*) initViewFetcher : (NSString*) appLinkName : (NSString*) formLinkName appOwner: (NSString *) appOwner;
+ (ZCViewFetcher*) initViewFetcher : (NSString*) appLinkName : (NSString*) formLinkName withParam : (ZCViewParam*) viewParam appOwner: (NSString *) appOwner;

@end
