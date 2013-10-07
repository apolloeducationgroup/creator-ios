//
//  ZCFieldList.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 02/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>

enum FIELDLIST {
    
    SINGLELINE=1,
    MULTILINE=3,
    EMAIL=4,
    RICHTEXT=24,
    IMAGE=20,
    URL=21,
    NUMBER=5,
    DECIMAL=5,
    PERCENTAGE=7,
    CURRENCY=6,
    DROPDOWN=100,
    RADIO=101,
    CHECKBOX=103,
    MULTISELECT=102,
    DATE=10,
    DATETIME=22,
    DECISIONBOX=9,
    LOOKUPDROPDOWN=100,
    LOOKUPRADIO=101,
    LOOKUPCHECKBOX=102,
    LOOKUPMULTISELECT=103,
    FILEUPLOAD=18,
    CRM=25,
    SUBFORM=99,
    NEW_SUBFORM=23,
    NOTES=14,
    VIEWMULTI=13,
    AUTONUMBER=31,
    FORMULA=15,
    NEW_DROPDOWN=29,
    EXTERNAL=95,
    
    NEW_DISPLAY_DROPDOWN = 1100,
    NEW_DISPLAY_RADIO = 1101,
    NEW_DISPLAY_CHECKBOX=1102,
    NEW_DISPLAY_MULTISELECT=1103,
};

@interface ZCFieldList : NSObject

+ (int) ZCSingleLine;
+ (int) ZCMultiLine;
+ (int) ZCEmail;
+ (int) ZCRichText;
+ (int) ZCImage;
+ (int) ZCURL;
+ (int) ZCNumber;
+ (int) ZCDecimal;
+ (int) ZCPercentage;
+ (int) ZCCurrency;
+ (int) ZCDropdown;
+ (int) ZCRadio;
+ (int) ZCCheckbox;
+ (int) ZCMultiSelect;
+ (int) ZCDate;
+ (int) ZCDateTime;
+ (int) ZCDecisionBox;
+ (int) ZCLookupRadio;
+ (int) ZCLookupDropDown;
+ (int) ZCLookupCheckbox;
+ (int) ZCLookupMultiSelect;
+ (int) ZCFileupload;
+ (int) ZCCrm;
+ (int) ZCSubform;
+ (int) ZCNewSubform;
+ (int) ZCNotes;
+ (int) ZCAutoNumber;
+ (int) ZCNewDropDown;
+ (int) ZCExternal;
+ (int) ZCNewRadio;
+ (int) ZCNewCheckbox;
+ (int) ZCNewMultiSelect;

+ (BOOL) isSkipField : (NSInteger) fieldType;
+ (NSInteger) getFieldInteger : (NSString*) fieldString;

@end
