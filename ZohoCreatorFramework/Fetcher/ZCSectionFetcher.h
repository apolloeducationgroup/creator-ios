//
//  ZCSectionFetcher.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 05/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCSection.h"
#import "ZCSections.h"
#import "ConnectionChecker.h"
#import "URLConstructor.h"
#import "URLConnector.h"
#import "FormParser.h"
#import "ZCComponent.h"
#import "ArchiveUtil.h"
#import "EncodeObject.h"
#import "DecodeObject.h"
#import "ZCSectionParser.h"
#import "ZOHOCreator.h"

@interface ZCSectionFetcher : NSObject {
    
@private
    NSString *_appLinkName;
    NSString *_sectionName;
    NSString *_appowner;
    ZCApplication *_application;
}

@property (nonatomic,retain) ZCSection *zcSection;
@property (nonatomic,retain) ZCSections *zcSections;

- (ZCSectionFetcher*) initSectionFetcher : (ZCApplication*) _localApplication;
- (ZCSectionFetcher*) initSectionFetcher : (NSString*) appLinkName appOwner:(NSString *) appOwner;
- (ZCSectionFetcher*) initSectionFetcher : (NSString*) appLinkName sectionName: (NSString*) sectionName appOwner:(NSString *) appOwner;

@end
