//
//  DelugeEvent.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 08/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "DelugeEvent.h"

#import "ZCSubFormRecords.h"
@implementation DelugeEvent

@synthesize delugeURL=_delugeURL,callerDelegate=_callerDelegate,delugeParams=_delugeParams;

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
    NSLog(@"Post has commented");
    URLConnector *connector = [[URLConnector alloc] initFetcherPost:_delugeURL :[URLConnector POSTMETHOD]];
    NSString *formMetaXML = [connector apiResponse];
    CustomActionParser *parser = [[CustomActionParser alloc] initScriptParser:formMetaXML];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return [parser customResponse];
}

- (void) executeActions {
    
    NSLog(@"coming to execute Action");
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
                [_callerDelegate showField:[showTask formName] :[showTask fieldName] subformName:[showTask subformName]];
            }
            else if([taskType isEqualToString:@"hide"]) {
                
                HideTask *showTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate hideField:[showTask formName] :[showTask fieldName]  subformName:[showTask subformName]];
            }
            else if([taskType isEqualToString:@"enable"]) {
                
                ShowTask *enableTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate enableField:[enableTask formName] :[enableTask fieldName] subformName:[enableTask subformName]];
            }
            else if([taskType isEqualToString:@"disable"]) {
                
                DisableTask *showTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate disableField:[showTask formName] :[showTask fieldName] subformName:[showTask subformName]];
            }
            else if([taskType isEqualToString:@"addvalue"]) {
                
                AddValueTask *addValue = [taskList objectAtIndex:taskIndex];
                
                // //NSLog(@"%@addvalue fieldvalue is :",[addValue fieldValues]);
                // //NSLog(@"%@addvalue fieldname is :",[addValue fieldName]);
                
                [_callerDelegate addValues:[addValue formName] :[addValue fieldName] :[addValue fieldValues] rowNumberForSubform:[addValue rowNumber_Subform] subformName:[ addValue subformName]];
                
                
            }
            else if([taskType isEqualToString:@"removevalue"]) {
                
                AddValueTask *addValue = [taskList objectAtIndex:taskIndex];
                
                [_callerDelegate addValues:[addValue formName] :[addValue fieldName] :[addValue fieldValues] rowNumberForSubform:[addValue rowNumber_Subform] subformName:[ addValue subformName]];
            }
            else if([taskType isEqualToString:@"clear"]) {
                ClearTask *clearTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate clearValue:[clearTask formName] :[clearTask fieldName] rowNumberForSubform:[clearTask rowNumber_Subform] subformName:[ clearTask subformName]];
            }
            else if([taskType isEqualToString:@"setvalue"]) {
                SetVariableTask *setVariable = [taskList objectAtIndex:taskIndex];
                [_callerDelegate setFieldValue:[setVariable formName]: [ setVariable fieldName]:[setVariable fieldValue] rowNumberForSubform:[setVariable rowNumber_Subform] subformName:[ setVariable subformName] ];
            }
            else if([taskType isEqualToString:@"openurl"]) {
                ////// //NSLog(@"Coming to openurl task");
                OpenUrlTask *openUrlTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate openUrl : [openUrlTask urlString] withWindowType : [openUrlTask windowType] andParameter : [openUrlTask windowParameters]rowNumberForSubform:[openUrlTask rowNumber_Subform] subformName:[ openUrlTask subformName]];
            }
            else if([taskType isEqualToString:@"reloadform"]) {
                ReloadFormTask *reloadTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate reloadForm: [reloadTask formName]rowNumberForSubform:[reloadTask rowNumber_Subform] subformName:[ reloadTask subformName]];
            }
            else if([taskType isEqualToString:@"select"]) {
                SelectValueTask *selectValueTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate selectValue:[selectValueTask formName] withFieldName:[selectValueTask fieldName] andValues:[selectValueTask selectValues]rowNumberForSubform:[selectValueTask rowNumber_Subform] subformName:[ selectValueTask subformName]];
            }
            else if([taskType isEqualToString:@"selectall"]) {
                SelectAllTask *selectAllTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate selectAllValues:[selectAllTask formName] withFieldName:[selectAllTask fieldName]rowNumberForSubform:[selectAllTask rowNumber_Subform] subformName:[ selectAllTask subformName]];
            }
            else if([taskType isEqualToString:@"deselect"]) {
                DeSelectValueTask *deSelectTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate deSelectValue:[deSelectTask formName] withFieldName:[deSelectTask fieldName] andValues:[deSelectTask deSelectValues]rowNumberForSubform:[deSelectTask rowNumber_Subform] subformName:[ deSelectTask subformName]];
            }
            else if([taskType isEqualToString:@"deselectall"]) {
                DeSelectAll *deSelectAllTask = [taskList objectAtIndex:taskIndex];
                [_callerDelegate deSelectAllValues:[deSelectAllTask formName] withFieldName:[deSelectAllTask fieldName]rowNumberForSubform:[deSelectAllTask rowNumber_Subform] subformName:[ deSelectAllTask subformName]];
            }
        }
    }
    else {
        [_callerDelegate noScript:[_delugeTasks noScriptMessage]];
    }
    
}
- (DelugeTasks*)  execute {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    URLConnector *connector = [[URLConnector alloc] initFetcherPostParam:_delugeURL :_delugeParams :[URLConnector POSTMETHOD]];
    
    
    NSLog(@"deluge params %@",_delugeParams);
    NSString *formMetaXML = [connector apiResponse];
    //// //NSLog(@"deluge form Meta XML %@ ",formMetaXML);
    
    ScriptJSONParser *parser = [[ScriptJSONParser alloc] initScriptJSONParser:formMetaXML];
//    ScriptParser *parser = [[ScriptParser alloc] initScriptParser:formMetaXML];
    
    _delugeTasks = [parser delugeTasks];
    NSLog(@"deluge tasks %@",_delugeTasks.taskList);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self performSelectorOnMainThread:@selector(executeActions) withObject:self waitUntilDone:NO];
    return _delugeTasks;
}

+ (NSString*) getParamStringByZCRecord  : (ZCRecord*) _record {
    
    return [DelugeEvent getParamStringByDict:[_record record]];
}

+ (NSString*) getParamXMLString : (ZCRecord*) _record  : (NSString*) sharedBy {

    NSDictionary *_dictionary = [_record record];
    NSMutableString *paramString = [NSMutableString string];
    NSEnumerator *keyEnum = [_dictionary keyEnumerator];
    NSString *keyName;
    
//    [paramString appendString:@"&SF(SubForm).FD(t::row_0).SV(record::status):added&SF(SubForm).FD(t::row_0).SV(Multi_Line):&SF(SubForm).FD(t::row_0).SV(Single_Line):riyaz"];
    

    
    while((keyName = [keyEnum nextObject]) != nil) {
        ZCFieldData *fieldDate = [_dictionary valueForKey:keyName];
        id keyValue = [fieldDate fieldValue];
        if(keyValue != nil) {
            if([keyValue isKindOfClass:[NSString class]]) {
                
                [paramString appendFormat:@"&%@=%@",keyName,keyValue];
            }
            else if([keyValue isKindOfClass:[NSMutableArray class]]) {
                
                for(NSInteger optIndex=0;optIndex<[keyValue count];optIndex++) {
                    NSLog(@"coming to index");
                    [paramString appendFormat:@"&%@=%@",keyName,[keyValue objectAtIndex:optIndex]];
                }
            }
            else if ([keyValue isKindOfClass:[ZCSubFormRecords class]])
            {
                
                NSLog(@"subform records riyaz");
                NSMutableArray * recordstoAdd=[[NSMutableArray alloc]init];
//               [recordstoAdd addObjectsFromArray:[keyValue recordsToAdd]];
//                [recordstoAdd addObjectsFromArray:[keyValue recordsToUpdate]];
//                [recordstoAdd addObjectsFromArray:[keyValue temporaryRecords]];
                
                
                [recordstoAdd addObjectsFromArray:[keyValue allRecordsInOrder]];
                [recordstoAdd addObjectsFromArray:[keyValue temporaryRecords]];

                if (recordstoAdd.count)
                {
                
             [paramString appendString:[DelugeEvent getsubformRecordParam:recordstoAdd fieldlinkname:[fieldDate fieldName]]];
//                [paramString appendFormat:@"&fieldName=%@",keyName];
                }
            }
        }
    }
    /*
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
    [paramString appendFormat:@"&sharedBy=%@",sharedBy]; */

    return  paramString;
//    return [paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
}
+(NSString *)getsubformRecordParam:(NSMutableArray *)records fieldlinkname:(NSString *)fieldlinkname
{

    
    
    NSMutableString * param=[[NSMutableString alloc]init];
    
    
    
//    [param appendString:@"&SF(SubForm).FD(t::row_0).SV(record::status)=added&SF(SubForm).FD(t::row_0).SV(Multi_Line):&SF(SubForm).FD(t::row_0).SV(Single_Line):"];

    
//    [param appendFormat:@"&SF(%@).FD(t::row_0).SV(record::status)=added",fieldlinkname];
/*
    
    if (records.count) {
        

    
    NSDictionary *_dictionary = [[records objectAtIndex:0 ]record];
    NSEnumerator *keyEnum = [_dictionary keyEnumerator];
    NSString *keyName;
        [param appendFormat:@"&SF(%@).FD(t::row_0).SV(record::status)=added",fieldlinkname];

    while((keyName = [keyEnum nextObject]) != nil) {

        ZCFieldData *fieldDate = [_dictionary valueForKey:keyName];
        id keyValue = [fieldDate fieldValue];
        if(keyValue != nil) {
            if([keyValue isKindOfClass:[NSString class]]) {
                //                [paramString appendFormat:@"&%@=%@",keyName,keyValue];
                
                
                
                //   SF(SubForm_1).FD(t::row_1).SV(Single_Line_1):1111

                
                
                [param appendFormat:@"&SF(%@).FD(t::row_0).SV(%@):%@",fieldlinkname,[fieldDate fieldName ],[fieldDate fieldValue]];
                
                
    
                
            }
            
        }}
    */
    
    
        
//        zccpn=b5822429-c393-4d06-9246-856e20473a4b
//        &name=sadsadasdsadsadasd
//        &=%23Form%3Amain_form
//        &SF(SubForm_1).FD(t::row_0).SV(record::status)=added
//        &SF(SubForm_1).FD(t::row_0).SV(Single_Line_1)=
//        &SF(SubForm_1).FD(t::row_0).SV(Single_Line)=
//        &SF(SubForm_1).FD(t::row_1).SV(record::status)=added
//        &SF(SubForm_1).FD(t::row_1).SV(Single_Line_1)=1111
//        &SF(SubForm_1).FD(t::row_1).SV(Single_Line)=asd
//        &SF(SubForm_1).FD(t::row_1).MV(Checkbox)=Choice%202
//        &SF(SubForm_1).FD(t::row_2).SV(record::status)=added
//        &SF(SubForm_1).FD(t::row_2).SV(Single_Line_1)=
//        &SF(SubForm_1).FD(t::row_2).SV(Single_Line)=
//        &SF(SubForm_1).FD(t::row_2).MV(Checkbox)=Choice%201
//        &SF(SubForm_1).FD(t::row_2).MV(Checkbox)=Choice%202
//        &SF(SubForm_1).FD(t::row_2).MV(Checkbox)=Choice%203
//        &SF(SubForm_1).FD(t::row_3).SV(record::status)=added
//        &SF(SubForm_1).FD(t::row_3).SV(Single_Line_1)=
//        &SF(SubForm_1).FD(t::row_3).SV(Single_Line)=
//        &SF(SubForm_1).FD(t::row_4).SV(record::status)=added
//        &SF(SubForm_1).FD(t::row_4).SV(Single_Line_1)=
//        &SF(SubForm_1).FD(t::row_4).SV(Single_Line)=
//        &zc-mobile=
//        &formid=1411560000000310009
//        &formLinkId=178
//        &formLinkName=main_form
//        &tableName=t_1411560000000310009
//        &lookupFieldName=
//        &childFormAccessType=
//        &childFieldLabelName=
//        &childFormLinkName=
//        &childAppLinkName=
//        &childFormPrivateLink=
//        &isFromSubForm=
//        &rowNo=
//        &subFormAppName=
//        &subFormLinkName=
//        &recType=1
//        &viewLinkName=
//        &pkValue=
//        &dateFormat=dd-MMM-yyyy
//        &timeZone=America%2FLos_Angeles
//        
//        &uiDateFormat=%25d-%25b-%25Y
//        &fromIDX=
//        &privatelink=
//        &viewPrivateLink=
//        &appLinkName=subform-app
//        &sharedBy=riyazmd
//        &isNewTypeSubform=
//        &childSubformField=
//        &zc_lookupCount=
//        &fcid=1411560000000310127
//        &fcname=SubForm_1
//        &rowseqid=t::row_4
//        &rowactiontype=onaddrow
//        Response Headersview source
//
    
    
//    
//    SF(SubForm_1).FD(t::row_0).SV(record::status):added
//    SF(SubForm_1).FD(t::row_0).SV(Single_Line_1):
//    SF(SubForm_1).FD(t::row_0).SV(Single_Line):
//    
//    
//    SF(SubForm_1).FD(t::row_1).SV(record::status):added
//    SF(SubForm_1).FD(t::row_1).SV(Single_Line_1):1111
//    SF(SubForm_1).FD(t::row_1).SV(Single_Line):asd
//    SF(SubForm_1).FD(t::row_1).MV(Checkbox):Choice 2
//    
//    
//    SF(SubForm_1).FD(t::row_2).SV(record::status):added
//    SF(SubForm_1).FD(t::row_2).SV(Single_Line_1):
//    SF(SubForm_1).FD(t::row_2).SV(Single_Line):
//    SF(SubForm_1).FD(t::row_2).MV(Checkbox):Choice 1
//    SF(SubForm_1).FD(t::row_2).MV(Checkbox):Choice 2
//    SF(SubForm_1).FD(t::row_2).MV(Checkbox):Choice 3
//    
//    
//    SF(SubForm_1).FD(t::row_3).SV(record::status):added
//    SF(SubForm_1).FD(t::row_3).SV(Single_Line_1):
//    SF(SubForm_1).FD(t::row_3).SV(Single_Line):

    
    for (int recindex=0;recindex<[records count];recindex++) {
        
        
        ZCRecord * record =  [records objectAtIndex:recindex];

    NSDictionary *_dictionary = [record record];
    NSEnumerator *keyEnum = [_dictionary keyEnumerator];
    NSString *keyName;
        [param appendFormat:@"&SF(%@).FD(t::row_%i).SV(record::status)=added",fieldlinkname,recindex+1];
    while((keyName = [keyEnum nextObject]) != nil) {
        ZCFieldData *fieldDate = [_dictionary valueForKey:keyName];
        id keyValue = [fieldDate fieldValue];
        if(keyValue != nil) {
            if([keyValue isKindOfClass:[NSString class]]) {
//                [paramString appendFormat:@"&%@=%@",keyName,keyValue];
                
                
                
           //   SF(SubForm_1).FD(t::row_1).SV(Single_Line_1):1111
                
                
                
                [param appendFormat:@"&SF(%@).FD(t::row_%i).SV(%@)=%@",fieldlinkname,recindex+1,[fieldDate fieldName ],[fieldDate fieldValue]];
                
                
                

            }
            else if([keyValue isKindOfClass:[NSMutableArray class]]) {
                
                for(NSInteger optIndex=0;optIndex<[keyValue count];optIndex++) {
                    
                    
                    
                    [param appendFormat:@"&SF(%@).FD(t::row_%i).MV(%@)=%@",fieldlinkname,recindex+1,[fieldDate fieldName ],[keyValue objectAtIndex:optIndex]];

//                    [paramString appendFormat:@"&%@=%@",keyName,[keyValue objectAtIndex:optIndex]];
                }
            }
        }
    }


        
        
        



    
    
    }
    //param= [param stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];


    NSLog(@"subformREcordPArm riyaz %@",param);
    return param;

    
}

+ (NSString*) getParamString: (ZCRecord*) _zcRecord {
    
    NSDictionary *_dictionary = [_zcRecord record];
    NSMutableString *paramString = [NSMutableString string];
    NSEnumerator *keyEnum = [_dictionary keyEnumerator];
    NSString *keyName;
    while((keyName = [keyEnum nextObject]) != nil) {
        ZCFieldData *fieldDate = [_dictionary valueForKey:keyName];
        id keyValue = [fieldDate fieldValue];
        if(keyValue != nil) {
            if([keyValue isKindOfClass:[NSString class]]) {
                 [paramString appendFormat:@"%@=%@",keyName,keyValue];
            }
            else if([keyValue isKindOfClass:[NSMutableArray class]]) {
                
            }
        }
    }
    return paramString;
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
