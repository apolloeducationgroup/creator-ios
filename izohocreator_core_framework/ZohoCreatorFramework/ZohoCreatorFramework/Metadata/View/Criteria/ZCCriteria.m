//
//  ZCCriteria.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 23/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ZCCriteria.h"

@implementation ZCCriteria

@synthesize fieldName=_fieldName,fieldDisplayName=_fieldDisplayName,value=_value,operator=_operator;

- (id) init {
    
    self = [super init];
    if(self) {
        self->_value = nil;
    }
    return self;
}

@end
