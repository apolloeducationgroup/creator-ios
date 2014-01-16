//
//  NewRecordXML.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 02/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "NewRecordXML.h"
#import "ZCEncodeUtil.h"
@interface NewRecordXML(hidden)

+ (NSString*) constructSingleField : (ZCFieldData*) fieldData;
+ (NSString*) constructMultiField : (ZCFieldData*) fieldData;

@end

@implementation NewRecordXML

+ (NSString*) constructRecord : (ZCForm*) zcForm : (ZCRecord*) zcRecord {
    
    NSString *recordString = @"";
    
    for(NSInteger fieldIndex=0;fieldIndex<[[zcForm fields] count]; fieldIndex++) {
        
        ZCField *_zcField = [[zcForm fields] objectAtIndex:fieldIndex];
        ZCFieldData *fieldData =  [zcRecord getFieldData:[_zcField fieldName]];
        ////// ////NSLog@"Vishnu fieldname %@ === %d",[fieldData fieldName],[_zcField fieldType]);
        
        if([_zcField fieldType] == [ZCFieldList ZCSingleLine]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCMultiLine]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCEmail]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCRichText]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCImage]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCURL]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCNumber]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCDecimal]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCPercentage]) {
            ////// ////NSLog@"Coming to ZCPercentage %@",[fieldData fieldValue]);
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCCurrency]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCDropdown] || [_zcField fieldType] == [ZCFieldList ZCLookupDropDown]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCRadio] || [_zcField fieldType] == [ZCFieldList ZCLookupRadio]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCCheckbox] || [_zcField fieldType] == [ZCFieldList ZCLookupCheckbox]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructMultiField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCMultiSelect] || [_zcField fieldType] == [ZCFieldList ZCLookupMultiSelect]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructMultiField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCDate]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCDateTime]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCDecisionBox]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCLookupRadio] ) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCFileupload]) {
            recordString = [recordString stringByAppendingFormat:@"%@&",[NewRecordXML constructSingleField:fieldData]];
        }
        else if([_zcField fieldType] == [ZCFieldList ZCCrm]) {
            
        }
        else if([_zcField fieldType] == [ZCFieldList ZCSubform]) {
            
        }
    }
    return recordString;
}
@end


@implementation NewRecordXML(hidden)

+ (NSString*) constructSingleField : (ZCFieldData*) fieldData {
    
    return [NSString stringWithFormat:@"%@=%@",[fieldData fieldName],[ZCEncodeUtil encodeStringUsingUT8:[fieldData fieldValue]]];
}

+ (NSString*) constructMultiField : (ZCFieldData*) fieldData {
    
    NSString *returnValue = [NSString stringWithFormat:@"%@=",[fieldData fieldName]];
    NSArray *valueArray = [fieldData fieldValue];
    for(NSInteger index=0;index<[valueArray count];index++)
    {
        returnValue = [returnValue stringByAppendingFormat:@"%@,",[valueArray objectAtIndex:index]];
    }
    NSRange range = NSMakeRange (0, [returnValue length]-2);
    return [returnValue substringWithRange:range];
}

@end
