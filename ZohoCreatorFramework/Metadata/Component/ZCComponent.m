//
//  ZCComponent.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 17/09/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCComponent.h"

@implementation ZCComponent

@synthesize displayName=_displayName,linkName=_linkName,type=_type,zcApplication=_zcApplication;

- (ZCComponent*) initZCComponent  {
    
    self = [super init];
    if(self) {
        
    }
    return self;
}

+ (NSInteger) COMPONENT_CALENDAR  {
    return 4;
}

+ (NSInteger) COMPONENT_HTML {
    return 3;
}

+ (NSInteger) COMPONENT_FORM {
    return 1;
}

+ (NSInteger) COMPONENT_VIEW  {
    return 2;
}

-
(ZCApplication*) getZcApplication {
    
    if(_zcApplication == nil) {
        return nil;
    }
    else {
        return _zcApplication;
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self->_displayName=[aDecoder decodeObjectForKey:@"componentDisplayName"];
    self->_linkName=[aDecoder decodeObjectForKey:@"componentLinkName"];
    self->_type= [aDecoder decodeIntegerForKey:@"componentType"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_displayName forKey:@"componentDisplayName"];
    [aCoder encodeObject:_linkName forKey:@"componentLinkName"];
    [aCoder encodeInteger:_type forKey:@"componentType"];
}

@end