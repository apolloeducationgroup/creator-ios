//
//  ZCPersonalGroup.m
//  ZohoCreator
//
//  Created by Solai Murugan on 30/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCPersonalGroup.h"

@implementation ZCPersonalGroup

@synthesize groupName=_groupName, groupID=_groupID;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self->_groupName=[aDecoder decodeObjectForKey:@"groupName"];
    self->_groupID=[aDecoder decodeObjectForKey:@"groupID"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_groupName forKey:@"groupName"];
    [aCoder encodeObject:_groupID forKey:@"groupID"];
}

@end
