//
//  DelugeTasks.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "DelugeTasks.h"

@implementation DelugeTasks

@synthesize taskList=_taskList,noScript=_noScript,noScriptMessage=_noScriptMessage;

- (DelugeTasks*) initDelugeTasks {
    
    self = [super init];
    if(self) {
        self->_taskList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addTaskList:(id) task {
    NSLog(@"tasklist %@",_taskList);
    [_taskList addObject:task];
    NSLog(@"tasklist %@",_taskList);
}

@end
