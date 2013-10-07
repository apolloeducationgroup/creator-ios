//
//  DelugeEvent.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 08/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "DelugeEvent.h"


@implementation DelugeEvent

@synthesize delugeURL=_delugeURL,callerDelegate=_callerDelegate;

- (DelugeEvent*) initDelugeEvent : (NSString*) appLinkName withFormLinkName : (NSString*) formLinkName {
    
    self = [super init];
    if(self) {
        
        
    }
    return self;
}

- (DelugeEvent*) initDelugeEvent : (ZCApplication*) _app withForm : (ZCForm*) _zcForm : (id) delegate {
    
    self = [super init];
    if(self) {
        
    }
    return self;
}


- (CustomActionResponse*) executeCustomAction {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    URLConnector *connector = [[URLConnector alloc] initFetcher:_delugeURL];
    NSString *formMetaXML = [connector apiResponse];
    CustomActionParser *parser = [[CustomActionParser alloc] initScriptParser:formMetaXML];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return [parser customResponse];
}

- (void) executeActions {
    
    if([_delugeTasks noScript]==NO) {
        
        NSMutableArray *taskList = [_delugeTasks taskList];
        NSInteger taskCount = [taskList count];
        NSInteger taskIndex=0;
        
        // //NSLog(@"task count : %d",taskCount);
        
        for(taskIndex=0;taskIndex<taskCount;taskIndex++) {
            
            DelugeTask *task = [taskList objectAtIndex:taskIndex];
            NSString *taskType = [task taskType];
            
            // //NSLog(@"tasktype is : %@",taskType);
            
            if([taskType isEqualToString:@"alert"]) {
                
                AlertTask *alertTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate showAlert: [alertTask message]];
            }
            else if([taskType isEqualToString:@"show"]) {
                
                ShowTask *showTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate showField:[showTask formName] :[showTask fieldName]];
            }
            else if([taskType isEqualToString:@"hide"]) {
                
                HideTask *showTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate hideField:[showTask formName] :[showTask fieldName]];
            }
            else if([taskType isEqualToString:@"enable"]) {
                
                ShowTask *enableTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate enableField:[enableTask formName] :[enableTask fieldName]];
            }
            else if([taskType isEqualToString:@"disable"]) {
                
                DisableTask *showTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate disableField:[showTask formName] :[showTask fieldName]];
            }
            else if([taskType isEqualToString:@"addvalue"]) {
                
                AddValueTask *addValue = [taskList objectAtIndex:taskIndex];
                
                // //NSLog(@"%@addvalue fieldvalue is :",[addValue fieldValues]);
                // //NSLog(@"%@addvalue fieldname is :",[addValue fieldName]);
                
                [_callerDelegate addValues:[addValue formName] :[addValue fieldName] :[addValue fieldValues]];
                
                
            }
            else if([taskType isEqualToString:@"removevalue"]) {
                
                AddValueTask *addValue = [taskList objectAtIndex:taskIndex];
                
                [_callerDelegate addValues:[addValue formName] :[addValue fieldName] :[addValue fieldValues]];
            }
            else if([taskType isEqualToString:@"clear"]) {
                ClearTask *clearTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate clearValue:[clearTask formName] :[clearTask fieldName]];
            }
            else if([taskType isEqualToString:@"setvalue"]) {
                SetVariableTask *setVariable = [taskList objectAtIndex:taskIndex];
                [_callerDelegate setFieldValue:[setVariable formName]: [ setVariable fieldName]:[setVariable fieldValue]];
            }
            else if([taskType isEqualToString:@"openurl"]) {
                ////// //NSLog(@"Coming to openurl task");
                OpenUrlTask *openUrlTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate openUrl : [openUrlTask urlString] withWindowType : [openUrlTask windowType] andParameter : [openUrlTask windowParameters]];
            }
            else if([taskType isEqualToString:@"reloadform"]) {
                ReloadFormTask *reloadTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate reloadForm: [reloadTask formName]];
            }
            else if([taskType isEqualToString:@"select"]) {
                SelectValueTask *selectValueTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate selectValue:[selectValueTask formName] withFieldName:[selectValueTask fieldName] andValues:[selectValueTask selectValues]];
            }
            else if([taskType isEqualToString:@"selectall"]) {
                SelectAllTask *selectAllTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate selectAllValues:[selectAllTask formName] withFieldName:[selectAllTask fieldName]];
            }
            else if([taskType isEqualToString:@"deselect"]) {
                DeSelectValueTask *deSelectTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate deSelectValue:[deSelectTask formName] withFieldName:[deSelectTask fieldName] andValues:[deSelectTask deSelectValues]];
            }
            else if([taskType isEqualToString:@"deselectall"]) {
                DeSelectAll *deSelectAllTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate deSelectAllValues:[deSelectAllTask formName] withFieldName:[deSelectAllTask fieldName]];
            }
        }
    }
    else {
        [_callerDelegate noScript:[_delugeTasks noScriptMessage]];
    }
    
}
- (DelugeTasks*)  execute {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    URLConnector *connector = [[URLConnector alloc] initFetcher:_delugeURL];
    NSString *formMetaXML = [connector apiResponse];
    //// //NSLog(@"deluge form Meta XML %@ ",formMetaXML);
    ScriptParser *parser = [[ScriptParser alloc] initScriptParser:formMetaXML];
    _delugeTasks = [parser delugeTasks];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self performSelectorOnMainThread:@selector(executeActions) withObject:self waitUntilDone:NO];
    return _delugeTasks;
}

+ (NSString*) getParamStringByZCRecord  : (ZCRecord*) _record {
    
    return [DelugeEvent getParamStringByDict:[_record record]];
}

+ (NSString*) getParamXMLString : (ZCRecord*) _record  : (NSString*) sharedBy {
    //// //NSLog(@"In getParamXMLString");
    
    NSMutableString *paramString = [NSMutableString string];
    NSMutableDictionary *_dictionary = [_record record];
    
    //// //NSLog(@"record dict : %@",_dictionary);
    
    NSEnumerator *keyEnum = [_dictionary keyEnumerator];
    NSString *keyName;
    [paramString appendString:@"<fields>"];
    while((keyName = [keyEnum nextObject]) != nil) {
        ZCFieldData *fieldDate = [_dictionary valueForKey:keyName];
        id keyValue = [fieldDate fieldValue];
        //        //// //NSLog(@"Key Value for key Name %@ %@",keyName,keyValue);
        //// //NSLog(@"field name %@  %@",[fieldDate fieldName],[fieldDate fieldValue]);
        if(keyValue != nil) {
            if([keyValue isKindOfClass:[NSString class]]) {
                [paramString appendFormat:@"<field name=\'%@\'><value><![CDATA[%@]]></value></field>",keyName,keyValue];
            }
            else if([keyValue isKindOfClass:[NSMutableArray class]]) {
                //// //NSLog(@"Array   %@",keyValue);
                if([keyValue count] > 0) {
                    [paramString appendFormat:@"<field name=\'%@\'><value><![CDATA[%@]]></value></field>",keyName,[keyValue objectAtIndex:0]];
                }
            }
        }
    }
    [paramString appendString:@"</fields>"];
    [paramString appendFormat:@"&sharedBy=%@",sharedBy];
    return [paramString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString*) getParamStringByDict : (NSMutableDictionary*) _dictionary {
    
    NSMutableString *paramString = [NSMutableString string];
    NSEnumerator *keyEnum = [_dictionary keyEnumerator];
    NSString *keyName;
    BOOL starting = NO;
    while((keyName = [keyEnum nextObject]) != nil) {
        ZCFieldData *fieldDate = [_dictionary valueForKey:keyName];
        id keyValue = [fieldDate fieldValue];
        ////// //NSLog(@"Key Value for key Name %@ %@",keyName,keyValue);
        if(keyValue != nil) {
            if([keyValue isKindOfClass:[NSString class]]) {
                if(starting) {
                    [paramString appendFormat:@"&%@_delvar=%@",keyName,keyValue];
                }
                else {
                    [paramString appendFormat:@"%@_delvar=%@",keyName,keyValue];
                }
            }
            else if([keyValue isKindOfClass:[NSMutableArray class]]) {
                
            }
        }
        starting = YES;
    }
    return paramString;
}

@end
