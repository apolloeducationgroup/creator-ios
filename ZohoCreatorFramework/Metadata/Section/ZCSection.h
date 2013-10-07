//
//  ZCSection.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 14/09/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCComponent.h"

@class ZCComponent;
@interface ZCSection : NSObject <NSCoding>

@property (nonatomic,retain) NSString *sectionLinkName;
@property (nonatomic,retain) NSString *sectionDisplayName;
@property (nonatomic,retain) NSString *sectionID;
@property (nonatomic,retain) NSString *modifiedTime;
@property (nonatomic,retain) NSMutableArray *componentList;
@property BOOL isHidden;
@property  NSInteger sequenceNumber;

- (ZCSection*) initZCSection;
- (void) addZCComponent : (ZCComponent*) component;
- (id) copy;

@end