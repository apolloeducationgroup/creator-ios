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
     MULTILINE=2,
     EMAIL=3,
     RICHTEXT=4,
     IMAGE=18,
     URL=17,
     NUMBER=5,
     DECIMAL=6,
     PERCENTAGE=7,
     CURRENCY=8,
     DROPDOWN=12,
     RADIO=13,
     CHECKBOX=15,
     MULTISELECT=14,
     DATE=10,
     DATETIME=11,
     DECISIONBOX=16,
     LOOKUPDROPDOWN=12,
     LOOKUPRADIO=13,
     LOOKUPCHECKBOX=15,
     LOOKUPMULTISELECT=14,
     FILEUPLOAD=19,
     CRM=22,
     SUBFORM=21,
     NEW_SUBFORM=23,
     NOTES=24,
     VIEWMULTI=13,
     AUTONUMBER=9,
     FORMULA=20,
     NEW_DROPDOWN=12,
     EXTERNAL=23,
     PAYMENT=511,
     
     NEW_DISPLAY_DROPDOWN = 12,
     NEW_DISPLAY_RADIO = 13,
     NEW_DISPLAY_CHECKBOX=15,
     NEW_DISPLAY_MULTISELECT=14,
    
    /*
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
    CRM=22,
    SUBFORM=21,
    NEW_SUBFORM=23,
    NOTES=24,
    VIEWMULTI=13,
    AUTONUMBER=31,
    FORMULA=20,
    NEW_DROPDOWN=29,
    EXTERNAL=95,
    PAYMENT=511,
    
    NEW_DISPLAY_DROPDOWN = 1100,
    NEW_DISPLAY_RADIO = 1101,
    NEW_DISPLAY_CHECKBOX=1102,
    NEW_DISPLAY_MULTISELECT=1103,
     
 old List      */
    
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
+ (int) ZCPayment;

+ (BOOL) isSkipField : (NSInteger) fieldType;
+ (NSInteger) getFieldInteger : (NSString*) fieldString;

@end
