//
//  ZCAllAppsCategory.m
//  ZohoCreator
//
//  Created by Solai Murugan on 30/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCAllAppsCategory.h"

@implementation ZCAllAppsCategory

@synthesize personalGroupList=_personalGroupList, workspaceList=_workspaceList;


- (ZCAllAppsCategory *) initZCAllAppsCategory
{
    self = [super init];
    if(self)
    {
        self->_personalGroupList = [[NSMutableArray alloc] init];
        self->_workspaceList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addPersonalGroup : (ZCPersonalGroup *) group
{
    [self->_personalGroupList addObject:group];
}

-(void)addWorkSpace : (ZCWorkSpace *) workspace
{
    [self->_workspaceList addObject:workspace];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self->_personalGroupList=[aDecoder decodeObjectForKey:@"personalGroupList"];
    self->_workspaceList=[aDecoder decodeObjectForKey:@"workspaceList"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_personalGroupList forKey:@"personalGroupList"];
    [aCoder encodeObject:_workspaceList forKey:@"workspaceList"];
}


@end
