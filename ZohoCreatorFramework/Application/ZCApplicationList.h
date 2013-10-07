//
//  ZCApplicationList.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 09/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCApplication.h"

@class ZCApplication;

@interface ZCApplicationList : NSObject <NSCoding>

@property (nonatomic,retain) NSMutableArray *applicationList;
@property (nonatomic,retain) NSMutableArray *appOwnersList;

- (void) addZCApplication : (ZCApplication*) application;
- (void) addZCApplicationOwner:(NSString *)appOwner;
- (ZCApplicationList*) initZCApplicationList;
- (ZCApplicationList *) getZCApplications:(NSString *) ownerName;
- (ZCApplication *) getZCApplication:(NSString *) ownerName ApplicationName:(NSString *)appName;
- (ZCApplication*) getZCApplicationByName : (NSString*) appName;

@end
