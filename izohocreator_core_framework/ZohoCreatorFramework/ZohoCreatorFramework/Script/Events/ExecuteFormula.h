//
//  ExecuteFormula.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 20/08/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelugeEvent.h"
#import "DelugeTasks.h"

@class ZCField;

@interface ExecuteFormula : DelugeEvent {
    
@private NSString *onUserURL;
    
}

- (ExecuteFormula*) initExecuteFormula :  (NSString*) application : (NSString*) form : (NSString*) field : (NSString*) paramString : (id) delegate;
- (DelugeTasks*) execute;

@end
