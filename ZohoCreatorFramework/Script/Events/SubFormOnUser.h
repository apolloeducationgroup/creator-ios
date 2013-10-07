//
//  SubFormOnUser.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 07/03/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "DelugeEvent.h"

@interface SubFormOnUser : DelugeEvent

- (SubFormOnUser*) initSubFormOnUser : (NSString*) _appLocal : (NSString*) _formLocal : (NSString*) _fieldLocal : (NSString*) refAppName : (NSString*) refFormName : (NSString*) refFieldName : (NSString*) paramString : (NSString*) appOwner : (id) delegate;
- (DelugeTasks*) execute;

@end
