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

- (FieldOnUser*) initFieldOnUser :  (NSString*) application formname: (NSString*) form fieldname: (NSString*) field paramstring: (NSString*) paramString delegate: (id) delegate appowner: (NSString*) appOwner;
- (DelugeTasks*) execute;

@end
