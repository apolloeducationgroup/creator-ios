//
//  FieldOnUser.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "FieldOnUser.h"

@implementation FieldOnUser

- (FieldOnUser*) initFieldOnUser : (NSString*) _appLocal : (NSString*) _formLocal : (NSString*) _fieldLocal : (NSString*) paramString : (id) delegate : (NSString*) appOwner {
    self = [super init];
    if(self) {
        [super setCallerDelegate:delegate];
        [super setDelugeParams:[URLConstructor fieldOnUserWithJSON:_appLocal :_formLocal :_fieldLocal :paramString :appOwner]];
        [super setDelugeURL:[URLConstructor delugeURL]];
    }
    return self;
}

- (DelugeTasks*) execute {
    
    return [super execute];
}



@end
