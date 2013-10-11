//
//  ZCUserDetailsFetcher.h
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 28/08/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZOHOUser.h"

@interface ZCUserDetailsFetcher : NSObject
@property (nonatomic,retain) ZOHOUser *userObject;
- (ZCUserDetailsFetcher*) initUserDetailFetcher;
@end
