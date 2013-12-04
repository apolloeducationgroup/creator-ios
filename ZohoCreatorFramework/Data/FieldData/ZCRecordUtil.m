//
//  ZCRecordUtil.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 12/12/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ZCRecordUtil.h"

@implementation ZCRecordUtil

+ (NSString*) getPrimaryValue : (ZCRecord*) zcRecord {
    
    return [NSString stringWithFormat:@"%@, %@, %@",[[zcRecord getFieldDataByIndex:0] fieldValue],[[zcRecord getFieldDataByIndex:1] fieldValue],[[zcRecord getFieldDataByIndex:2] fieldValue]];
}

+ (NSString*) getPrimaryValueByCount : (ZCRecord*) zcRecord : (NSInteger) count  {
    
    NSMutableString *returnString = [NSMutableString stringWithCapacity:200];
    
    NSInteger indexCount = 0;
    NSArray *skipFields = [ZCRecordUtil getSkipFieldNames:zcRecord];
    for(NSInteger index=0;indexCount<count;index++)
    {
        ZCFieldData *fieldData = [zcRecord getFieldDataByIndex:index];
        if ([skipFields containsObject:fieldData.fieldName]) {
            continue;
        }
        if(indexCount != 0) {
            if([fieldData fieldValue]!=nil) {
                
                if([[fieldData fieldValue] isKindOfClass:[NSArray class]]) {
                    NSMutableArray *options = [fieldData fieldValue];
                    NSMutableString *optionString = [NSMutableString string];
                    for(NSInteger index=0;index<[options count];index++) {
                        if ([options objectAtIndex:index]!=Nil)
                        [optionString appendString:[options objectAtIndex:index]];
                        if(index != [options count]-1) {
                            [optionString appendString:@","];
                        }
                    }
                    [returnString appendFormat:@"%@",optionString];
                }
                else if([[fieldData fieldValue] isKindOfClass:[NSMutableDictionary class]]) {
                    
                    NSMutableDictionary *dic = [fieldData fieldValue];
                    if(dic != nil) {
                        if ([dic objectForKey:@"url"]!=Nil) {
                        [returnString appendFormat:@",%@",[dic objectForKey:@"url"]];
                                                }
                    }
                    else {
                        [returnString appendString:@"," ];
                    }
                }
                else {
                    if([fieldData fieldValue]!= nil) {
                        [returnString appendFormat:@", %@",[fieldData fieldValue]];
                    }
                    else {
                        [returnString appendString:@"," ];
                    }
                    
                }
                
                
            }
            else {
                [returnString appendString:@","];
            }
        }
        else {
            if([fieldData fieldValue]!=nil) {
                
                if([[fieldData fieldValue] isKindOfClass:[NSArray class]]) {
                    NSMutableArray *options = [fieldData fieldValue];
                    NSMutableString *optionString = [NSMutableString string];
                    for(NSInteger index=0;index<[options count];index++) {
                        [optionString appendString:[options objectAtIndex:index]];
                        if(index != [options count]-1) {
                            [optionString appendString:@","];
                        }
                    }
                    [returnString appendFormat:@"%@",optionString];
                }
                else if([[fieldData fieldValue] isKindOfClass:[NSMutableDictionary class]]) {
                    
                    NSMutableDictionary *dic = [fieldData fieldValue];
                    [returnString appendFormat:@"%@",[dic objectForKey:@"title"]];
                }
                else {
                    [returnString appendFormat:@"%@",[fieldData fieldValue]];
                }
            }
            else {
                [returnString appendString:@"" ];
            }
        }
        indexCount ++;
    }
    
   returnString=[NSMutableString stringWithString:[ZCRecordUtil stringByStrippingHTML:returnString]];
    
    return returnString;
}
+(NSString *) stringByStrippingHTML:(NSString *)string
{
    if (string ==NULL || [string isEqualToString:@""] || [string isEqualToString:@"(null)"]) {
        return @"";
    }
    NSRange r;
    while ((r = [string rangeOfString:@"(null)" options:NSRegularExpressionSearch]).location != NSNotFound)
        string = [string stringByReplacingCharactersInRange:r withString:@""];
    while ((r = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        string = [string stringByReplacingCharactersInRange:r withString:@""];
    
    while ((r = [string rangeOfString:@"&nbsp;" options:NSRegularExpressionSearch]).location != NSNotFound)
        string = [string stringByReplacingCharactersInRange:r withString:@" "];
    
    return string;
}



+ (NSString*) getSubtitleValueByCount : (ZCRecord*) zcRecord : (NSInteger) startIndex : (NSInteger) count {
    
    NSMutableString *returnString = [NSMutableString stringWithCapacity:200];
    NSInteger indexCount = 0;
    NSArray *skipFields = [ZCRecordUtil getSkipFieldNames:zcRecord];
    
    for(NSInteger index=startIndex;(indexCount<count && index  <=  [[zcRecord record] count]);index++) {
        
        ZCFieldData *fieldData = [zcRecord getFieldDataByIndex:index];
        
        if(fieldData!=nil) {
            
            if ([skipFields containsObject:fieldData.fieldName]) {
                continue;
            }
            if(indexCount != 0) {
                if([[zcRecord getFieldDataByIndex:index] fieldValue] != nil)
                {
                    
                    if([[fieldData fieldValue] isKindOfClass:[NSArray class]]) {
                        NSMutableArray *options = [fieldData fieldValue];
                        NSMutableString *optionString = [NSMutableString string];
                        for(NSInteger index=0;index<[options count];index++) {
                            if ([options objectAtIndex:index]!=Nil)
                            [optionString appendString:[options objectAtIndex:index]];
                            if(index != [options count]-1) {
                                [optionString appendString:@","];
                            }
                        }
                        [returnString appendFormat:@", %@",optionString];
                    }
                    else if([[fieldData fieldValue] isKindOfClass:[NSMutableDictionary class]]) {
                        
                        NSMutableDictionary *dic = [fieldData fieldValue];
                        if(dic != nil) {
                            if ([dic objectForKey:@"url"]!=Nil)
                            [returnString appendFormat:@",%@",[dic objectForKey:@"url"]];
                        }
                        else {
                            [returnString appendString:@"," ];
                        }
                    }
                    
                    else {
                        if ([[zcRecord getFieldDataByIndex:index] fieldValue]!=Nil)
                        [returnString appendFormat:@", %@",[[zcRecord getFieldDataByIndex:index] fieldValue]];
                    }
                    
                }
                else {
                    [returnString appendString:@","];
                }
            }
            else {
                if([[zcRecord getFieldDataByIndex:index] fieldValue] != nil) {
                    
                    if([[fieldData fieldValue] isKindOfClass:[NSArray class]]) {
                        NSMutableArray *options = [fieldData fieldValue];
                        NSMutableString *optionString = [NSMutableString string];
                        for(NSInteger index=0;index<[options count];index++) {
                            if ([options objectAtIndex:index]!=Nil)

                            [optionString appendString:[options objectAtIndex:index]];
                            if(index != [options count]-1) {
                                [optionString appendString:@","];
                            }
                        }
                        [returnString appendFormat:@"%@",optionString];
                    }
                    else if([[fieldData fieldValue] isKindOfClass:[NSMutableDictionary class]]) {
                        
                        NSMutableDictionary *dic = [fieldData fieldValue];
                        if ([dic objectForKey:@"title"]!=Nil)
                        [returnString appendFormat:@"%@",[dic objectForKey:@"title"]];
                    }
                    else {
                        if ([[zcRecord getFieldDataByIndex:index] fieldValue]!=Nil)
                        [returnString appendFormat:@"%@",[[zcRecord getFieldDataByIndex:index] fieldValue]];
                    }
                }
                else {
                    [returnString appendString:@""];
                }
            }
            indexCount++;
        }
    }
    returnString=[NSMutableString stringWithString:[ZCRecordUtil stringByStrippingHTML:returnString]];

    return returnString;
}

+ (NSArray *) getSkipFieldNames : (ZCRecord *) zcRecord
{
    NSMutableArray *skipFields = [[NSMutableArray alloc] init];
    if (zcRecord.zCGroup != nil) {
        for (ZCFieldData *fieldData in zcRecord.zCGroup.zcGroupFields) {
            [skipFields addObject:fieldData.fieldName];
        }
    }
    
    
    for (ZCField *field in zcRecord.form.fields) {

        if (field.fieldType ==[ZCFieldList ZCImage] || field.fieldType==[ZCFieldList ZCFileupload] || field.fieldType==[ZCFieldList ZCURL] || field.fieldType == [ZCFieldList ZCRichText]) {
            [skipFields addObject:field.fieldName];            
        }
    
    }

    
    return skipFields;
}

+ (NSString*) getPrimaryTextField : (ZCView*) zcview : (NSInteger) rowIndex : (NSInteger) columnIndex {
    
    return [[[[[zcview records] records] objectAtIndex:rowIndex] getFieldDataByIndex:columnIndex] fieldValue];
    
}

@end