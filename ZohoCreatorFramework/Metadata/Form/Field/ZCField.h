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
@property (nonatomic) BOOL isRequired;
@property (nonatomic,retain) NSString *initialValues;
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
@property BOOL isHidden;
@property (nonatomic,retain) ZCForm *subForm;
@property (nonatomic,retain) NSString *addNewLinkText;
@property (nonatomic,retain) NSString *currencyType;
@property (nonatomic,retain) NSMutableArray * subformRecords;
-(ZCField*) initZCField;

@end
