//
//  ZCApplicationList.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 09/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCApplicationList.h"

@implementation ZCApplicationList


- (ZCApplicationList*) initZCApplicationList  {
    
    self = [super init];
    if(self) {
        self->_applicationList = [[NSMutableArray alloc] init];
        self->_appOwnersList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addZCApplication:(ZCApplication *)application  {
    
    [self->_applicationList addObject:application];
}

- (void) addZCApplicationOwner:(NSString *)appOwner  {
    
    [self->_appOwnersList addObject:appOwner];
}

- (ZCApplication*) getZCApplicationByName : (NSString*) appName {
    
    for (int i=0; i<self->_applicationList.count; i++) {
        ZCApplication *app = [self ->_applicationList objectAtIndex:i];
        if ([app.appLinkName isEqualToString:appName]) {
            return app;
        }
    }
    return nil;
}

- (ZCApplicationList *) getZCApplications:(NSString *) ownerName
{
    ZCApplicationList *appListforOwner = [[ZCApplicationList alloc] initZCApplicationList];
    for (int i=0; i<self->_applicationList.count; i++) {
        ZCApplication *app = [self ->_applicationList objectAtIndex:i];
        if ([app.appOwner isEqualToString:ownerName]) {
            [appListforOwner addZCApplication:app];
        }
    }
    return appListforOwner;
}


- (ZCApplication *) getZCApplication:(NSString *) ownerName ApplicationName:(NSString *)appName
{
    for (int i=0; i<self->_applicationList.count; i++) {
        ZCApplication *app = [self ->_applicationList objectAtIndex:i];
        if ([app.appOwner isEqualToString:ownerName] && [app.appLinkName isEqualToString:appName]) {
            return app;
        }
    }
    return nil;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self->_applicationList=[aDecoder decodeObjectForKey:@"applicationList"];
    self->_appOwnersList=[aDecoder decodeObjectForKey:@"appOwnersList"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_appOwnersList forKey:@"appOwnersList"];
    [aCoder encodeObject:_applicationList forKey:@"applicationList"];
}

@end
