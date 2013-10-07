//
//  ZCAllAppsCategory.h
//  ZohoCreator
//
//  Created by Solai Murugan on 30/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCPersonalGroup.h"
#import "ZCWorkSpace.h"

@interface ZCAllAppsCategory : NSObject

@property (nonatomic,retain) NSMutableArray *personalGroupList;
@property (nonatomic,retain) NSMutableArray *workspaceList;

- (ZCAllAppsCategory *) initZCAllAppsCategory;
-(void)addPersonalGroup : (ZCPersonalGroup *) group;
-(void)addWorkSpace : (ZCWorkSpace *) workspace;

@end
