//
//  ZCSectionParser.m
//  ZohoCreator
//
//  Created by Vishnukumar on 14/09/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ScriptParser.h"
#import "ScriptJSONParser.h"

/**** start of private interface for the current class ****/

@interface ScriptParser (hidden)

- (void) parseScriptXML;

@end

/**** end of private interface for the current class ****/

@implementation ScriptParser

@synthesize delugeTasks=_delugeTasks;

- (ScriptParser*) initScriptParser:(NSString *)xmlString
{
    self = [super init];
    if(self) {
        self->_xmlString = xmlString;
        self->_delugeTasks = [[DelugeTasks alloc] initDelugeTasks];
    }
    [self parseScriptXML];
    return self;
}


-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
    self->_delugeTasks = [[DelugeTasks alloc] initDelugeTasks];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {
    
    ////// //NSLog(@"Element name %@",elementName);
    if([elementName isEqualToString:@"task"]) {
        
        NSString *taskString = [attributeDict objectForKey:@"type"];
        ////// //NSLog(@"task string %@",taskString);
        if([taskString isEqualToString:@"alert"]) {
            taskType = ALERT_TASK;
            delugeTask = [[AlertTask alloc] init];
            [delugeTask setTaskType:@"alert"];
        }
        else if([taskString isEqualToString:@"show"]) {
            
            taskType = SHOW_TASK;
            delugeTask = [[ShowTask alloc] init];
            [delugeTask setTaskType:@"show"];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            NSString *fieldName = [attributeDict objectForKey:@"fieldname"];
            [delugeTask setFieldName:fieldName];
            [delugeTask setFormName:formName];
        }
        else if([taskString isEqualToString:@"hide"]) {
            
            taskType = HIDE_TASK;
            delugeTask = [[HideTask alloc] init];
            [delugeTask setTaskType:@"hide"];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            NSString *fieldName = [attributeDict objectForKey:@"fieldname"];
            [delugeTask setFieldName:fieldName];
            [delugeTask setFormName:formName];
        }
        else if([taskString isEqualToString:@"enable"]) {
            
            taskType = HIDE_TASK;
            delugeTask = [[EnableTask alloc] init];
            [delugeTask setTaskType:@"enable"];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            NSString *fieldName = [attributeDict objectForKey:@"fieldname"];
            [delugeTask setFieldName:fieldName];
            [delugeTask setFormName:formName];
        }
        
        else if([taskString isEqualToString:@"disable"]) {
            
            taskType = DISABLE_TASK;
            delugeTask = [[DisableTask alloc] init];
            [delugeTask setTaskType:@"disable"];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            NSString *fieldName = [attributeDict objectForKey:@"fieldname"];
            [delugeTask setFieldName:fieldName];
            [delugeTask setFormName:formName];
        }
        
        else if([taskString isEqualToString:@"addvalue"]) {
            
            taskType = ADDVALUE_TASK;
            delugeTask = [[AddValueTask alloc] init];
            [delugeTask setTaskType:@"addvalue"];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            NSString *fieldName = [attributeDict objectForKey:@"fieldname"];
            [delugeTask setFieldName:fieldName];
            [delugeTask setFormName:formName];
        }
        else if([taskString isEqualToString:@"clear"]) {
            taskType = CLEAR_TASK;
            delugeTask = [[ClearTask alloc] init];
            [delugeTask setTaskType:@"clear"];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            NSString *fieldName = [attributeDict objectForKey:@"fieldname"];
            [delugeTask setFieldName:fieldName];
            [delugeTask setFormName:formName];
        }
        else if([taskString isEqualToString:@"openurl"]) {
            
            taskType = OPENURL_TASK;
            delugeTask = [[OpenUrlTask alloc] init];
            [delugeTask setTaskType:@"openurl"];
        }
        else if([taskString isEqualToString:@"setvalue"]) {
            taskType = SETVARIABLE_TASK;
            delugeTask = [[SetVariableTask alloc] init];
            [delugeTask setTaskType:@"setvalue"];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            NSString *fieldName = [attributeDict objectForKey:@"fieldname"];
            [delugeTask setFieldName:fieldName];
            [delugeTask setFormName:formName];
        }
        else if([taskString isEqualToString:@"reloadform"]) {
            taskType = RELOADFORM_TASK;
            delugeTask = [[ReloadFormTask alloc] init];
            [delugeTask setTaskType:@"reloadform"];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            [delugeTask setFormName:formName];
            [_delugeTasks addTaskList:delugeTask];
            taskType = -1;
        }
        else if([taskString isEqualToString:@"select"]) {
            ////// //NSLog(@"Coming to select Value parser");
            taskType = SELECTVALUE_TASK;
            delugeTask = [[SelectValueTask alloc]init];
            [delugeTask setTaskType:@"select"];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            NSString *fieldName = [attributeDict objectForKey:@"fieldname"];
            [delugeTask setFormName:formName];
            [delugeTask setFieldName:fieldName];
        }
        else if([taskString isEqualToString:@"selectall"]) {
            ////// //NSLog(@"Coming to select All Value parser");
            taskType = SELECTALL_TASK;
            delugeTask = [[SelectAllTask alloc]init];
            [delugeTask setTaskType:@"selectall"];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            NSString *fieldName = [attributeDict objectForKey:@"fieldname"];
            [delugeTask setFormName:formName];
            [delugeTask setFieldName:fieldName];
        }
        else if([taskString isEqualToString:@"deselectall"]) {
            taskType = DESELECTALL_TASK;
            delugeTask = [[DeSelectAll alloc]init];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            NSString *fieldName = [attributeDict objectForKey:@"fieldname"];
            [delugeTask setTaskType:@"deselectall"];
            [delugeTask setFormName:formName];
            [delugeTask setFieldName:fieldName];
        }
        else if([taskString isEqualToString:@"deselect"]) {
            taskType = DESELECTVALUE_TASK;
            delugeTask = [[DeSelectValueTask alloc]init];
            [delugeTask setTaskType:@"deselect"];
            NSString *formName = [attributeDict objectForKey:@"formname"];
            NSString *fieldName = [attributeDict objectForKey:@"fieldname"];
            [delugeTask setFormName:formName];
            [delugeTask setFieldName:fieldName];
        }
    }
    else if([elementName isEqualToString:@"NoScript"]) {
        
        _noScriptError = YES;
    }
    _currentElementName = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(taskType==ALERT_TASK) {
        
        if([_currentElementName isEqualToString:@"value"]) {
            [delugeTask setMessage:string];
        }
    }
    else if(taskType == ADDVALUE_TASK) {
        
        if([_currentElementName isEqualToString:@"value"]) {
            NSMutableArray *fieldValues = [[NSMutableArray alloc] init];
            [fieldValues addObject:string];
            [delugeTask setFieldValues:fieldValues];
        }
    }
    else if(taskType == OPENURL_TASK) {
        
        if([_currentElementName isEqualToString:@"url"]) {
//            [delugeTask setUrlString:string];
            [ScriptJSONParser setopenURLTaskparameters:delugeTask urlString:string];
        }
        else if([_currentElementName isEqualToString:@"windowtype"]) {
            [delugeTask setWindowType:string];

        }
        else if([_currentElementName isEqualToString:@"parameter"]) {
            [delugeTask setWindowParameters:string];
        }
    }
    else if(taskType == SETVARIABLE_TASK)
    {
        if([_currentElementName isEqualToString:@"value"]) {
            [delugeTask setFieldValue:string];
        }
        else if([_currentElementName isEqualToString:@"values"]) {
            
        }
    }
    else if(taskType == SELECTVALUE_TASK) {
        
        if([_currentElementName isEqualToString:@"value"]) {
            
            NSMutableArray *fieldValues = [[NSMutableArray alloc] init];
            [fieldValues addObject:string];
            [delugeTask setSelectValues:fieldValues];
        }
    }
    else if(taskType == DESELECTVALUE_TASK) {
        
        if([_currentElementName isEqualToString:@"value"]) {
            
            NSMutableArray *fieldValues = [[NSMutableArray alloc] init];
            [fieldValues addObject:string];
            [delugeTask setDeSelectValues:fieldValues];
            
        }
    }
    else if(_noScriptError == YES) {
        [_delugeTasks setNoScript:YES];
        [_delugeTasks setNoScriptMessage:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"task"]) {
        
        //// //NSLog(@"Coming to add task");
        [_delugeTasks addTaskList:delugeTask];
        taskType=-1;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    
}

@end

/****
 
 start of private implementation for the current class
 
 ****/

@implementation ScriptParser (hidden)

- (void) parseScriptXML  {
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[_xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldProcessNamespaces:NO];
    [_xmlParser setShouldReportNamespacePrefixes:NO];
    [_xmlParser setShouldResolveExternalEntities:NO];
    [_xmlParser parse];
}

@end

/****
 
 end of private implementation for the current class
 
 ****/
