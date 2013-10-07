//
//  ScriptParser.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelugeTasks.h"
#import "DelugeTask.h"
#import "AlertTask.h"
#import "EnableTask.h"
#import "DisableTask.h"
#import "ShowTask.h"
#import "HideTask.h"
#import "ClearTask.h"
#import "OpenUrlTask.h"
#import "SetVariableTask.h"
#import "AddValueTask.h"
#import "ReloadFormTask.h"
#import "SelectAllTask.h"
#import "SelectValueTask.h"
#import "DeSelectAll.h"
#import "DeSelectValueTask.h"

enum TASK_TYPE {
    ALERT_TASK=1,
    ENABLE_TASK=2,
    DISABLE_TASK=3,
    HIDE_TASK=4,
    SHOW_TASK=5,
    CLEAR_TASK=6,
    SETVARIABLE_TASK=7,
    ADDVALUE_TASK=8,
    OPENURL_TASK=9,
    RELOADFORM_TASK=9,
    SELECTVALUE_TASK=10,
    SELECTALL_TASK=11,
    DESELECTVALUE_TASK=12,
    DESELECTALL_TASK = 13,
};

@interface ScriptParser : NSObject <NSXMLParserDelegate> {
    
@private NSXMLParser *_xmlParser;
@private NSString *_xmlString;
@private NSString *_currentElementValue;
@private NSString *_currentElementName;
@private NSInteger _baseElement;
@private id delugeTask;
@private NSInteger taskType;
@private BOOL _noScriptError;
}

@property (nonatomic,retain) DelugeTasks *delugeTasks;

- (ScriptParser*) initScriptParser : (NSString*) xmlString;

@end