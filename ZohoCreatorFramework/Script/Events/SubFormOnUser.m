//
//  SubFormOnUser.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 07/03/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "SubFormOnUser.h"

@implementation SubFormOnUser

- (SubFormOnUser*) initSubFormOnUser : (NSString*) _appLocal : (NSString*) _formLocal : (NSString*) _fieldLocal : (NSString*) refAppName : (NSString*) refFormName : (NSString*) refFieldName : (NSString*) paramString : (NSString*) appOwner : (id) delegate {
    
    self = [super init];
    if(self) {
        [super setCallerDelegate:delegate];
        [super setDelugeURL:[URLConstructor subFormOnuser:_appLocal :_formLocal :_fieldLocal :refAppName :refFormName :refFieldName :paramString :appOwner]];
    }
    return self;
}

- (DelugeTasks*) execute {
    
    return [super execute];
}


@end
