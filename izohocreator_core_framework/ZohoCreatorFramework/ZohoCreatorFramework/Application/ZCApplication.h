//
//  ZCApplication.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCFormFetcher.h"
#import "ZCViewFetcher.h"
#import "ZCSectionFetcher.h"

@class ZCSections,ZCSection,ZCView,ZCForm,ZCComponent,ZCViewParam;

@interface ZCApplication : NSObject <NSCoding,NSCopying>  {
    
@private ZCSections *_sections;
@private NSMutableDictionary *_formDictionary;
@private NSMutableDictionary *_viewDictionary;
}

@property (nonatomic,retain) NSString *appLinkName;
@property (nonatomic,retain) NSString *appDisplayName;
@property (nonatomic,retain) NSString *createdOn;
@property (nonatomic,retain) NSString *accessType;
@property(nonatomic,retain) NSString *appOwner;
@property(nonatomic,assign) NSInteger appLayout;
@property(nonatomic,assign) BOOL isZAppBox;

- (ZCSections*) getSections;
- (ZCSections*) getSections : (BOOL) fromServer;
- (ZCForm*) getForm : (NSString*) formLinkName;
- (ZCForm*) getForm : (NSString*) formLinkName fromServer : (BOOL) fromServer;
- (ZCView*) getView : (NSString*) viewLinkName;
- (ZCView*) getView : (NSString*) viewLinkName fromServer : (BOOL) fromServer;
- (ZCComponent*) getComponent : (NSString*) componentLinkName;
- (ZCView*) getView : (NSString*) viewLinkName withParameter : (ZCViewParam*) viewParam;
- (ZCComponent*) createComponent : (NSString*) componentLinkName;

@end
