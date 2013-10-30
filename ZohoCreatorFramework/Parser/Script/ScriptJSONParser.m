//
//  ScriptJSONParser.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 28/06/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ScriptJSONParser.h"

@interface ScriptJSONParser(private)

- (void) parseDelugeJSON;
- (AlertTask*) alertTask : (NSDictionary*) alertDic;
- (id) taskFinder : (NSDictionary*) taskDict;
- (SetVariableTask*) setVariableTask : (NSDictionary*) setVariableDic;
- (EnableTask*) enableTask : (NSDictionary*) enableDict;
- (DisableTask*) disableTask : (NSDictionary*) disableDict;
- (ShowTask*) showTask : (NSDictionary*) showDict;
- (HideTask*) hideTask : (NSDictionary*) hideDict;
- (ClearTask*) clearTask : (NSDictionary*) clearDict;
- (ReloadFormTask*) reloadFormTask : (NSDictionary*) reloadFormDict;
- (AddValueTask*) addValueTask : (NSDictionary*) addValueDict;
- (SelectAllTask*) selectAllTask : (NSDictionary*) selectAllDict;
- (DeSelectAll*) deSelectAllTask : (NSDictionary*) deSelectAllDict;
- (SelectValueTask*) selectValueTask : (NSDictionary*) selectValueDict;
- (DeSelectValueTask*) deSelectValueTask : (NSDictionary*) deSelectValueDict;
- (OpenUrlTask*) openUrlTask : (NSDictionary*) openUrlDict;

@end

@implementation ScriptJSONParser

@synthesize delugeTasks=_delugeTasks;

- (ScriptJSONParser*) initScriptJSONParser : (NSString*) _localString {
    
    self = [super init];
    if(self) {
        
        _jsonString = _localString;
        _delugeTasks = [[DelugeTasks alloc] initDelugeTasks];
        [self parseDelugeJSON];
    }
    return self;
}


@end

@implementation ScriptJSONParser(private)

- (void) parseDelugeJSON {
    
    NSData *jsonData = [_jsonString dataUsingEncoding:[NSString defaultCStringEncoding]];
    id _jsonDictionary= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if(_jsonDictionary != nil) {
        
        for(NSInteger index=0;index<[_jsonDictionary count];index++) {
            
            id delugeTask = [self taskFinder:[_jsonDictionary objectAtIndex:index]];
            [_delugeTasks addTaskList:delugeTask];
        }
    }
}


- (id) taskFinder : (NSDictionary*) taskDict {
    
    NSString *task = [taskDict objectForKey:@"task"];
    NSInteger taskNumber = [task integerValue];
    switch (taskNumber) {
        case 1302:
            return [self alertTask:taskDict];
        case 12:
            return [self setVariableTask:taskDict];
        case 14:
            return [self enableTask:taskDict];
        case 15:
            return [self disableTask:taskDict];
        case 10:
            return [self hideTask:taskDict];
        case 11:
            return [self showTask:taskDict];
        case 9:
            return [self clearTask:taskDict];
        case 1:
            return [self reloadFormTask:taskDict];
        case 1005:
            return [self addValueTask:taskDict];
        case 1003:
            return [self selectAllTask:taskDict];
        case 1004:
            return [self deSelectAllTask:taskDict];
        case 1001:
            return [self selectValueTask:taskDict];
        case 1002:
            return [self deSelectValueTask:taskDict];
        case 280:
            return [self openUrlTask:taskDict];
    }
    return nil;
}

- (AlertTask*) alertTask : (NSDictionary*) alertDic {
    
    AlertTask *alert = [[AlertTask alloc] init];
    [alert setMessage:[alertDic objectForKey:@"alertValue"]];
    return alert;
}

- (SetVariableTask*) setVariableTask : (NSDictionary*) setVariableDic {
    
    SetVariableTask *setVariable = [[SetVariableTask alloc] init];
    [setVariable setFieldName:[setVariableDic objectForKey:@"fieldName"]];
    [setVariable setFormName:[setVariableDic objectForKey:@"formName"]];
    id fieldValue = [setVariableDic objectForKey:@"fieldValue"];
    if(fieldValue != nil) {
            [setVariable setFieldValue:fieldValue];
    }
    return setVariable;
}

-
(EnableTask*) enableTask : (NSDictionary*) enableDict {
    
    EnableTask *_enableField = [[EnableTask alloc] init];
    [_enableField setFormName:[enableDict objectForKey:@"formName"]];
    [_enableField setFieldName:[enableDict objectForKey:@"fieldName"]];
    return _enableField;
}

- (DisableTask*) disableTask : (NSDictionary*) disableDict {
    
    DisableTask *_disableField = [[DisableTask alloc] init];
    [_disableField setFormName:[disableDict objectForKey:@"formName"]];
    [_disableField setFieldName:[disableDict objectForKey:@"fieldName"]];
    return _disableField;
}

- (ShowTask*) showTask : (NSDictionary*) showDict {
    
    ShowTask *_showTask = [[ShowTask alloc] init];
    [_showTask setFormName:[showDict objectForKey:@"formName"]];
    [_showTask setFieldName:[showDict objectForKey:@"fieldName"]];
    return _showTask;
    
}

- (HideTask*) hideTask : (NSDictionary*) hideDict {
    
    HideTask *_hideField = [[HideTask alloc] init];
    [_hideField setFormName:[hideDict objectForKey:@"formName"]];
    [_hideField setFieldName:[hideDict objectForKey:@"fieldName"]];
    return _hideField;
}

- (ClearTask*) clearTask : (NSDictionary*) clearDict {
    
    ClearTask *_clearField = [[ClearTask alloc] init];
    [_clearField setFormName:[clearDict objectForKey:@"formName"]];
    [_clearField setFieldName:[clearDict objectForKey:@"fieldName"]];
    return _clearField;
}

- (ReloadFormTask*) reloadFormTask : (NSDictionary*) reloadFormDict {
    
    ReloadFormTask *_reloadTask = [[ReloadFormTask alloc] init];
    [_reloadTask setFormName:[reloadFormDict objectForKey:@"formName"]];
    return _reloadTask;
}

- (AddValueTask*) addValueTask : (NSDictionary*) addValueDict {
    
    AddValueTask *_addValue = [[AddValueTask alloc] init];
    [_addValue setFormName:[addValueDict objectForKey:@"formName"]];
    [_addValue setFieldName:[addValueDict objectForKey:@"fieldName"]];
    NSMutableArray *_fieldValueList = [addValueDict objectForKey:@"fieldValue"];
    [_addValue setFieldValues:_fieldValueList];
    return _addValue;
}

- (SelectAllTask*) selectAllTask : (NSDictionary*) selectAllDict {
    
    SelectAllTask *_selectAll = [[SelectAllTask alloc] init];
    [_selectAll setFieldName:[selectAllDict objectForKey:@"fieldName"]];
    [_selectAll setFormName:[selectAllDict objectForKey:@"formName"]];
    return _selectAll;
}

- (DeSelectAll*) deSelectAllTask : (NSDictionary*) deSelectAllDict {
    
    DeSelectAll *_deSelectAll = [[DeSelectAll alloc] init];
    [_deSelectAll setFieldName:[deSelectAllDict objectForKey:@"fieldName"]];
    [_deSelectAll setFormName:[deSelectAllDict objectForKey:@"formName"]];
    return _deSelectAll;
}

- (SelectValueTask*) selectValueTask : (NSDictionary*) selectValueDict {
    
    SelectValueTask *_selectValue = [[SelectValueTask alloc] init];
    [_selectValue setFormName:[selectValueDict objectForKey:@"formName"]];
    [_selectValue setFieldName:[selectValueDict objectForKey:@"fieldName"]];
    NSMutableArray *_fieldValue = [selectValueDict objectForKey:@"fieldValue"];
    if(_fieldValue != nil) {
        [_selectValue setSelectValues:_fieldValue];
    }
    return _selectValue;
}


- (DeSelectValueTask*) deSelectValueTask : (NSDictionary*) deSelectValueDict {
    
    DeSelectValueTask *_deSelectValue = [[DeSelectValueTask alloc] init];
    [_deSelectValue setFormName:[deSelectValueDict objectForKey:@"formName"]];
    [_deSelectValue setFieldName:[deSelectValueDict objectForKey:@"fieldName"]];
    NSMutableArray *_fieldValue = [deSelectValueDict objectForKey:@"fieldValue"];
    if(_fieldValue != nil) {
        [_deSelectValue setDeSelectValues:_fieldValue];
    }
    return _deSelectValue;
}

- (OpenUrlTask*) openUrlTask : (NSDictionary*) openUrlDict {
    
    OpenUrlTask *_openUrl = [[OpenUrlTask alloc] init];
    [_openUrl setWindowType:[openUrlDict objectForKey:@"windowType"]];
    [_openUrl setUrlString:[openUrlDict objectForKey:@"urlString"]];
    [_openUrl setWindowParameters:[openUrlDict objectForKey:@"windowSpecificArgument"]];
    
    return _openUrl;
}

@end
