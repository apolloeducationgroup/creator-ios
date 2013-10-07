//
//  FormParser.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "FormParser.h"

@interface FormParser (hidden)

- (void) formParserXML;

@end
@implementation FormParser

@synthesize zcForm=_zcForm;

- (FormParser*) initFormParser:(NSString *) xmlString  : (ZCComponent*) component {
    
    self = [super init];
    if (self) {
        self->_xmlString = xmlString;
        self->_baseType = BASE_NONE;
        self->_resultType = RESULT_NONE;
        self->_zcForm = [ParserUtil convertToZCForm:component];
        fieldOpen = NO;
        noOfFields = 0;
        numberOfSubformRecords=0;
        subformrecordArray=[[NSMutableArray alloc]init];
    }
    [self formParserXML];
    return self;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict

{
    
    if ([elementName isEqualToString:@"Initial"] && subformRecordsInitalValues) {
        
        subformRecords=YES;
    }
    
    if (subformRecords) {
        NSLog(@"element name %@",elementName);
        if ([elementName isEqualToString:@"record"])
        {
            
            //        NSLog(@"attriburte dict %@",attributeDict);
            
            _currentElementName=elementName;
            
            ZCRecord * record=[[ZCRecord alloc]initZCRecord];
            [record setRecordID:[attributeDict objectForKey:@"ID"]];
            ZCFieldData * data=[[ZCFieldData alloc]init];
            [data setFieldName:@"ID"];
            [data setFieldValue:[attributeDict objectForKey:@"ID"]];
            [record addZCFieldData:data];
            
            
            NSMutableArray * array=[[NSMutableArray alloc]init];
            
            
            if ([subformrecordArray count] == numberOfSubformRecords) {
                
                [[subformrecordArray objectAtIndex:numberOfSubformRecords-1] addObject:record];
            }
            
            else{[array addObject:record];
                
                [subformrecordArray addObject:array];
            }
            
            
        }
        
        else  if ([elementName isEqualToString:@"column"])
        {
            
            _subformrecordElementName=[attributeDict objectForKey:@"name"];
            
        }
    }
    
    //    NSLog(@"element name %@",elementName);
    if(_baseType == BASE_RESULT)  {
        
        if(_resultType==RESULT_NONE) {
            
            if([elementName isEqualToString:@"Fields"]) {
                _resultType = RESULT_FIELDS;
                _zcField = [[ZCField alloc] initZCField];
                noOfFields++;
            }
            else if([elementName isEqualToString:@"buttons"]) {
                _resultType = RESULT_BUTTONS;
                _zcButton = [[ZCButton alloc] init];
            }
            else if([elementName isEqualToString:@"DisplayName"]) {
                _resultType = RESULT_DISPLAYNAME;
            }
            else if([elementName isEqualToString:@"tableName"]) {
                hasTableName = YES;
                //                [_zcForm setIsStateful:YES];
            }
        }
        else if(_resultType == RESULT_ERRORLIST) {
            
            if([elementName isEqualToString:@"error"]) {
                _creatorError = [[ZOHOCreatorError alloc] init];
            }
        }
        else if(_resultType==RESULT_FIELDS) {
            
            if(_fieldElementType == FIELD_OPTIONS) {
                
                if([elementName hasPrefix:@"choice"]) {
                    _newOption = YES;
                }
            }
            else {
                
                if([elementName isEqualToString:@"Choices"]) {
                    _optionsList = [[NSMutableArray alloc] init];
                    _optionsListSequence = [[NSMutableArray alloc] init];
                    _fieldElementType = FIELD_OPTIONS;
                    _optionCurrentIndex = 0;
                }
                else if([elementName isEqualToString:@"onChangeExists"]) {
                    [_zcField setHasOnUserScript:YES];
                }
                else if([elementName isEqualToString:@"onAddExists"]) {
                    [_zcField setHasSubFormAddEvent:YES];
                }
                else if([elementName isEqualToString:@"onDeleteExists"]) {
                    [_zcField setHasSubFormDeleteEvent:YES];
                }
                else if([elementName isEqualToString:@"Fields"]) {
                    noOfFields++;
                }
                else if([elementName isEqualToString:@"SubFormFields"]) {
                    _subformFields=YES;
                }
            }
        }
    }
    else if(_hasErrorListTag) {
        
        if([elementName isEqualToString:@"error"]) {
            _creatorError = [[ZOHOCreatorError alloc] init];
        }
    }
    else
    {
        if([elementName isEqualToString:@"result"]) {
            _baseType = BASE_RESULT;
        }
        else if([elementName isEqualToString:@"hasAddOnLoad"]) {
            hasAddOnLoad = YES;
        }
        else if([elementName isEqualToString:@"hasEditOnLoad"]) {
            hasEditOnLoad=YES;
        }
        else if([elementName isEqualToString:@"successMessage"]) {
            hasSuccessMessage = YES;
        }
        else if([elementName isEqualToString:@"dateFormat"]) {
            hasDateFormat=YES;
        }
        else if([elementName isEqualToString:@"errorlist"]) {
            _resultType = RESULT_ERRORLIST;
            _creatorErrorList = [[NSMutableArray alloc] init];
            _hasErrorListTag = YES;
        }
    }
    _currentElementName = [elementName mutableCopy];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (subformRecordsInitalValues) {
        
        
        if ([_currentElementName isEqualToString:@"value"] )
        {
            NSLog(@"element valuewwwwwwww %@",string);
            
            
            ZCFieldData * data=[[ZCFieldData alloc]init];
            [data setFieldName:_subformrecordElementName];
            [data setFieldValue:string];
            //        NSLog(@"element name subof  %@ %@",_subformElementName,string);
            int recordindex=[[subformrecordArray objectAtIndex:numberOfSubformRecords-1]count];
            
            //        NSLog(@"number of sub recs %i %i %@",numberOfSubformRecords,recordindex,subformrecordArray);
            [[[subformrecordArray objectAtIndex:numberOfSubformRecords-1]objectAtIndex:recordindex-1 ]addZCFieldData:data];
            
            
        }
    }
    
    
    
    if(_resultType == RESULT_FIELDS && _subformFields==NO) {
        
        if(_fieldElementType == FIELD_OPTIONS) {
            
            //// //NSLog(@"new option %d",_newOption);
            if(_newOption==YES) {
                [_optionsListSequence addObject:_currentElementName];
                [_optionsList addObject:string];
                // //NSLog(@"Current Option Seq %@",_currentElementName);
                // //NSLog(@"Current Option Strig %@",string);
                _newOption = NO;
                NSLog(@"New option end");
            }
            else {
                
                NSString *optionString = [_optionsList objectAtIndex:([_optionsList count]-1)];
                optionString = [optionString stringByAppendingString:string];
                [_optionsList replaceObjectAtIndex:([_optionsList count]-1) withObject:optionString];
            }
        }
        else {
            if([_currentElementName isEqualToString:@"DisplayName"])
            {
                [_zcField setFieldDisplayName:[NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding]];
            }
            else if([_currentElementName isEqualToString:@"Type"]) {
                [_zcField setFieldType:[string integerValue]];
            }
            else if([_currentElementName isEqualToString:@"MaxChar"]) {
                if([string isEqualToString:@"-1"]) {
                    [_zcField setMaxCharacter:2000];
                }
                else {
                    [_zcField setMaxCharacter:[string integerValue]];
                }
            }
            else if([_currentElementName isEqualToString:@"Visiblity"]) {
                if([string isEqualToString:@"false"]) {
                    [_zcField setIsHidden:YES];
                }
            }
            else if([_currentElementName isEqualToString:@"CurrencyType"]) {
                [_zcField setCurrencyType:string];
            }
            else if([_currentElementName isEqualToString:@"Initial"]) {
                NSLog(@"Coming to inital ");
                NSString *tempInitial = [_zcField initialValues];
                if(tempInitial != nil) {
                    tempInitial = [tempInitial stringByAppendingString:[NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding]];
                }
                else {
                    tempInitial = [NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding];
                }
                NSLog(@"Coming out inital %d %@",[_zcField fieldType],[_zcField fieldDisplayName]);
                [_zcField setInitialValues:tempInitial];
                NSLog(@"Coming out inital ");
            }
            
            
            
            
            
            else if([_currentElementName isEqualToString:@"Text"]) {
                NSString *tempInitial = [_zcField initialValues];
                if(tempInitial != nil) {
                    tempInitial = [tempInitial stringByAppendingString:[NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding]];
                }
                else {
                    tempInitial = [NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding];
                }
                [_zcField setInitialValues:tempInitial];
            }
            else if([_currentElementName isEqualToString:@"FieldName"]) {
                [_zcField setFieldName:string];
            }
            else if([_currentElementName isEqualToString:@"Reqd"]) {
                
                if ([string isEqualToString:@"false"])
                    [_zcField setIsRequired:NO];
            }
            else if([_currentElementName isEqualToString:@"ref_formdispname"]) {
                if([_zcField relatedComponent] == nil) {
                    _zcField.relatedComponent = [[ZCComponent alloc] init];
                }
                [[_zcField relatedComponent] setDisplayName:[NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding]];
                [[_zcField relatedComponent] setZcApplication:[_zcForm zcApplication]];
            }
            else if([_currentElementName isEqualToString:@"ref_formname"]) {
                if([_zcField relatedComponent] == nil) {
                    _zcField.relatedComponent = [[ZCComponent alloc] init];
                }
                // //NSLog(@"Coming to set ref_formname %@",string);
                [[_zcField relatedComponent] setLinkName:string];
                //                [[_zcField relatedComponent] setZcApplication:[_zcForm zcApplication]];
            }
            else if([_currentElementName isEqualToString:@"ref_fieldname"]) {
                [_zcField setRelatedFieldName:string];
            }
            else if([_currentElementName isEqualToString:@"ref_appname"]) {
                
                ZCApplication *application = [[ZCApplication alloc] init];
                [application setAppLinkName:string];
                [application setAppOwner:[[_zcForm application] appOwner]];
                if([_zcField relatedComponent] == nil) {
                    _zcField.relatedComponent = [[ZCComponent alloc] init];
                }
                [[_zcField relatedComponent] setZcApplication:application];
                // //NSLog(@"Coming to set app name %@",string);
                //                // //NSLog(@"app owner name %@",[_zcField ])
            }
            else if([_currentElementName isEqualToString:@"ref_addtext"]) {
                [_zcField setAddNewLinkText:string];
            }
            
            // //NSLog(@"Current element name %@",_currentElementName);
            
        }
    }
    else if(_resultType == RESULT_BUTTONS) {
        
        if([_currentElementName isEqualToString:@"buttonname"]) {
            [_zcButton setButtonName:string];
        }
        else if([_currentElementName isEqualToString:@"displayname"]) {
            [_zcButton setButtonDisplayName:[NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding]];
        }
        else if([_currentElementName isEqualToString:@"sequence"]) {
            [_zcButton setSequence:[string integerValue]];
        }
        else if([_currentElementName isEqualToString:@"type"]) {
            [_zcButton setButtonType:[string integerValue]];
        }
        else if([_currentElementName isEqualToString:@"actiontype"]) {
            [_zcButton setButtonActionType:[string integerValue]];
        }
    }
    else if(_hasErrorListTag) {
        
        if([_currentElementName isEqualToString:@"code"]) {
            [_creatorError setErrorCode:string];
        }
        else if([_currentElementName isEqualToString:@"message"]) {
            [_creatorError setErrorMessage:string];
        }
    }
    else if(_resultType == RESULT_ERRORLIST) {
        
        if([_currentElementName isEqualToString:@"code"]) {
            [_creatorError setErrorCode:string];
        }
        else if([_currentElementName isEqualToString:@"message"]) {
            [_creatorError setErrorMessage:string];
        }
    }
    else if(hasAddOnLoad==YES) {
        
        if([string isEqualToString:@"true"]) {
            
            [_zcForm setHasOnLoad:YES];
        }
        else {
            
            [_zcForm setHasOnLoad:NO];
        }
        hasAddOnLoad = NO;
    }
    else if(hasEditOnLoad==YES) {
        
        if([string isEqualToString:@"true"]) {
            [_zcForm setHasEditOnLoad:YES];
        }
        else {
            [_zcForm setHasEditOnLoad:NO];
        }
        hasEditOnLoad = NO;
        
    }
    else if(hasSuccessMessage==YES) {
        
        ////// //NSLog(@"Success Message has set");
        [_zcForm setSuccessMessage:string];
        hasSuccessMessage=NO;
    }
    else if(hasDateFormat==YES) {
        [_zcForm setDateFormat:string];
        hasDateFormat=NO;
    }
    else if(hasTableName == YES) {
        if([string isEqualToString:@"null"]) {
            [_zcForm setIsStateful:NO];
        }
        else {
            [_zcForm setIsStateful:YES];
        }
    }
    else if(_resultType == RESULT_DISPLAYNAME) {
        
        [_zcForm setDisplayName:string];
    }
    hasTableName = NO;
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"Initial"] && subformRecordsInitalValues) {
        
        subformRecords=NO;
        
        if (subformrecordArray.count != numberOfSubformRecords) {
            
            [subformrecordArray addObject:[[NSMutableArray alloc]init] ];
            
            
        }
        
    }
    
    if(_baseType == BASE_RESULT) {
        
        if(_resultType == RESULT_DISPLAYNAME) {
            
            if([elementName isEqualToString:@"DisplayName"]) {
                _resultType = RESULT_NONE;
            }
        }
        else if(_resultType == RESULT_FIELDS) {
            
            if(_fieldElementType== FIELD_OPTIONS) {
                
                if([elementName isEqualToString:@"Choices"]) {
                    
                    NSLog(@"Coming to end of choices");
                    _optionsList = [FormParserUtil orderChoices:_optionsList:_optionsListSequence];
                    NSLog(@"Coming to end of choices 1");
                    NSArray *parsedOptions = [FormParserUtil parseOptions:_optionsList];
                    NSLog(@"Coming to end of choices 2");
                    [_zcField setOptions:[parsedOptions objectAtIndex:1]];
                    NSLog(@"Coming to end of choices 3");
                    [_zcField setOptionkeys:[parsedOptions objectAtIndex:0]];
                    NSLog(@"coming end of choices");
                    _fieldElementType = FIELD_NONE;
                }
                else if([elementName isEqualToString:@"onChangeExists"]) {
                    [_zcField setHasOnUserScript:YES];
                }
                else if([elementName isEqualToString:@"formulaExists"]) {
                    [_zcField setHasInvolvedInFormula:YES];
                }
            }
            else if([elementName isEqualToString:@"SubFormFields"]) {
                _subformFields=NO;
                subformRecordsInitalValues=YES;
                numberOfSubformRecords=numberOfSubformRecords+1;
            }
            else {
                if([elementName isEqualToString:@"Fields"]) {
                    noOfFields--;
                    if(noOfFields==0) {
                        _resultType = RESULT_NONE;
                        if([_zcField fieldDisplayName] == nil) {
                            [_zcField setFieldDisplayName:[_zcField fieldName]];
                        }
                        [_zcField setInitialValues:[FormParserUtil convertToHTMLTag:[_zcField initialValues]]];
                        [_zcField setFieldDisplayName:[FormParserUtil convertToHTMLTag:[_zcField fieldDisplayName]]];
                        [_zcForm addZCField:_zcField];
                    }
                }
            }
        }
        else if(_resultType == RESULT_BUTTONS) {
            
            if([elementName isEqualToString:@"buttons"])
            {
                [_zcForm addZCButton:_zcButton];
                _resultType = RESULT_NONE;
            }
        }
        else if(_resultType == RESULT_ERRORLIST) {
            
            if([elementName isEqualToString:@"error"]) {
                [_creatorErrorList addObject:_creatorError];
            }
            else if([elementName isEqualToString:@"errorlist"]) {
                [_zcForm setErrorList:_creatorErrorList];
                _resultType = RESULT_NONE;
            }
        }
        else if([elementName isEqualToString:@"result"]) {
            
            _baseType = BASE_NONE;
        }
    }
    else if(_hasErrorListTag) {
        
        if([elementName isEqualToString:@"error"]) {
            [_creatorErrorList addObject:_creatorError];
        }
        else if([elementName isEqualToString:@"errorlist"]) {
            [_zcForm setErrorList:_creatorErrorList];
            _hasErrorListTag = NO;
        }
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    if([_zcForm isStateful] && [[_zcForm buttons] count] == 0) {
        _zcButton = [[ZCButton alloc] init];
        [_zcButton setButtonActionType:1];
        [_zcButton setButtonDisplayName:@"Submit"];
        [_zcButton setButtonName:@"Submit"];
        [_zcButton setButtonType:62];
        [_zcForm addZCButton:_zcButton];
        _zcButton = [[ZCButton alloc] init];
        [_zcButton setButtonActionType:1];
        [_zcButton setButtonDisplayName:@"Reset"];
        [_zcButton setButtonName:@"Reset"];
        [_zcButton setButtonType:63];
        [_zcForm addZCButton:_zcButton];
        
        _zcButton = [[ZCButton alloc] init];
        [_zcButton setButtonActionType:2];
        [_zcButton setButtonDisplayName:@"Update"];
        [_zcButton setButtonName:@"Update"];
        [_zcButton setButtonType:62];
        [_zcForm addZCButton:_zcButton];
        _zcButton = [[ZCButton alloc] init];
        [_zcButton setButtonActionType:2];
        [_zcButton setButtonDisplayName:[ZCInternationalization getLocaleStringForTitleString:@"ZC_ios_text_Cancel"]];
        [_zcButton setButtonName:[ZCInternationalization getLocaleStringForTitleString:@"ZC_ios_text_Cancel"]];
        [_zcButton setButtonType:64];
        [_zcForm addZCButton:_zcButton];
    }
    //    NSLog(@"zcfieds subformrecs1111 %i",[subformrecordArray count]);
    
    
    if (subformrecordArray.count) {
        int numberoffields= [_zcForm fields].count;
        int subformrecsindex=0;
        
        for (int fieldindex=0;fieldindex<numberoffields;fieldindex++ ) {
            
            if([[[_zcForm fields]objectAtIndex:fieldindex]fieldType ]== [ZCFieldList ZCSubform] || [[[_zcForm fields]objectAtIndex:fieldindex]fieldType ]== [ZCFieldList ZCNewSubform])
            {
                [[[_zcForm fields]objectAtIndex:fieldindex]setSubformRecords:[subformrecordArray objectAtIndex:subformrecsindex]];
                subformrecsindex++;
                
            }
        }
    }
}

@end

/****
 
 private implementation
 
 ****/

@implementation FormParser (hidden)

- (void) formParserXML  {
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[_xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldProcessNamespaces:NO];
    [_xmlParser setShouldReportNamespacePrefixes:NO];
    [_xmlParser setShouldResolveExternalEntities:NO];
    [_xmlParser parse];
}



@end











