//
//  ZCGroups.m
//  ZohoCreator
//
//  Created by Solai Murugan on 13/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCGroups.h"

@implementation ZCGroups

@synthesize zcGroups=_zcGroups;

-(ZCGroups *) initWithZCGroups
{
    self = [super init];
    if (self) {
        _zcGroups = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addZCGroup:(ZCGroup *) zcGroup
{
    [_zcGroups addObject:zcGroup];
}

@end
