//
//  ZCWorkSpaceAppListFetcher.h
//  ZohoCreator
//
//  Created by Solai Murugan on 19/03/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCApplicationList.h"

@interface ZCWorkSpaceAppListFetcher : NSObject

@property (nonatomic,retain) ZCApplicationList *applicationList;

- (ZCWorkSpaceAppListFetcher*) initWorkSpaceAppListFetcher:(NSString *)workspaceowner;

@end
