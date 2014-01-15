//
//  ZCField.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCComponent,ZCForm;

@interface ZCField : NSObject

@property (nonatomic,retain) NSString *fieldName;
@property (nonatomic) NSInteger fieldType;
@property (nonatomic,retain) NSString *fieldDisplayName;
@property (nonatomic,retain) NSString *toolTip;
@property (nonatomic) BOOL isRequired;
@property (nonatomic) BOOL isUnique;
@property (nonatomic) BOOL isAdminOnly;
@property (nonatomic) BOOL isLookupField;
@property (nonatomic) BOOL hasAllowNewEntries;
@property (nonatomic,retain) id initialValues;
@property (nonatomic) NSInteger maxCharacter;
@property (nonatomic,retain) NSMutableArray *options;
@property (nonatomic,retain) NSMutableArray *optionkeys;
@property (nonatomic,retain) ZCComponent *relatedComponent;
@property (nonatomic,retain) NSString *relatedFieldName;
@property  BOOL hasOnUserScript;
@property  BOOL hasSubFormAddEvent;
@property  BOOL hasSubFormDeleteEvent;
@property BOOL hasSubFormOnUserScript;
@property BOOL hasInvolvedInFormula;
//@property BOOL hasDynamicpicklistexists;
@property BOOL isHidden;
@property BOOL isUrlLinkName;
@property BOOL isUrlTitle;
@property BOOL hasVisiblity;
@property (nonatomic,retain) ZCForm *subForm;
@property (nonatomic,retain) NSString *addNewLinkText;
@property (nonatomic,retain) NSMutableArray * subformRecords;
@property (nonatomic) NSInteger decimalLength;
@property (nonatomic) NSInteger currencyType;
@property (nonatomic,retain) NSString *currencyDisplay;
@property (nonatomic,retain) NSString *currencyName;
@property(nonatomic,assign) NSInteger hasmaximumNumberOfRows;
@property (nonatomic,assign) NSInteger defaultRows;
@property (nonatomic,assign) NSInteger imageInputType;
@property (nonatomic,assign) BOOL hasfilter;
@property (nonatomic,assign) BOOL isHiddenField;
-(ZCField*) initZCField;

@end
