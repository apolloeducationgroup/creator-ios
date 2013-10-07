//
//  ZCSectionParser.m
//  ZohoCreator
//
//  Created by Vishnukumar on 14/09/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "EditRecordParser.h"
#import "ZCRecordStatus.h"

/**** start of private interface for the current class ****/

@interface EditRecordParser (hidden)

- (void) parseScriptXML;

@end

/**** end of private interface for the current class ****/

@implementation EditRecordParser

@synthesize recordStatus=_recordStatus;

- (EditRecordParser*) initRecordParser:(NSString *)xmlString : (ZCForm*) form;
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

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {
    
    if(_updateElementTag == YES) {
        
        if(_newvalueElementTag == YES) {
            
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
                }
            }
        }
        else if(_criteriaElementTag == YES) {
            
            if([elementName isEqualToString:@"field"])  {
                
                criteria = [[ZCCriteria alloc] init];
                [criteria setFieldName:[attributeDict objectForKey:@"name"]];
                [criteria setValue:[attributeDict objectForKey:@"value"]];
                [criteria  setOperator:[ZCCriteriaUtil getOperatorNumber:[attributeDict objectForKey:@"compOperator"]]];
            }
        }
        else {
            if([elementName isEqualToString:@"newvalues"]) {
                _newvalueElementTag = YES;
            }
            else if([elementName isEqualToString:@"criteria"]) {
                _criteriaElementTag = YES;
            }
        }
    }
    else {
        if([elementName isEqualToString:@"update"]) {
            _record = [[ZCRecord alloc] init];
            _updateElementTag = YES;
            [_recordStatus setSuccess:YES];
        }
    }
    _currentElementName = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(_criteriaElementTag == YES) {
        
        if([_currentElementName isEqualToString:@"reloperator"]) {
            
            if([string isEqualToString:@"And"]) {
                _relOperator = [ZCCriteriaUtil AND_OPERATOR];
            }
            else if([string isEqualToString:@"Or"]) {
                _relOperator = [ZCCriteriaUtil OR_OPERATOR];
            }
            else {
                _relOperator = [ZCCriteriaUtil NONE_OPERATOR];
            }
        }
    }
    else if(_fieldElementTag == YES) {
        
        if(_optionElementTag == YES) {
            
            [optionList addObject:string];
        }
        else {
            [_field setFieldValue:string];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if(_updateElementTag == YES) {
        
        if(_newvalueElementTag == YES) {
            
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
                        [_record addZCFieldData:_field];
                        _fieldElementTag = NO;
                    }
                }
            }
            else {
                if([elementName isEqualToString:@"newvalues"]) {
                    _newvalueElementTag = NO;
                }
            }
        }
        else if(_criteriaElementTag==YES) {
            
            if([elementName isEqualToString:@"field"]) {
                
                if(_relOperator==-1) {
                    
                }
                else if(_relOperator==[ZCCriteriaUtil AND_OPERATOR] || _relOperator==[ZCCriteriaUtil AND_OPERATOR]) {
                    _relOperator = -1;
                    //                    [criteria setRelation:_relOperator];
                    //                    [criteria setCriteria:criteria];
                }
                _criteriaField = NO;
            }
            if([elementName isEqualToString:@"criteria"]) {
                _criteriaElementTag = NO;
            }
        }
        else {
            if([elementName isEqualToString:@"update"]) {
                [_record setForm:_form];
                [_recordStatus setSuccess:YES];
                [_recordStatus setRecord:_record];
                [_recordStatus setCriteria:criteria];
                _updateElementTag = NO;
            }
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
}

@end

/****
 
 start of private implementation for the current class
 
 ****/

@implementation EditRecordParser (hidden)

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
