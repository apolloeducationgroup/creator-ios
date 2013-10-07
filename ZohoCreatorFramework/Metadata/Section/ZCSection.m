//
//  ZCSection.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 14/09/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCSection.h"

@implementation ZCSection

@synthesize sectionDisplayName=_sectionDisplayName,sectionID=_sectionID,sectionLinkName=_sectionLinkName,sequenceNumber=_sequenceNumber,modifiedTime=_modifiedTime,isHidden=_isHidden;
@synthesize componentList=_componentList;

- (ZCSection*) initZCSection  {
    
    self = [super init];
    if(self)  {
        
        self->_componentList= [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addZCComponent : (ZCComponent*) component {
    
    [_componentList addObject:component];
}


- (id) copy {
    
    ZCSection *_copySection = [[ZCSection alloc] initZCSection];
    [_copySection setSectionDisplayName:_sectionDisplayName];
    [_copySection setSectionID:_sectionID];
    [_copySection setSectionLinkName:_sectionLinkName];
    [_copySection setSequenceNumber:_sequenceNumber];
    [_copySection setModifiedTime:_modifiedTime];
    [_copySection setIsHidden:_isHidden];
    [_copySection setComponentList:_componentList];
    return _copySection;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self->_sectionDisplayName=[aDecoder decodeObjectForKey:@"sectionDisplayName"];
    self->_sectionLinkName=[aDecoder decodeObjectForKey:@"sectionLinkName"];
    self->_sequenceNumber= [aDecoder decodeIntegerForKey:@"sequenceNumber"];
    self->_modifiedTime=[aDecoder decodeObjectForKey:@"modifiedTime"];
    self->_sectionID=[aDecoder decodeObjectForKey:@"sectionID"];
    self->_isHidden=[aDecoder decodeBoolForKey:@"isHidden"];
    self->_componentList=[aDecoder decodeObjectForKey:@"componentList"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_sectionDisplayName forKey:@"sectionDisplayName"];
    [aCoder encodeObject:_sectionLinkName forKey:@"sectionLinkName"];
    [aCoder encodeObject:_modifiedTime forKey:@"modifiedTime"];
    [aCoder encodeObject:_sectionID forKey:@"sectionID"];
    [aCoder encodeInteger:_sequenceNumber forKey:@"sequenceNumber"];
    [aCoder encodeBool:_isHidden forKey:@"isHidden"];
    [aCoder encodeObject:_componentList forKey:@"componentList"];
}

@end
