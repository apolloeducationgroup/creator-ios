//
//  SubFormDeleteEvent.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 23/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "SubFormDeleteEvent.h"

@implementation SubFormDeleteEvent

- (SubFormDeleteEvent*) initSubFormDeleteEvent:(NSString *) applicationName :(NSString *) formName : (NSString*) fieldName : (NSString*) paramString : (id) delegate {
    
    self = [super init];
    if(self) {
        
        
        
        //NSLog(@"ondelete parm stirng riyaz %@",paramString);
        
        [super setDelugeURL:[URLConstructor subFormDeleteRow:applicationName:formName:fieldName:paramString]];
        [super setCallerDelegate:delegate];
    }
    return self;
}

- (DelugeTasks*) execute {
    
    return [super execute];
}


@end
