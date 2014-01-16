//
//  ZCRecordCountFetcher.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 31/01/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionChecker.h"
#import "ZCForm.h"
#import "URLConstructor.h"
#import "URLConnector.h"
#import "ZCComponent.h"
#import "ArchiveUtil.h"
#import "EncodeObject.h"
#import "DecodeObject.h"
#import "ZOHOCreator.h"
#import "ViewRecordCountParser.h"


@interface ZCRecordCountFetcher : NSObject {
    
@private
    NSString *_appLinkName;
    NSString *_appOwner;
    ZCComponent *_component;
    ZCViewParam *_viewParam;
}

@property NSInteger recordCount;

//+ (ZCRecordCountFetcher*) initRecordCountFetcher : (NSString*) appLinkName withViewLinkName: (NSString*) viewLinkName viewParams : (ZCViewParam*) viewParams appOwner : (NSString *) appOwner;
//- (ZCRecordCountFetcher*) initRecordCountFetcher : (NSString*) appLinkName withViewComponent : (ZCComponent*) component viewParams : (ZCViewParam*) viewParams appOwner : (NSString *) appOwner;

@end
