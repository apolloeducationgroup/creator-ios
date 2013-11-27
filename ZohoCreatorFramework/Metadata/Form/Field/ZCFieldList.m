//
//  ZCFieldList.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 02/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCFieldList.h"

@implementation ZCFieldList

+ (int) ZCSingleLine {
    return SINGLELINE;
}

+ (int) ZCMultiLine {
    return MULTILINE;
}

+ (int) ZCEmail {
    return EMAIL;
}

+ (int) ZCAutoNumber {
    return AUTONUMBER;
}

+ (int) ZCRichText {
    return RICHTEXT;
}

+ (int) ZCImage {
    return IMAGE;
}

+ (int) ZCURL {
    return URL;
}

+ (int) ZCNumber {
    return NUMBER;
}

+ (int) ZCDecimal {
    return DECIMAL;
}

+ (int) ZCPercentage {
    return PERCENTAGE;
}

+ (int) ZCCurrency {
    return CURRENCY;
}

+ (int) ZCDropdown {
    return DROPDOWN;
}

+ (int) ZCRadio {
    return RADIO;
}

+ (int) ZCCheckbox {
    return CHECKBOX;
}

+ (int) ZCMultiSelect {
    return MULTISELECT;
}

+ (int) ZCDate {
    return DATE;
}

+ (int) ZCDateTime {
    return DATETIME;
}

+ (int) ZCDecisionBox {
    return DECISIONBOX;
}

+ (int) ZCLookupRadio {
    return LOOKUPRADIO;
}

+ (int) ZCLookupDropDown {
    return LOOKUPDROPDOWN;
}

+ (int) ZCLookupMultiSelect {
    return LOOKUPMULTISELECT;
}

+ (int) ZCLookupCheckbox {
    return LOOKUPCHECKBOX;
}


+ (int) ZCFileupload {
    return FILEUPLOAD;
}

+ (int) ZCCrm {
    return CRM;
}

+ (int) ZCSubform {
    return SUBFORM;
}

+ (int) ZCNewSubform {
    return NEW_SUBFORM;
}


+ (int) ZCNotes {
    return NOTES;
}

/*+ (int) ZCNewDropDown {
 return NEW_DISPLAY_+DROPDOWN;
 }*/

+ (int) ZCFormula {
    return FORMULA;
}

+ (int) ZCExternal {
    return EXTERNAL;
}

+ (int) ZCNewDropDown {
    return NEW_DISPLAY_DROPDOWN;
}

+ (int) ZCNewRadio {
    return NEW_DISPLAY_RADIO;
}

+ (int) ZCNewCheckbox {
    return NEW_DISPLAY_CHECKBOX;
}

+ (int) ZCNewMultiSelect {
    return NEW_DISPLAY_MULTISELECT;
}

+ (int)ZCPayment {
    return PAYMENT;
}

+ (BOOL) isSkipField : (NSInteger) fieldType {
    
    if(fieldType == [ZCFieldList ZCAutoNumber] || fieldType == [ZCFieldList ZCFormula] || fieldType==[ZCFieldList ZCCrm] || fieldType == [ZCFieldList ZCExternal]) {
        //        if(fieldType == [ZCFieldList ZCAutoNumber] || fieldType==[ZCFieldList ZCCrm] || fieldType == [ZCFieldList ZCExternal]) {
        
        return YES;
    }
    else {
        return NO;
    }
}

+ (NSInteger) getFieldInteger : (NSString*) fieldString {
    
    if([fieldString isEqualToString:@"TEXT"]) {
        return [ZCFieldList ZCSingleLine];
    }
    else if([fieldString isEqualToString:@"TEXT_AREA"]) {
        return [ZCFieldList ZCMultiLine];
    }
    else if([fieldString isEqualToString:@"EMAIL_ADDRESS"]) {
        return [ZCFieldList ZCEmail];
    }
    else if([fieldString isEqualToString:@"NUMBER"]) {
        return [ZCFieldList ZCNumber];
    }
    else if([fieldString isEqualToString:@"CURRENCY"]) {
        return [ZCFieldList ZCCurrency];
    }
    else if([fieldString isEqualToString:@"PERCENTAGE"]) {
        return [ZCFieldList ZCPercentage];
    }
    else if([fieldString isEqualToString:@"CHECK_BOX"]) {
        return [ZCFieldList ZCDecisionBox];
    }
    else if([fieldString isEqualToString:@"DATE"]) {
        return [ZCFieldList ZCDate];
    }
    else if([fieldString isEqualToString:@"TIME"]) {
        return [ZCFieldList ZCDateTime];
    }
    else if([fieldString isEqualToString:@"SINGLE_SELECT"]||[fieldString isEqualToString:@"INLINE_SINGLE_SELECT"]) {
        return [ZCFieldList ZCDropdown];
    }
    else if([fieldString isEqualToString:@"MULTI_SELECT"]) {
        return [ZCFieldList ZCMultiSelect];
    }
    else if([fieldString isEqualToString:@"PLAIN_TEXT"]) {
        return [ZCFieldList ZCSingleLine];
    }
    else if([fieldString isEqualToString:@"EXTERNAL_FIELD"]) {
        return [ZCFieldList ZCExternal];
    }
    else if([fieldString isEqualToString:@"EXTERNAL_LINK_FIELD"]) {
        return [ZCFieldList ZCExternal];
    }
    else if([fieldString isEqualToString:@"RICH_TEXT_AREA"]) {
        return [ZCFieldList ZCRichText];
    }
    else if([fieldString isEqualToString:@"EXTERNAL_MODULE"]) {
        return -1;
    }
    else if([fieldString isEqualToString:@"FROMTO"]) {
        return -1;
    }
    else if([fieldString isEqualToString:@"FLOAT"]) {
        return [ZCFieldList ZCSingleLine];
    }
    else if([fieldString isEqualToString:@"SCRIPT"]) {
        return [ZCFieldList ZCMultiLine];
    }
    else if([fieldString isEqualToString:@"FILE_UPLOAD"]) {
        return [ZCFieldList ZCFileupload];
    }
    else if([fieldString isEqualToString:@"SYSTEM_LOOKUP"]) {
        return 30;
    }
    else if([fieldString isEqualToString:@"POPUP_SINGLE"]) {
        return [ZCFieldList ZCSubform];
    }
    else if([fieldString isEqualToString:@"PASSWORD"]) {
        return -1;
    }
    else if([fieldString isEqualToString:@"DECIMAL"]) {
        return [ZCFieldList ZCDecimal];
    }
    else if([fieldString isEqualToString:@"URL"]) {
        return [ZCFieldList ZCURL];
    }
    else if([fieldString isEqualToString:@"DATE_TIME"]) {
        return [ZCFieldList ZCDateTime];
    }
    else if([fieldString isEqualToString:@"PICK_LIST"]) {
        return [ZCFieldList ZCDropdown];
    }
    else if([fieldString isEqualToString:@"IMAGE"]) {
        return [ZCFieldList ZCImage];
    }
    else if([fieldString isEqualToString:@"NOTES"]) {
        return [ZCFieldList ZCNotes];
    }
    else if([fieldString isEqualToString:@"AUTO_NUMBER"]) {
        return [ZCFieldList ZCAutoNumber];
    }
    else if ([fieldString isEqualToString:@"SUB_FORM"])
    {
    
            return [ZCFieldList ZCSubform];

    }
    else {
        return -1;
    }
}



//
//+ (NSInteger) getFieldInteger : (NSString*) fieldString {
//    
//    if([fieldString isEqualToString:@"TEXT"]) {
//        return 1;
//    }
//    else if([fieldString isEqualToString:@"TEXT_AREA"]) {
//        return 2;
//    }
//    else if([fieldString isEqualToString:@"EMAIL_ADDRESS"]) {
//        return 3;
//    }
//    else if([fieldString isEqualToString:@"NUMBER"]) {
//        return 5;
//    }
//    else if([fieldString isEqualToString:@"CURRENCY"]) {
//        return 8;
//    }
//    else if([fieldString isEqualToString:@"PERCENTAGE"]) {
//        return 7;
//    }
//    else if([fieldString isEqualToString:@"CHECK_BOX"]) {
//        return 15;
//    }
//    else if([fieldString isEqualToString:@"DATE"]) {
//        return 10;
//    }
//    else if([fieldString isEqualToString:@"TIME"]) {
//        return 11;
//    }
//    else if([fieldString isEqualToString:@"SINGLE_SELECT"]||[fieldString isEqualToString:@"INLINE_SINGLE_SELECT"]) {
//        return 12;
//    }
//    else if([fieldString isEqualToString:@"MULTI_SELECT"]) {
//        return 14;
//    }
//    else if([fieldString isEqualToString:@"PLAIN_TEXT"]) {
//        return 2;
//    }
//    else if([fieldString isEqualToString:@"EXTERNAL_FIELD"]) {
//        return 23;
//    }
//    else if([fieldString isEqualToString:@"EXTERNAL_LINK_FIELD"]) {
//        return 23;
//    }
//    else if([fieldString isEqualToString:@"RICH_TEXT_AREA"]) {
//        return 4;
//    }
//    else if([fieldString isEqualToString:@"EXTERNAL_MODULE"]) {
//        return -1;
//    }
//    else if([fieldString isEqualToString:@"FROMTO"]) {
//        return -1;
//    }
//    else if([fieldString isEqualToString:@"FLOAT"]) {
//        return 1;
//    }
//    else if([fieldString isEqualToString:@"SCRIPT"]) {
//        return 2;
//    }
//    else if([fieldString isEqualToString:@"FILE_UPLOAD"]) {
//        return 19;
//    }
//    else if([fieldString isEqualToString:@"SYSTEM_LOOKUP"]) {
//        return 30;
//    }
//    else if([fieldString isEqualToString:@"POPUP_SINGLE"]) {
//        return 23;
//    }
//    else if([fieldString isEqualToString:@"PASSWORD"]) {
//        return -1;
//    }
//    else if([fieldString isEqualToString:@"DECIMAL"]) {
//        return 6;
//    }
//    else if([fieldString isEqualToString:@"URL"]) {
//        return 17;
//    }
//    else if([fieldString isEqualToString:@"DATE_TIME"]) {
//        return 11;
//    }
//    else if([fieldString isEqualToString:@"PICK_LIST"]) {
//        return 12;
//    }
//    else if([fieldString isEqualToString:@"IMAGE"]) {
//        return 18;
//    }
//    else if([fieldString isEqualToString:@"NOTES"]) {
//        return 24;
//    }
//    else if([fieldString isEqualToString:@"AUTO_NUMBER"]) {
//        return 9;
//    }
//    else {
//        return -1;
//    }
//}















//
//+ (NSInteger) getFieldInteger : (NSString*) fieldString {
//    
//    if([fieldString isEqualToString:@"TEXT"]) {
//        return 1;
//    }
//    else if([fieldString isEqualToString:@"TEXT_AREA"]) {
//        return 3;
//    }
//    else if([fieldString isEqualToString:@"EMAIL_ADDRESS"]) {
//        return 4;
//    }
//    else if([fieldString isEqualToString:@"NUMBER"]) {
//        return 5;
//    }
//    else if([fieldString isEqualToString:@"CURRENCY"]) {
//        return 6;
//    }
//    else if([fieldString isEqualToString:@"PERCENTAGE"]) {
//        return 7;
//    }
//    else if([fieldString isEqualToString:@"CHECK_BOX"]) {
//        return 9;
//    }
//    else if([fieldString isEqualToString:@"DATE"]) {
//        return 10;
//    }
//    else if([fieldString isEqualToString:@"TIME"]) {
//        return 11;
//    }
//    else if([fieldString isEqualToString:@"SINGLE_SELECT"]||[fieldString isEqualToString:@"INLINE_SINGLE_SELECT"]) {
//        return 12;
//    }
//    else if([fieldString isEqualToString:@"MULTI_SELECT"]) {
//        return 13;
//    }
//    else if([fieldString isEqualToString:@"PLAIN_TEXT"]) {
//        return 14;
//    }
//    else if([fieldString isEqualToString:@"EXTERNAL_FIELD"]) {
//        return 25;
//    }
//    else if([fieldString isEqualToString:@"EXTERNAL_LINK_FIELD"]) {
//        return 26;
//    }
//    else if([fieldString isEqualToString:@"RICH_TEXT_AREA"]) {
//        return 24;
//    }
//    else if([fieldString isEqualToString:@"EXTERNAL_MODULE"]) {
//        return -1;
//    }
//    else if([fieldString isEqualToString:@"FROMTO"]) {
//        return -1;
//    }
//    else if([fieldString isEqualToString:@"FLOAT"]) {
//        return 16;
//    }
//    else if([fieldString isEqualToString:@"SCRIPT"]) {
//        return 15;
//    }
//    else if([fieldString isEqualToString:@"FILE_UPLOAD"]) {
//        return 18;
//    }
//    else if([fieldString isEqualToString:@"SYSTEM_LOOKUP"]) {
//        return 30;
//    }
//    else if([fieldString isEqualToString:@"POPUP_SINGLE"]) {
//        return 95;
//    }
//    else if([fieldString isEqualToString:@"PASSWORD"]) {
//        return -1;
//    }
//    else if([fieldString isEqualToString:@"DECIMAL"]) {
//        return 19;
//    }
//    else if([fieldString isEqualToString:@"URL"]) {
//        return 21;
//    }
//    else if([fieldString isEqualToString:@"DATE_TIME"]) {
//        return 22;
//    }
//    else if([fieldString isEqualToString:@"PICK_LIST"]) {
//        return 100;
//    }
//    else if([fieldString isEqualToString:@"IMAGE"]) {
//        return 20;
//    }
//    else if([fieldString isEqualToString:@"NOTES"]) {
//        return 100;
//    }
//    else if([fieldString isEqualToString:@"AUTO_NUMBER"]) {
//        return 31;
//    }
//    else {
//        return -1;
//    }
//}
@end
