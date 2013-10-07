//
//  FieldOnUser.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelugeEvent.h"
#import "DelugeTasks.h"

@class ZCField;

@interface FieldOnUser : DelugeEvent {
    
@private NSString *onUserURL;
    
    
}

- (FieldOnUser*) initFieldOnUser :  (NSString*) application : (NSString*) form : (NSString*) field : (NSString*) paramString : (id) delegate;
- (DelugeTasks*) execute;

@end
