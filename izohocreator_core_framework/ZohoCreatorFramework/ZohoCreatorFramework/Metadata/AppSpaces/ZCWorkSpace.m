//
//  ZCWorkSpace.m
//  ZohoCreator
//
//  Created by Solai Murugan on 30/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCWorkSpace.h"

@implementation ZCWorkSpace

@synthesize workspaceowner=_workspaceowner;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self->_workspaceowner=[aDecoder decodeObjectForKey:@"workspaceowner"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_workspaceowner forKey:@"workspaceowner"];
}

@end
