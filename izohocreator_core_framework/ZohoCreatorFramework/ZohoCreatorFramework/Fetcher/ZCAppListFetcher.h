//
//  ZCAppListFetcher.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
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

@interface ZCAppListFetcher : NSObject

@property (nonatomic,retain) ZCApplicationList *applicationList;

- (ZCAppListFetcher*) initAppListFetcher;

@end
