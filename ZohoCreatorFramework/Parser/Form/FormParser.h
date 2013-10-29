//
//  FormParser.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParserUtil.h"
#import "ZCForm.h"
#import "ZCField.h"
#import "ZCButton.h"
#import "FormParserUtil.h"
#import "ZCInternationalization.h"
#import "ZOHOCreatorError.h"

@class ZCForm;


enum RESULT
{
    RESULT_DISPLAYNAME=1,
    RESULT_FIELDS=2,
    RESULT_BUTTONS=3,
    RESULT_SUCESSMESSAGE=4,
    RESULT_ERRORLIST=5,
    RESULT_NONE=-1,
};

enum BASE_ELEMENT
{
    BASE_RESULT=1,
    BASE_NONE=-1,
};

enum FIELD_ELEMENT
{
    FIELD_OPTIONS = 1,
    FIELD_NONE = -1,
};

@interface FormParser : NSObject  <NSXMLParserDelegate>  {
    
@private
    NSXMLParser *_xmlParser;
    NSString *_xmlString;
    NSString *_currentElementName;
    NSInteger _baseType;
    NSInteger _resultType;
    NSInteger _fieldElementType;
    ZCField *_zcField;
    ZCButton *_zcButton;
    NSMutableArray *_optionsList;
    NSMutableArray *_optionsListSequence;
    ZOHOCreatorError *_creatorError;
    NSMutableArray *_creatorErrorList;
    BOOL hasEditOnLoad;
    BOOL hasAddOnLoad;
    BOOL hasSuccessMessage;
    BOOL hasDateFormat;
    BOOL hasTableName;
    NSInteger _optionCurrentIndex;
@private
    NSInteger noOfFields;
    BOOL fieldOpen;
    BOOL _newOption;
    BOOL _hasErrorListTag;
    BOOL _subformFields;
    NSString *_tableName;
    
    int numberOfSubformRecords;
    NSString * _subformrecordElementName;
    NSMutableArray * subformrecordArray;
    BOOL subformRecords;
    BOOL subformRecordsInitalValues;
    
}

@property (nonatomic,retain) ZCForm* zcForm;

- (FormParser*) initFormParser:(NSString *) xmlString  : (ZCComponent*) component;

@end

