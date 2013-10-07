//
//  ZCGroups.h
//  ZohoCreator
//
//  Created by Solai Murugan on 13/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCGroup;

@interface ZCGroups : NSObject

@property (nonatomic,retain) NSMutableArray *zcGroups;
-(ZCGroups *) initWithZCGroups;
-(void) addZCGroup:(ZCGroup *) zcGroup;

@end
