//
//  ZCAppsCategoryListFetcher.h
//  ZohoCreator
//
//  Created by Solai Murugan on 30/04/13.
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
#import "ZCAllAppsCategory.h"
#import "ZCAppsCategoryParser.h"

@interface ZCAppsCategoryListFetcher : NSObject

@property (nonatomic,retain) ZCAllAppsCategory *allAppsCategoryList;

- (ZCAppsCategoryListFetcher*) initZCAppsCategoryListFetcher;

@end
