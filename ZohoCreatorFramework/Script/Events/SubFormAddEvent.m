//
//  SubFormAddEvent.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 23/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "SubFormAddEvent.h"

@implementation SubFormAddEvent

- (SubFormAddEvent*) initSubFormAddEvent:(NSString *) applicationName :(NSString *) formName : (NSString*) fieldName : (NSString*) paramString : (id) delegate {
    
    self = [super init];
    if(self) {
        [super setDelugeURL:[URLConstructor subFormAddRow:applicationName:formName:fieldName:paramString]];
        [super setCallerDelegate:delegate];
        ////// ////NSLog@"Sub Form Add Deluge URL %@",[super delugeURL]);
    }
    return self;
}

- (DelugeTasks*) execute {
    
    return [super execute];
}

@end
