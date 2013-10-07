//
//  SubFormDeleteEvent.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 23/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "DelugeEvent.h"

@interface SubFormDeleteEvent : DelugeEvent

- (SubFormDeleteEvent*) initSubFormDeleteEvent:(NSString *) applicationName :(NSString *) formName : (NSString*) fieldName : (NSString*) paramString : (id) delegate;
- (DelugeTasks*) execute;

@end
