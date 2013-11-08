//
//  FieldOnUser.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "FieldOnUser.h"

@implementation FieldOnUser
- (FieldOnUser*) initFieldOnUser :  (NSString*) _appLocal formname: (NSString*) _formLocal fieldname: (NSString*) _fieldLocal paramstring: (NSString*) paramString delegate: (id) delegate appowner: (NSString*) appOwner
{

    self = [super init];
    if(self) {
        [super setCallerDelegate:delegate];
        [super setDelugeParams:[URLConstructor fieldOnUserWithJSON:_appLocal :_formLocal :_fieldLocal :paramString :appOwner]];
        [super setDelugeURL:[URLConstructor delugeURL]];
    }
    return self;
}

- (DelugeTasks*) execute {
    NSLog(@"fieldonuser");
    return [super execute];
}



@end
