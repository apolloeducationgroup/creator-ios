//
//  FieldOnUser.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "FieldOnUser.h"

@implementation FieldOnUser

- (FieldOnUser*) initFieldOnUser : (NSString*) _appLocal : (NSString*) _formLocal : (NSString*) _fieldLocal : (NSString*) paramString : (id) delegate {
    self = [super init];
    if(self) {
        [super setCallerDelegate:delegate];
        [super setDelugeURL:[URLConstructor fieldOnUser:_appLocal :_formLocal:_fieldLocal:paramString]];
        //// //NSLog(@"On User URL %@",[super delugeURL]);
        //// //NSLog(@"deluge initiated...with app : %@, form : %@, field : %@, param : %@ delegate class : %@",_appLocal,_formLocal,_fieldLocal,paramString,[delegate class]);
    }
    return self;
}

- (DelugeTasks*) execute {
    
    return [super execute];
}



@end
