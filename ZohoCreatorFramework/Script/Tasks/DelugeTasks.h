//
//  DelugeTasks.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DelugeTasks : NSObject

@property (nonatomic,retain) NSMutableArray *taskList;
@property BOOL noScript;
@property (nonatomic,retain) NSString *noScriptMessage;

- (DelugeTasks*) initDelugeTasks;
- (void) addTaskList:(id) task;

@end
