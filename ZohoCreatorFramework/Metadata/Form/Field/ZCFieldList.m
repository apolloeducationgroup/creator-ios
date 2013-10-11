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
        return 1;
    }
    else if([fieldString isEqualToString:@"TEXT_AREA"]) {
        return 3;
    }
    else if([fieldString isEqualToString:@"EMAIL_ADDRESS"]) {
        return 4;
    }
    else if([fieldString isEqualToString:@"NUMBER"]) {
        return 5;
    }
    else if([fieldString isEqualToString:@"CURRENCY"]) {
        return 6;
    }
    else if([fieldString isEqualToString:@"PERCENTAGE"]) {
        return 7;
    }
    else if([fieldString isEqualToString:@"CHECK_BOX"]) {
        return 9;
    }
    else if([fieldString isEqualToString:@"DATE"]) {
        return 10;
    }
    else if([fieldString isEqualToString:@"TIME"]) {
        return 11;
    }
    else if([fieldString isEqualToString:@"SINGLE_SELECT"]) {
        return 12;
    }
    else if([fieldString isEqualToString:@"MULTI_SELECT"]) {
        return 13;
    }
    else if([fieldString isEqualToString:@"PLAIN_TEXT"]) {
        return 14;
    }
    else if([fieldString isEqualToString:@"EXTERNAL_FIELD"]) {
        return 25;
    }
    else if([fieldString isEqualToString:@"EXTERNAL_LINK_FIELD"]) {
        return 26;
    }
    else if([fieldString isEqualToString:@"RICH_TEXT_AREA"]) {
        return 24;
    }
    else if([fieldString isEqualToString:@"EXTERNAL_MODULE"]) {
        return -1;
    }
    else if([fieldString isEqualToString:@"FROMTO"]) {
        return -1;
    }
    else if([fieldString isEqualToString:@"FLOAT"]) {
        return 16;
    }
    else if([fieldString isEqualToString:@"SCRIPT"]) {
        return 15;
    }
    else if([fieldString isEqualToString:@"FILE_UPLOAD"]) {
        return 18;
    }
    else if([fieldString isEqualToString:@"SYSTEM_LOOKUP"]) {
        return 30;
    }
    else if([fieldString isEqualToString:@"POPUP_SINGLE"]) {
        return 95;
    }
    else if([fieldString isEqualToString:@"PASSWORD"]) {
        return -1;
    }
    else if([fieldString isEqualToString:@"DECIMAL"]) {
        return 19;
    }
    else if([fieldString isEqualToString:@"URL"]) {
        return 21;
    }
    else if([fieldString isEqualToString:@"DATE_TIME"]) {
        return 22;
    }
    else if([fieldString isEqualToString:@"PICK_LIST"]) {
        return 100;
    }
    else if([fieldString isEqualToString:@"IMAGE"]) {
        return 20;
    }
    else if([fieldString isEqualToString:@"NOTES"]) {
        return 100;
    }
    else if([fieldString isEqualToString:@"AUTO_NUMBER"]) {
        return 31;
    }
    else {
        return -1;
    }
}
@end
