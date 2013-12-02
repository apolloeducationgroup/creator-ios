//
//  ScriptJSONParser.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 28/06/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelugeTasks.h"
#import "AlertTask.h"
#import "SetVariableTask.h"
#import "EnableTask.h"
#import "DisableTask.h"
#import "HideTask.h"
#import "ShowTask.h"
#import "ClearTask.h"
#import "ReloadFormTask.h"
#import "AddValueTask.h"
#import "SelectAllTask.h"
#import "DeSelectAll.h"
#import "SelectValueTask.h"
#import "DeSelectValueTask.h"
#import "OpenUrlTask.h"
#import "InfoTask.h"

@interface ScriptJSONParser : NSObject {
    
@private NSString *_jsonString;
}

@property (nonatomic,retain) DelugeTasks *delugeTasks;

- (ScriptJSONParser*) initScriptJSONParser : (NSString*) _localString;

@end
