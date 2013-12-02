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
-(InfoTask*) infoTask : (NSDictionary*) infoValueDict;

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
//                                                          {
//                                                              compType = 1;
//                                                              fieldName = "Single_Line";
//                                                              fieldValue = a;
//                                                              formName = deluge;
//                                                              task = 12;
//                                                          }
//
//                                                          
//                                                          json dict {
//                                                              code = 2911;
//                                                              message = "No Access.";
//                                                          }
//

@end

@implementation ScriptJSONParser(private)

- (void) parseDelugeJSON {
    
    NSData *jsonData = [_jsonString dataUsingEncoding:[NSString defaultCStringEncoding]];
    id _jsonDictionary= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"json dict %@",_jsonDictionary);
    NSLog(@"json dic class %@",[_jsonDictionary class]);
    
    
    if(_jsonDictionary != nil) {
        
        if ([_jsonDictionary isKindOfClass:[NSArray class ]]) {
        for(NSInteger index=0;index<[_jsonDictionary count];index++) {
            
            id delugeTask = [self taskFinder:[_jsonDictionary objectAtIndex:index]];
            NSLog(@"Task had added");
            [_delugeTasks addTaskList:delugeTask];
            NSLog(@"Task had added");
        }
        }
        else if([_jsonDictionary isKindOfClass:[NSDictionary class]])
        {
            id delugeTask = [self taskFinder:_jsonDictionary ];
            [_delugeTasks addTaskList:delugeTask];
        }
    }
}


- (id) taskFinder : (NSDictionary*) taskDict {
    
    NSString *task = [taskDict objectForKey:@"task"];
    NSInteger taskNumber = [task integerValue];
    NSLog(@"coming to task Finder %d",taskNumber);
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
            NSLog(@"Coming to open Url task parser");
            return [self openUrlTask:taskDict];
        case 71:
            return [self infoTask:taskDict];

    }
    return nil;
}

-(InfoTask *)infoTask:(NSDictionary *)infoValueDict
{
    
    InfoTask *info = [[InfoTask alloc] init];
    [info setTaskType:@"alert"];
    [info setMessage:[infoValueDict objectForKey:@"infoValue"]];
    return info;
}
- (AlertTask*) alertTask : (NSDictionary*) alertDic {
    
    AlertTask *alert = [[AlertTask alloc] init];
    [alert setTaskType:@"alert"];
    [alert setMessage:[alertDic objectForKey:@"alertValue"]];
    return alert;
}

- (SetVariableTask*) setVariableTask : (NSDictionary*) setVariableDic {
    
    SetVariableTask *setVariable = [[SetVariableTask alloc] init];
    [setVariable setTaskType:@"setvalue"];
    [setVariable setFieldName:[setVariableDic objectForKey:@"fieldName"]];
    [setVariable setFormName:[setVariableDic objectForKey:@"formName"]];
    id fieldValue = [setVariableDic objectForKey:@"fieldValue"];
    
    NSString * rowDetails;
    
    
    rowDetails= [setVariableDic objectForKey:@"rowNo"];
    if (rowDetails.length) {
        
        NSString * string=[[rowDetails componentsSeparatedByString:@"t::row_"]objectAtIndex:1];
        [setVariable setRowNumber_Subform:[string integerValue ]];
    }

    if(fieldValue != nil) {
            [setVariable setFieldValue:fieldValue];
    }
    
    
    NSString * subformName= [setVariableDic objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [setVariable setSubformName:subformName];
    }
    

//    compType = 3;
//    fieldName = "Multi_Line";
//    fieldValue = "";
//    formName = "Untitled_Form";
//    rowNo = "t::row_1";
//    subFormName = SubForm;
//    task = 12;
//    
    
    return setVariable;
}

-
(EnableTask*) enableTask : (NSDictionary*) enableDict {
    
    EnableTask *_enableField = [[EnableTask alloc] init];
    [_enableField setTaskType:@"enable"];
    [_enableField setFormName:[enableDict objectForKey:@"formName"]];
    [_enableField setFieldName:[enableDict objectForKey:@"fieldName"]];
    
    NSString * subformName= [enableDict objectForKey:@"subFormName"];

    if (subformName !=Nil) {
    [_enableField setSubformName:subformName];
    }
    
    return _enableField;
}

- (DisableTask*) disableTask : (NSDictionary*) disableDict {
    
    DisableTask *_disableField = [[DisableTask alloc] init];
    [_disableField setTaskType:@"disable"];
    [_disableField setFormName:[disableDict objectForKey:@"formName"]];
    [_disableField setFieldName:[disableDict objectForKey:@"fieldName"]];
    NSString * subformName= [disableDict objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [_disableField setSubformName:subformName];
    }

    return _disableField;
}

- (ShowTask*) showTask : (NSDictionary*) showDict {
    
    ShowTask *_showTask = [[ShowTask alloc] init];
    [_showTask setTaskType:@"show"];
    [_showTask setFormName:[showDict objectForKey:@"formName"]];
    [_showTask setFieldName:[showDict objectForKey:@"fieldName"]];
    NSString * subformName= [showDict objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [_showTask setSubformName:subformName];
    }

    return _showTask;
    
}

- (HideTask*) hideTask : (NSDictionary*) hideDict {
    
    HideTask *_hideField = [[HideTask alloc] init];
    [_hideField setTaskType:@"hide"];
    
//    compType = 3;
//    fieldName = "Multi_Line";
//    formName = "Untitled_Form";
//    subFormName = SubForm;
//    task = 10;
//
//    
    
    [_hideField setFormName:[hideDict objectForKey:@"formName"]];
    [_hideField setFieldName:[hideDict objectForKey:@"fieldName"]];
    NSString * subformName= [hideDict objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [_hideField setSubformName:subformName];
    }

    
    return _hideField;
}

- (ClearTask*) clearTask : (NSDictionary*) clearDict {
    
    ClearTask *_clearField = [[ClearTask alloc] init];
    [_clearField setTaskType:@"clear"];
    [_clearField setFormName:[clearDict objectForKey:@"formName"]];
    [_clearField setFieldName:[clearDict objectForKey:@"fieldName"]];
    
    
    NSString * subformName= [clearDict objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [_clearField setSubformName:subformName];
    }
    NSString * rowDetails;
    
    
    rowDetails= [clearDict objectForKey:@"rowNo"];
    if (rowDetails.length) {
        
        NSString * string=[[rowDetails componentsSeparatedByString:@"t::row_"]objectAtIndex:1];
        [_clearField setRowNumber_Subform:[string integerValue ]];
    }


    return _clearField;
}

- (ReloadFormTask*) reloadFormTask : (NSDictionary*) reloadFormDict {
    
    ReloadFormTask *_reloadTask = [[ReloadFormTask alloc] init];
    [_reloadTask setTaskType:@"reloadform"];
    [_reloadTask setFormName:[reloadFormDict objectForKey:@"formName"]];
    NSString * subformName= [reloadFormDict objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [_reloadTask setSubformName:subformName];
    }
    
    NSString * rowDetails;
    
    
    rowDetails= [reloadFormDict objectForKey:@"rowNo"];
    if (rowDetails.length) {
        
        NSString * string=[[rowDetails componentsSeparatedByString:@"t::row_"]objectAtIndex:1];
        [_reloadTask setRowNumber_Subform:[string integerValue ]];
    }
    


    return _reloadTask;
}

- (AddValueTask*) addValueTask : (NSDictionary*) addValueDict {
    
    AddValueTask *_addValue = [[AddValueTask alloc] init];
    [_addValue setTaskType:@"addvalue"];
    [_addValue setFormName:[addValueDict objectForKey:@"formName"]];
    [_addValue setFieldName:[addValueDict objectForKey:@"fieldName"]];
    NSMutableArray *_fieldValueList = [addValueDict objectForKey:@"fieldValue"];
    
    NSString * subformName= [addValueDict objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [_addValue setSubformName:subformName];
    }
    

    
    NSString * rowDetails;
    
    
    rowDetails= [addValueDict objectForKey:@"rowNo"];
    if (rowDetails.length) {
        
        NSString * string=[[rowDetails componentsSeparatedByString:@"t::row_"]objectAtIndex:1];
        [_addValue setRowNumber_Subform:[string integerValue ]];
    }
    

    
    
    
    [_addValue setFieldValues:_fieldValueList];
    
    return _addValue;
}

- (SelectAllTask*) selectAllTask : (NSDictionary*) selectAllDict {
    
    SelectAllTask *_selectAll = [[SelectAllTask alloc] init];
    [_selectAll setTaskType:@"selectall"];
    [_selectAll setFieldName:[selectAllDict objectForKey:@"fieldName"]];
    [_selectAll setFormName:[selectAllDict objectForKey:@"formName"]];
    NSString * subformName= [selectAllDict objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [_selectAll setSubformName:subformName];
    }
    
    NSString * rowDetails;
    
    
    rowDetails= [selectAllDict objectForKey:@"rowNo"];
    if (rowDetails.length) {
        
        NSString * string=[[rowDetails componentsSeparatedByString:@"t::row_"]objectAtIndex:1];
        [_selectAll setRowNumber_Subform:[string integerValue ]];
    }
    


    return _selectAll;
}

- (DeSelectAll*) deSelectAllTask : (NSDictionary*) deSelectAllDict {
    
    DeSelectAll *_deSelectAll = [[DeSelectAll alloc] init];
    [_deSelectAll setTaskType:@"deselectall"];
    [_deSelectAll setFieldName:[deSelectAllDict objectForKey:@"fieldName"]];
    [_deSelectAll setFormName:[deSelectAllDict objectForKey:@"formName"]];
    
    NSString * subformName= [deSelectAllDict objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [_deSelectAll setSubformName:subformName];
    }
    
    NSString * rowDetails;
    
    
    rowDetails= [deSelectAllDict objectForKey:@"rowNo"];
    if (rowDetails.length) {
        
        NSString * string=[[rowDetails componentsSeparatedByString:@"t::row_"]objectAtIndex:1];
        [_deSelectAll setRowNumber_Subform:[string integerValue ]];
    }
    


    return _deSelectAll;
}

- (SelectValueTask*) selectValueTask : (NSDictionary*) selectValueDict {
    
    SelectValueTask *_selectValue = [[SelectValueTask alloc] init];
    [_selectValue setTaskType:@"select"];
    [_selectValue setFormName:[selectValueDict objectForKey:@"formName"]];
    [_selectValue setFieldName:[selectValueDict objectForKey:@"fieldName"]];
    NSMutableArray *_fieldValue = [selectValueDict objectForKey:@"fieldValue"];
    
    NSString * subformName= [selectValueDict objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [_selectValue setSubformName:subformName];
    }
    

    NSString * rowDetails;
    
    
    rowDetails= [selectValueDict objectForKey:@"rowNo"];
    if (rowDetails.length) {
        
        NSString * string=[[rowDetails componentsSeparatedByString:@"t::row_"]objectAtIndex:1];
        [_selectValue setRowNumber_Subform:[string integerValue ]];
    }
    

    if(_fieldValue != nil) {
        [_selectValue setSelectValues:_fieldValue];
    }
    return _selectValue;
}

- (DeSelectValueTask*) deSelectValueTask : (NSDictionary*) deSelectValueDict {
    
    DeSelectValueTask *_deSelectValue = [[DeSelectValueTask alloc] init];
    [_deSelectValue setTaskType:@"deselect"];
    [_deSelectValue setFormName:[deSelectValueDict objectForKey:@"formName"]];
    [_deSelectValue setFieldName:[deSelectValueDict objectForKey:@"fieldName"]];
    NSMutableArray *_fieldValue = [deSelectValueDict objectForKey:@"fieldValue"];
    if(_fieldValue != nil) {
        [_deSelectValue setDeSelectValues:_fieldValue];
    }
    
    NSString * subformName= [deSelectValueDict objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [_deSelectValue setSubformName:subformName];
    }
    

    NSString * rowDetails;
    
    
    rowDetails= [deSelectValueDict objectForKey:@"rowNo"];
    if (rowDetails.length) {
        
        NSString * string=[[rowDetails componentsSeparatedByString:@"t::row_"]objectAtIndex:1];
        [_deSelectValue setRowNumber_Subform:[string integerValue ]];
    }
    

    return _deSelectValue;
}

- (OpenUrlTask*) openUrlTask : (NSDictionary*) openUrlDict {
    
    OpenUrlTask *_openUrl = [[OpenUrlTask alloc] init];
    [_openUrl setTaskType:@"openurl"];
    [_openUrl setWindowType:[openUrlDict objectForKey:@"windowType"]];
    [_openUrl setUrlString:[openUrlDict objectForKey:@"urlString"]];
    [_openUrl setWindowParameters:[openUrlDict objectForKey:@"windowSpecificArgument"]];
    
    
    NSString * subformName= [openUrlDict objectForKey:@"subFormName"];
    
    if (subformName !=Nil) {
        [_openUrl setSubformName:subformName];
    }
    
    NSString * rowDetails;
    
    
    rowDetails= [openUrlDict objectForKey:@"rowNo"];
    if (rowDetails.length) {
        
        NSString * string=[[rowDetails componentsSeparatedByString:@"t::row_"]objectAtIndex:1];
        [_openUrl setRowNumber_Subform:[string integerValue ]];
    }
    
    
    return _openUrl;
}

@end
