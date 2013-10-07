//
//  ZCComponent.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 17/09/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCApplication;
@class ZOHOCreator;

@interface ZCComponent : NSObject <NSCoding>

@property (nonatomic,retain,getter = zcApplication) ZCApplication *zcApplication;
@property (nonatomic,retain) NSString* linkName;
@property (nonatomic,retain) NSString* displayName;
@property NSInteger type;

+ (NSInteger) COMPONENT_HTML;
+ (NSInteger) COMPONENT_FORM;
+ (NSInteger) COMPONENT_VIEW;
+ (NSInteger) COMPONENT_CALENDAR;
- (void) setDisplayName:(NSString *)displayName;

@end