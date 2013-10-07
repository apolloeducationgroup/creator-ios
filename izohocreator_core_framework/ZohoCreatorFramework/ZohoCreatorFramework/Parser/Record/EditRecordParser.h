//
//  ScriptParser.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCCriteriaUtil.h"

@class ZCCriteria,ZCFieldData,ZCForm,ZCRecord,ZCRecordStatus;

@interface EditRecordParser : NSObject <NSXMLParserDelegate> {
    
@private NSXMLParser *_xmlParser;
@private NSString *_xmlString;
@private NSString *_currentElementValue;
@private NSString *_currentElementName;
@private BOOL _updateElementTag;
@private BOOL _newvalueElementTag;
@private BOOL _fieldElementTag;
@private BOOL _optionElementTag;
@private BOOL _optionsElementTag;
@private BOOL _criteriaElementTag;
@private BOOL _relOperator;
@private BOOL _criteriaField;
@private ZCCriteria *criteria;
@private NSMutableArray *optionList;
@private ZCRecord *_record;
@private ZCFieldData *_field;
@private ZCForm *_form;
}

@property (nonatomic,retain) ZCRecordStatus *recordStatus;

- (EditRecordParser*) initRecordParser : (NSString*) xmlString : (ZCForm*) form;

@end