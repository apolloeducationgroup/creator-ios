//
//  ZCSharedAppListFetcher.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 18/01/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchiveUtil.h"
#import "ConnectionChecker.h"
#import "URLConstructor.h"
#import "URLConnector.h"
#import "ZCApplicationParser.h"
#import "ZCApplicationList.h"
#import "EncodeObject.h"
#import "DecodeObject.h"
#import "ZCApplicationList.h"

@interface ZCSharedAppListFetcher : NSObject

@property (nonatomic,retain) ZCApplicationList *applicationList;

- (ZCSharedAppListFetcher*) initSharedAppListFetcher;
- (ZCSharedAppListFetcher*) initSharedAppListFetcherForGroup : (NSString *) groupId;

@end


