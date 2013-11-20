//
//  ScriptParser.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCRecord.h"
#import "ZCFieldData.h"
#import "ZCRecordStatus.h"
#import "ZCRecordError.h"
#import "ZCFieldError.h"
#import "ZCForm.h"
#import "ZCSubFormFieldError.h"

@class ZCRecordStatus;

@interface NewRecordParser : NSObject <NSXMLParserDelegate> {
    
@private NSXMLParser *_xmlParser;
@private NSString *_xmlString;
@private NSString *_currentElementValue;
@private NSString *_currentElementName;
@private BOOL _addElementTag;
@private BOOL _valueElementTag;
@private BOOL _fieldElementTag;
@private BOOL _optionElementTag;
@private BOOL _optionsElementTag;
@private BOOL _statusElementTag;
@private BOOL _updateElementTag;
@private BOOL _deleteElementTag;
@private BOOL _errorList;
@private BOOL _error;
@private BOOL _errorCode;
@private BOOL _errorMessage;
@private NSMutableArray *optionList;
@private ZCRecord *_record;
@private ZCFieldData *_field;
@private ZCForm *_form;
@private ZCRecordError *_zcRecordError;
@private BOOL _combinedlookupvalueTag;
@private NSMutableDictionary * lookupDataDict;
}

@property (nonatomic,retain) ZCRecordStatus *recordStatus;
- (NewRecordParser*) initRecordParser : (NSString*) xmlString : (ZCForm*) form;
- (NewRecordParser*) initRecordParser:(NSString *)xmlString;

@end