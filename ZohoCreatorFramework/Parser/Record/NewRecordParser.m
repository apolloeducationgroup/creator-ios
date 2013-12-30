//
//  ZCSectionParser.m
//  ZohoCreator
//
//  Created by Vishnukumar on 14/09/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "NewRecordParser.h"
#import "ScriptJSONParser.h"

/**** start of private interface for the current class ****/

@interface NewRecordParser (hidden)

- (void) parseScriptXML;
-(void)generateSubformError:(NSString *) OriginalErrorString :(NSString *)errorFieldName;


@end

/**** end of private interface for the current class ****/

@implementation NewRecordParser

@synthesize recordStatus=_recordStatus;

- (NewRecordParser*) initRecordParser:(NSString *)xmlString : (ZCForm*) form;
{
    self = [super init];
    if(self) {
        self->_xmlString = xmlString;
        self->_recordStatus = [[ZCRecordStatus alloc] init];
        [self->_recordStatus setSuccess:NO];
        self->_form = form;
    }
    [self parseScriptXML];
    return self;
}

- (NewRecordParser*) initRecordParser:(NSString *)xmlString
{
    self = [super init];
    if(self) {
        self->_xmlString = xmlString;
        self->_recordStatus = [[ZCRecordStatus alloc] init];
        [self->_recordStatus setSuccess:NO];
    }
    [self parseScriptXML];
    return self;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {
    
    NSLog(@"element name %@",elementName);
    if(_addElementTag == YES || _updateElementTag==YES || _deleteElementTag == YES ) {
        
        if(_valueElementTag == YES) {
            
            if(_fieldElementTag == YES ) {
                
                if(_optionsElementTag == YES) {
                    
                    if([elementName isEqualToString:@"option"]) {
                        _optionElementTag = YES;
                    }
                }
                else
                {
                    if([elementName isEqualToString:@"options"]) {
                        _optionsElementTag = YES;
                        optionList = [[NSMutableArray alloc] init];
                    }
                }
            }
            else {
                if([elementName isEqualToString:@"field"]) {
                    _field = [[ZCFieldData alloc] init];
                    [_field setFieldName:[attributeDict objectForKey:@"name"]];
                    _fieldElementTag = YES;
                    //// //NSLog(@" field name %@",[_field fieldName]);
                }
            }
        }
        else if(_openURLTag==YES)
        {
            if([elementName isEqualToString:@"url"]) {
                _openURLURLTag=YES;
                NSLog(@"openURl url");
                
            }
            
            if ([elementName isEqualToString:@"type"]) {
                
                _openURLTypeTag=YES;
            }
            
        }
        
        else {
            NSLog(@"Coming to value tag in values  %@",elementName);
            if([elementName isEqualToString:@"values"]) {
                _valueElementTag = YES;
            }
            
            else if([elementName isEqualToString:@"status"]) {
                _statusElementTag = YES;
            }
            
            else if([elementName isEqualToString:@"combinedlookupvalue"]) {
                _combinedlookupvalueTag = YES;
            }
            else if([elementName isEqualToString:@"openurl"]) {
                _openURLTag = YES;
                 _recordStatus.openUrltask= [[OpenUrlTask alloc] init];
                [_recordStatus.openUrltask setTaskType:@"openurl"];
                NSLog(@"openurltask_ %@",_recordStatus.openUrltask);

            }


        }
        

        
    }
    else if(_errorList == YES) {
        
        if(_error == YES) {
            
            if([elementName isEqualToString:@"code"]) {
                _errorCode = YES;
            }
            else if([elementName isEqualToString:@"message"]) {
                _errorMessage = YES;
            }
        }
        else {
            if([elementName isEqualToString:@"error"]) {
                _error = YES;
            }
        }
    }
    else {
        if([elementName isEqualToString:@"add"]) {
            //// //NSLog(@"Record has Init");
            _record = [[ZCRecord alloc] initZCRecord];
            _addElementTag = YES;
        }
        else if([elementName isEqualToString:@"update"]) {
            _record = [[ZCRecord alloc] initZCRecord];
            _updateElementTag = YES;
        }
        else if ([elementName isEqualToString:@"delete"])
        {
        
            
            _record = [[ZCRecord alloc] initZCRecord];
            _deleteElementTag = YES;
        
        }
        else if([elementName isEqualToString:@"errorlist"]) {
            _errorList = YES;
            _zcRecordError = [[ZCRecordError alloc] init];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    
    
    if(_errorList == YES) {
        
        if(_error==YES) {
            
            if(_errorCode==YES) {
                
                [_zcRecordError setErrorCode:string];
            }
            else if(_errorMessage==YES) {
                ////// //NSLog(@"Error Message  %@",string);
                [_zcRecordError setErrorMessage:string];
            }
        }
    }
    else if (_combinedlookupvalueTag ==YES)
    {
        
        [_recordStatus addvalueToSelectedLookUpValueDict:string key:[[[_record record]objectForKey:@"ID"]fieldValue ]  ];
        
    }
    else if ( _openURLTypeTag==YES)
    {
        NSLog(@"openurl tag %@",string);
        [_recordStatus.openUrltask setWindowType:string];
        _openURLTypeTag=NO;
    }
    else if (_openURLURLTag ==YES)
        
    {
    
//        [_recordStatus.openUrltask setUrlString:string];
        
        _recordStatus.openUrltask =[ScriptJSONParser setopenURLTaskparameters:_recordStatus.openUrltask urlString:string];
        
        
        _openURLURLTag=NO;
    }
    else if(_statusElementTag == YES) {
        NSLog(@"Status Element Tag is coming");
        if([string isEqualToString:@"Success"]) {
            [_recordStatus setSuccess:YES];
        }
        else {
            [_recordStatus setSuccess:NO];
            _zcRecordError = [[ZCRecordError alloc] init];
            [_zcRecordError setErrorCode:@"-1"];
            [_zcRecordError setErrorMessage:string];
            
            
            NSRange srange = [string rangeOfString:@","];
            
            if(srange.length != 0) {
                
                NSRange range;
                range.location =srange.location + 1;
                range.length = [string length] - (srange.location + 1);
                NSString *OriginalErrorString =[NSString stringWithString:string];
                NSString *errorMessage = [string substringWithRange:range];
                errorMessage = [errorMessage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                ;
                ////// //NSLog(@"error msggggggg %@",errorMessage);
                
                NSRange nextrange;
                NSRange fieldrange = [errorMessage rangeOfString:@"*"];
                if (errorMessage.length>fieldrange.location)
                {
                    do
                    {
                        NSRange fieldrange = [errorMessage rangeOfString:@"*"];
                        NSString *errorFieldName = [[errorMessage substringToIndex:fieldrange.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                        NSString *fieldErrorMessage;
                        
                        ////// //NSLog(@"11 error Fieldname  %@",errorFieldName);
                        
                        nextrange = [errorMessage rangeOfString:@","];
                        
                        if (nextrange.length != 0 ) {
                            NSRange newRange;
                            newRange.location = fieldrange.location + 1;
                            newRange.length = nextrange.location  - (fieldrange.location-1) - 2;
                            fieldErrorMessage = [errorMessage substringWithRange:newRange];
                            errorMessage = [errorMessage substringFromIndex:nextrange.location+1];
                            ////// //NSLog(@"Error Message %@",errorMessage);
                        }
                        else {
                            fieldErrorMessage = [errorMessage substringFromIndex:fieldrange.location+1];
                            ////// //NSLog(@"Else error mess %@",fieldErrorMessage);
                        }
                        //  ////// //NSLog(@"errrrrrrrrrr   %@",errorFieldName);
                        
                        
                        
//                        SF(SubForm).FD(t::row_1).SV(Number)*Enter a valid number for Number ,
//                        SF(SubForm).FD(t::row_2).SV(Number)*Enter a valid number for Number

//                            NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES 'subFormDetails(.*)\\.formData(.*)\\.singleValuedParam(.*)'"];
                        
                        
//                            NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES 'SF((.*)\\).FD(t::row_(.*)\\).SV((.*)\\)'"];
//                        BOOL result1 = [predicate1 evaluateWithObject:errorFieldName];
                        
                        
//                        NSRegularExpression *regexp_View = [NSRegularExpression regularExpressionWithPattern: @"SF(.*\\"options:NSRegularExpressionCaseInsensitive error:NULL];
//                        NSLog(@"fsa");
                        
                        
                        if (errorFieldName.length>4) {
                            NSRange rang;
                            rang.location=0;
                            rang.length=3;
                            if ([[errorFieldName substringWithRange:rang]isEqualToString:@"SF(" ]) {
                                
                                [self setSubformFieldErrors:errorFieldName errorMsg:fieldErrorMessage];
                                
                                //                                [self generateSubformError:OriginalErrorString :errorFieldName] ;
                            }
                        }
                        
                        //
                        ////                        NSRegularExpression *regexp_View = [NSRegularExpression regularExpressionWithPattern: @"<div elName='zc-component' viewLinkName='(.*)\\' params='(.*)\\</div>"options:NSRegularExpressionCaseInsensitive error:NULL];
                        //
                        //                        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES 'FD(t::row_(.*)\\).SV((.*)\\)'"];
                        ////                        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES 'formData(.*)\\.singleValuedParam(.*)'"];
                        //                        BOOL result2=[predicate2 evaluateWithObject:errorFieldName];
                        //                        NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"SELF MATCHES 'SV((.*)\\)'"];
                        ////                        NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"SELF MATCHES 'singleValuedParam(.*)'"];
                        //                        BOOL result3=[predicate3 evaluateWithObject:errorFieldName];
                        //
                        //
                        ////                        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES 'subFormDetails(.*)\\.formData(.*)\\.singleValuedParam(.*)'"];
                        ////                        BOOL result1 = [predicate1 evaluateWithObject:errorFieldName];
                        ////
                        ////                        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES 'formData(.*)\\.singleValuedParam(.*)'"];
                        ////                        BOOL result2=[predicate2 evaluateWithObject:errorFieldName];
                        ////
                        ////                        NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"SELF MATCHES 'singleValuedParam(.*)'"];
                        ////                        BOOL result3=[predicate3 evaluateWithObject:errorFieldName];
                        
                        ////// //NSLog(@"checked msg \n\n %@  \n\n %@ \n\n %@",errorMessage,errorFieldName,fieldErrorMessage);
                        
                        if ([errorFieldName isEqualToString:@"null"] ) {
                            //----------------------->> supposed to be subform error API mistake  [generalErrorlist addObject:fieldErrorMessage];
                        }
                        else
                        {
                            
                            
                            if (errorFieldName.length>4) {
                                NSRange rang;
                                rang.location=0;
                                rang.length=3;
                                if (![[errorFieldName substringWithRange:rang]isEqualToString:@"SF(" ])
                                {
                                    ZCFieldError *fieldError = [[ZCFieldError alloc] init];
                                    [fieldError setFieldName:errorFieldName];
                                    [fieldError setErrorMessage:fieldErrorMessage];
                                    [_zcRecordError addFieldError:fieldError];
                                    
                                    //                                [self getsubform:errorFieldName];
//                                    NSLog(@"errrr %@ %@  %@",errorFieldName,fieldErrorMessage,fieldError);
                                }
                                
                            }
                            
                            else
                                
                            {
                                ZCFieldError *fieldError = [[ZCFieldError alloc] init];
                                [fieldError setFieldName:errorFieldName];
                                [fieldError setErrorMessage:fieldErrorMessage];
                                [_zcRecordError addFieldError:fieldError];
                                
                                //                                [self getsubform:errorFieldName];
//                                NSLog(@"errrr %@ %@  %@",errorFieldName,fieldErrorMessage,fieldError);

                            
                            }
                            
                        }
                    }
                    ////// //NSLog(@" next Range %d",nextrange.length);
                    
                    
                    
                    
                    while (nextrange.length != 0);
                    
                }
                else {
                    
                    [[_zcRecordError generalErrorList] addObject:errorMessage];
                    
                }
                
            }
            [_recordStatus setError:_zcRecordError];
        }
        
    }
    else {
        if(_fieldElementTag == YES) {
            
            if(_optionElementTag == YES) {
                
                [optionList addObject:string];
            }
            else {
                //////// //NSLog(@"Setting Value %@",string);
                //// //NSLog(@"Field value has set");
                [_field setFieldValue:string];
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if(_addElementTag == YES) {
        
        if(_valueElementTag == YES) {
            
            if(_fieldElementTag == YES) {
                
                if(_optionsElementTag == YES) {
                    
                    if(_optionElementTag == YES) {
                        
                        if([elementName isEqualToString:@"option"]) {
                            _optionElementTag = NO;
                        }
                    }
                    else {
                        
                        if([elementName isEqualToString:@"options"]) {
                            [_field setFieldValue:optionList];
                            _optionsElementTag = NO;
                        }
                    }
                }
                else {
                    if([elementName isEqualToString:@"field"]) {
                        //// //NSLog(@"Add field to record %@  %@",[_field fieldName],[_field fieldValue]);
                        [_record addZCFieldData:_field];
                        _fieldElementTag = NO;
                    }
                }
            }
            else {
                if([elementName isEqualToString:@"values"]) {
                    _valueElementTag = NO;
                }
            }
        }
        else if(_statusElementTag   == YES) {
            if([elementName isEqualToString:@"status"]) {
                _statusElementTag = NO;
            }
        }
        else {
            if([elementName isEqualToString:@"add"]) {
                [_record setForm:_form];
                [_recordStatus setRecord:_record];
                //// //NSLog(@"Record has setted in status object %@",_record);
                _addElementTag = NO;
            }
            else if([elementName isEqualToString:@"update"]) {
                [_record setForm:_form];
                [_recordStatus setRecord:_record];
                //// //NSLog(@"Record has setted in status object %@",_record);
                _updateElementTag = NO;
            }
            
            else if([elementName isEqualToString:@"delete"]) {
                [_record setForm:_form];
                [_recordStatus setRecord:_record];
                //// //NSLog(@"Record has setted in status object %@",_record);
                _deleteElementTag = NO;
            }
            else if([elementName isEqualToString:@"combinedlookupvalue"]) {
                [_record setForm:_form];
                [_recordStatus setRecord:_record];
                //// //NSLog(@"Record has setted in status object %@",_record);
                _combinedlookupvalueTag = NO;
            }
            else if([elementName isEqualToString:@"openurl"]) {
                _openURLTag = NO;
                
            }
            

            

        }
    }
    else if(_errorList==YES) {
        
        if(_error==YES) {
            
            if(_errorCode == YES) {
                _errorCode = NO;
            }
            else if(_errorMessage == YES) {
                _errorMessage = NO;
            }
            if([elementName isEqualToString:@"error"]) {
                _error = NO;
            }
        }
        else {
            if([elementName isEqualToString:@"errorlist"]) {
                _errorList = NO;
                [_recordStatus setError:_zcRecordError];
            }
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    
    NSLog(@"record error %@ %@",[_zcRecordError fieldErrorList],[_zcRecordError subFormFieldErrorsDictionary]);
    
}

-(void)setSubformFieldErrors:(NSString *)errorname errorMsg:(NSString *)errorMsg

{
//    SF(SubForm).FD(t::row_1).SV(Number)


    NSMutableArray * arra=[[NSMutableArray alloc]initWithArray:[errorname componentsSeparatedByString:@"."]];
    NSMutableString * fieldName=[NSMutableString stringWithString:[arra objectAtIndex:0]];
    NSMutableString * rowNum=[NSMutableString stringWithString:[arra objectAtIndex:1]];
    NSMutableString * subformfieldName=[NSMutableString stringWithString:[arra objectAtIndex:2]];

    NSRange rangF;
    rangF.length=3;
    rangF.location=0;
    [fieldName deleteCharactersInRange:rangF];
    [subformfieldName deleteCharactersInRange:rangF];
    rangF.length=10;
    [rowNum deleteCharactersInRange:rangF];

    NSRange rangL;
    rangL.length=1;
    rangL.location=fieldName.length-1;
    [fieldName deleteCharactersInRange:rangL];
    rangL.location=subformfieldName.length-1;
    [subformfieldName deleteCharactersInRange:rangL];
    rangL.location=rowNum.length-1;
    [rowNum deleteCharactersInRange:rangL];

    NSLog(@"arr osdfsa %@ %@ %@",fieldName,subformfieldName,rowNum);
        
    ZCSubFormFieldError * subformFieldError=[[ZCSubFormFieldError alloc ]init];
    [subformFieldError setSubFormLinkname:fieldName];
    [subformFieldError setRecordRowinSubform:[rowNum integerValue]];
    [subformFieldError setFieldName:subformfieldName];
    [subformFieldError setErrorMessage:errorMsg];
    
    NSLog(@"subformFielderror   \n\n %@  \n\n %@  \n\n  %@ %@",fieldName,rowNum,subformfieldName,errorMsg);
    
    [_zcRecordError addSubFormFieldFieldError:subformFieldError];
}
@end

/****
 
 start of private implementation for the current class
 
 ****/

@implementation NewRecordParser (hidden)

- (void) parseScriptXML  {
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[_xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldProcessNamespaces:NO];
    [_xmlParser setShouldReportNamespacePrefixes:NO];
    [_xmlParser setShouldResolveExternalEntities:NO];
    [_xmlParser parse];
}
-(void)generateSubformError:(NSString *) OriginalErrorString :(NSString *)errorFieldName

{
    //  ////// //NSLog(@"result  %i   \n  ",result1,errorFieldName);
    
    // formData(template::row_1).singleValuedParam(Mobile_number)*Enter a valid number for  Mobile number. Email_1*Enter a valid email address for  Email 1
    
    
NSLog(@"\n\n  eeror mrgsubform    \n\n  %@  \n\n   %@\n\n  \n",OriginalErrorString,errorFieldName);
    
    
    NSRange fieldrange = [OriginalErrorString rangeOfString:errorFieldName];
    NSString *intermediate = [[OriginalErrorString substringFromIndex:fieldrange.location+fieldrange.length+1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSRange endrange = [intermediate rangeOfString:@"."];
    
    ////// //NSLog(@"inter medi   %@     %i",intermediate,endrange.location);
    NSString * ErrorMessageForSubform;
    if (endrange.location<=intermediate.length)
    {
        ErrorMessageForSubform   =[intermediate substringToIndex:endrange.location];
    }
    else
        ErrorMessageForSubform=[NSString stringWithString:intermediate];
    
    
    //  ////// //NSLog(@"final sirn   \n\n\n\n\n %@\n\n\n\n\n\n",ErrorMessageForSubform);
    
    NSArray *subformParmaRray=[errorFieldName componentsSeparatedByString:@"."];
    
    NSString *subFormDetails;
    int  formRecordRow;
    NSString * singleValuedParam;
    
    ////// //NSLog(@"subformparmArray %@ ",subformParmaRray);
    for (int j=0; j<subformParmaRray.count; j++)
        
    {
        
        NSRange fieldrange = [[subformParmaRray objectAtIndex:j ] rangeOfString:@"("];
        
        NSString *intermediate = [[[subformParmaRray objectAtIndex:j ] substringFromIndex:fieldrange.location+1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        NSRange endrange = [intermediate rangeOfString:@")"];
        NSString * errorname=[intermediate substringToIndex:endrange.location];
        
        if (j==0) {
            
            
            subFormDetails=[NSString stringWithString:errorname];
            
        }
        else if (j==1)
        {
            NSRange fieldrange = [[subformParmaRray objectAtIndex:j ] rangeOfString:@"template::row_"];
            
            NSString *intermediate = [[[subformParmaRray objectAtIndex:j ]  substringFromIndex:fieldrange.location+fieldrange.length] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSRange endrange = [intermediate rangeOfString:@")"];
            NSString * errorname=[intermediate substringToIndex:endrange.location];
            formRecordRow= [errorname integerValue]-1;
            
            
        }
        
        else if (j==2)
        {
            singleValuedParam=[NSString stringWithString:errorname];
            
            
        }
        
    }
    
    ZCSubFormFieldError * subformFieldError=[[ZCSubFormFieldError alloc ]init];
    [subformFieldError setSubFormLinkname:subFormDetails];
    [subformFieldError setRecordRowinSubform:formRecordRow];
    [subformFieldError setFieldName:singleValuedParam];
    [subformFieldError setErrorMessage:ErrorMessageForSubform];
    
    ////// //NSLog(@"subformFielderror   \n\n %@  \n\n %i \n\n %@  \n\n  %@",subFormDetails,formRecordRow,singleValuedParam,ErrorMessageForSubform);
    
    [_zcRecordError addSubFormFieldFieldError:subformFieldError];
    
}

@end

/****
 
 end of private implementation for the current class
 
 ****/
