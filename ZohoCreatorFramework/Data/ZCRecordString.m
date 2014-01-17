//
//  ZCRecordString.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 22/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ZCRecordString.h"
#import "ZCSubFormRecords.h"
#import "ZCEncodeUtil.h"
@interface ZCRecordString(hidden)

+ (NSString*) recordValueXML : (ZCForm*) form : (ZCRecord*) record;
+ (NSString*) recordValueXML:(NSDictionary*) fieldDict;
+ (NSString*) updateRecordValueXML : (ZCForm*) form : (ZCRecord*) record;
+ (NSString *)removeEndSpaceFrom:(NSString *)strtoremove;
+ (NSString*) updateRecordValueXML : (NSDictionary*) dataDict;
+ (NSString*) recordValueXMLForZCRecord:(ZCRecord *) record;

@end

@implementation ZCRecordString

+ (NSString*) newRecordString : (ZCForm*) form : (ZCRecord*) record {
    
    ////// ////NSLog@"apppppppplication       %@",[form application]);
    
    NSMutableArray *fields = [form fields];
    
    NSString *returnString = [NSString stringWithFormat:@""];
    for(NSInteger index=0;index<[fields count];index++)
    {
        ZCField *field = [fields objectAtIndex:index];
        NSString *fieldName = [field fieldName];
        NSInteger fieldType = [field fieldType];
        
        ZCFieldData *fieldData = [[record record] objectForKey:fieldName];
        
        if(fieldType == [ZCFieldList ZCCheckbox] || fieldType == [ZCFieldList ZCMultiSelect] ) {
            NSMutableArray *options = [fieldData fieldValue];
            
            NSString *result = @"";
            for(NSInteger opt=0;opt<[options count];opt++) {
                result = [result stringByAppendingFormat:@"%@",[options objectAtIndex:opt]];
                if(opt != ([options count]-1)) {
                    result = [result stringByAppendingString:@","];
                }
            }
            returnString = [returnString stringByAppendingFormat:@"%@=%@",fieldName,[ZCEncodeUtil encodeStringUsingUT8:result]];
        }
        else if(fieldType == [ZCFieldList ZCFileupload] || fieldType == [ZCFieldList ZCImage]) {
            
        }
        else if(fieldType == [ZCFieldList ZCSubform]) {
            
            
        }
        else if(fieldType == [ZCFieldList ZCNotes]) {
            
        }
        else {
            NSString *escapedString =[ZCEncodeUtil encodeStringUsingUT8:[fieldData fieldValue]];

            returnString = [returnString stringByAppendingFormat:@"%@=%@",fieldName,escapedString];
        }
        if(index != ([fields count]-1)) {
            returnString = [returnString stringByAppendingString:@"&"];
        }
    }
    
    ////// ////NSLog@"return string %@",returnString);
    return returnString;
}


+ (NSString*) newRecordStringXML : (ZCForm*) form : (ZCRecord*) record {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><formlist><form name='%@'><add>",[[form application] appLinkName],[form linkName]];
    [recordXML appendString:[ZCRecordString recordValueXML:form :record]];
    [recordXML appendString:@"</add></form></formlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}



+ (NSString*) newRecordStringXMLWithViewLinkname:(NSString *)viewLinkname form: (ZCForm*) form  record: (ZCRecord*) record  {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><viewlist><view name='%@'><add>",[[form application] appLinkName],viewLinkname];
    [recordXML appendString:[ZCRecordString recordValueXML:form :record]];
    [recordXML appendString:@"</add></view></viewlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}

+ (NSString*) newRecordsStringXML : (ZCForm*) form : (NSMutableArray*) records {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><formlist><form name='%@'>",[[form application] appLinkName],[form linkName]];
    
    
    for(NSInteger index=0;index<[records count];index++) {
        [recordXML appendString:@"<add>"];
        ZCRecord *record = [records objectAtIndex:index];
        [recordXML appendString:[ZCRecordString recordValueXML:form :record]];
        [recordXML appendString:@"</add>"];
    }
    
    [recordXML appendString:@"</form></formlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}

+ (NSString*) newUpdateRcordStringXML : (ZCView*) view : (ZCRecord*) record {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><viewlist><view name='%@'><update>",[[view application] appLinkName],[view viewLinkName]];
    ZCFieldData *fieldData = [record getFieldData:@"ID"];
    [recordXML appendString:[ZCRecordString editRecordCriteria:[fieldData fieldValue]]];
    //    [recordXML appendString:[ZCRecordString editRecordCriteria:[record recordID]]];
    [recordXML appendString:@"<newvalues>"];
    [recordXML appendString:[ZCRecordString updateRecordValueXML:  [view getBaseFormObject] :record]];
    [recordXML appendString:@"</newvalues></update></view></viewlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}


+ (NSString*) newUpdateRcordStringXML : (ZCForm*) form : (ZCRecord*) record : (NSString*) viewLinkName {
    
    //NSLog@"newUpdateRecordStringXML");
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><viewlist><view name='%@'><update>",[[form application] appLinkName],viewLinkName];
    ZCFieldData *fieldData = [record getFieldData:@"ID"];
    [recordXML appendString:[ZCRecordString editRecordCriteria:[fieldData fieldValue]]];
    //    [recordXML appendString:[ZCRecordString editRecordCriteria:[record recordID]]];
    [recordXML appendString:@"<newvalues>"];
    [recordXML appendString:[ZCRecordString updateRecordValueXML:form :record]];
    [recordXML appendString:@"</newvalues></update></view></viewlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}

+ (NSString*) bulKUpdateRcordStringXML : (ZCForm*) form : (NSMutableArray*) records {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><formlist><form name='%@'>",[[form application] appLinkName],[form linkName]];
    for(NSInteger index=0;index<[records count];index++) {
        ZCRecord *record = [records objectAtIndex:index];
        
        //        ZCFieldData *fieldData =  [record getFieldData:@"ID"];
        [recordXML appendString:@"<update>"];
        //            [recordXML appendString:[ZCRecordString editRecordCriteria:[fieldData fieldValue]]];
        [recordXML appendString:[ZCRecordString editRecordCriteria:[record recordID]]];
        [recordXML appendString:@"<newvalues>"];
        [recordXML appendString:[ZCRecordString updateRecordValueXML:form :record]];
        [recordXML appendString:@"</newvalues></update>"];
    }
    [recordXML appendString:@"</form></formlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}

//+ (NSString*) bulKUpdateRcordStringXMLWithZCForm:(ZCForm *)form viewLinkName : (NSString*) viewLinkName  records : (NSMutableArray*) records {
//    
//    NSMutableString *recordXML = [[NSMutableString alloc] init];
//    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><viewlist><view name='%@'>",[[form application] appLinkName],viewLinkName];
//    for(NSInteger index=0;index<[records count];index++) {
//        ZCRecord *record = [records objectAtIndex:index];
//        
//        //        ZCFieldData *fieldData =  [record getFieldData:@"ID"];
//        [recordXML appendString:@"<update>"];
//        //            [recordXML appendString:[ZCRecordString editRecordCriteria:[fieldData fieldValue]]];
//        [recordXML appendString:[ZCRecordString editRecordCriteria:[record recordID]]];
//        [recordXML appendString:@"<newvalues>"];
//        [recordXML appendString:[ZCRecordString updateRecordValueXML:form :record]];
//        [recordXML appendString:@"</newvalues></update>"];
//    }
//    [recordXML appendString:@"</view></viewlist></application></applicationlist></ZohoCreator>"];    return  recordXML;
//}
+ (NSString*) bulKUpdateRcordStringXMLWithZCForm:(ZCForm *)form viewLinkName : (NSString*) viewLinkName  records : (NSMutableArray*) records newRecord:(ZCRecord *)record{

    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><viewlist><view name='%@'>",[[form application] appLinkName],viewLinkName];
    
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    NSMutableString * idsstring=[[NSMutableString alloc]init];
    for(NSInteger index=0;index<[records count];index++) {
        ZCRecord *record = [records objectAtIndex:index];
        [ids addObject:[NSString stringWithFormat:@"ID == \" %@\" ",[record recordID]]];
        
    }
    
    for (int idInd=0;idInd<ids.count;idInd++) {
        
        [idsstring appendString:[ids objectAtIndex:idInd]];
        
        if (idInd< ids.count-1) {
            [idsstring appendString:@"||"];
        }
        
        
    }
    [recordXML appendFormat:@"<update><criteria><![CDATA[(%@)]]></criteria>",idsstring];

//        for(NSInteger index=0;index<[records count];index++) {
//            ZCRecord *record = [records objectAtIndex:index];
//
//        //        ZCFieldData *fieldData =  [record getFieldData:@"ID"];
//        //            [recordXML appendString:[ZCRecordString editRecordCriteria:[fieldData fieldValue]]];
////        [recordXML appendString:[ZCRecordString editRecordCriteria:[record recordID]]];
//        [recordXML appendString:@"<newvalues>"];
//        [recordXML appendString:[ZCRecordString updateRecordValueXML:form :record]];
//        [recordXML appendString:@"</newvalues></update>"];
//    }
//    
        [recordXML appendString:@"<newvalues>"];
        [recordXML appendString:[ZCRecordString updateRecordValueXML:form :record]];
        [recordXML appendString:@"</newvalues></update>"];
        [recordXML appendString:@"</view></viewlist></application></applicationlist></ZohoCreator>"];    return  recordXML;
    
    
    //

//    &XMLString=<ZohoCreator><applicationlist><application name='iphone-testing'><viewlist><view name='Multiline_Report'><update><criteria><![CDATA[(ID == "830230000000339007" || ID == "830230000000339003")]]></criteria><newvalues><field name='Multi_Line'><value><![CDATA[123]]></value></field></newvalues></update></view></viewlist></application></applicationlist></ZohoCreator>

}

+ (NSString*) bulKUpdateRcordStringXML : (NSString*) appLinkName withViewName : (NSString*) viewLinkName  andDataDictList : (NSMutableArray*) dataDictList {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><viewlist><view name='%@'><update>",appLinkName,viewLinkName];
    for(NSInteger index=0;index<[dataDictList count];index++) {
        NSMutableDictionary *record = [dataDictList objectAtIndex:index];
        NSString *fieldData =  [record valueForKey:@"ID"];
        [recordXML appendString:[ZCRecordString editRecordCriteria:fieldData]];
        [recordXML appendString:@"<update><newvalues>"];
        [recordXML appendString:[ZCRecordString updateRecordValueXML:record]];
        [recordXML appendString:@"</newvalues></update>"];
    }
    [recordXML appendString:@"</view></viewlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}

+ (NSString*) bulKUpdateRcordStringXML : (NSString*) appLinkName withFormName : (NSString*) formLinkName : andDataDictList : (NSMutableArray*) dataDictList {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><formlist><form name='%@'><update>",appLinkName,formLinkName];
    for(NSInteger index=0;index<[dataDictList count];index++) {
        NSMutableDictionary *record = [dataDictList objectAtIndex:index];
        NSString *fieldData =  [record valueForKey:@"ID"];
        [recordXML appendString:[ZCRecordString editRecordCriteria:fieldData]];
        [recordXML appendString:@"<update><newvalues>"];
        [recordXML appendString:[ZCRecordString updateRecordValueXML:record]];
        [recordXML appendString:@"</newvalues></update>"];
    }
    [recordXML appendString:@"</form></formlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}

+ (NSString*) updateRcordStringXML : (NSString*) appLinkName  : (NSString*) formLinkName : (NSDictionary*) dataDict
{
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><formlist><form name='%@'><update>",appLinkName,formLinkName];
    NSString *idValue = [dataDict objectForKey:@"ID"];
    [recordXML appendString:[ZCRecordString editRecordCriteria:idValue]];
    [recordXML appendString:@"<newvalues>"];
    [recordXML appendString:[ZCRecordString updateRecordValueXML:dataDict]];
    [recordXML appendString:@"</newvalues></update></form></formlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}

+ (NSString*) updateRcordStringXML : (NSString*) appLinkName  withViewName: (NSString*) viewLinkName : (NSDictionary*) dataDict
{
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><viewlist><view name='%@'><update>",appLinkName,viewLinkName];
    NSString *idValue = [dataDict objectForKey:@"ID"];
    [recordXML appendString:[ZCRecordString editRecordCriteria:idValue]];
    [recordXML appendString:@"<newvalues>"];
    [recordXML appendString:[ZCRecordString updateRecordValueXML:dataDict]];
    [recordXML appendString:@"</newvalues></update></view></viewlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}

+ (NSString*) newDeleteRecordStringXML : (ZCView*) view : (ZCRecord*) record {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><formlist><form name='%@'><delete>",[[view application] appLinkName],[view viewLinkName]];
    [recordXML appendString:[ZCRecordString editRecordCriteria:[record recordID]]];
    [recordXML appendString:@"</delete></form></formlist></application></applicationlist></ZohoCreator>"];
    return recordXML;
}

+ (NSString*) deleteRecordStringXML : (ZCForm*) form : (ZCRecord*) record {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><formlist><form name='%@'><delete>",[[form application] appLinkName],[form linkName]];
    [recordXML appendString:[ZCRecordString editRecordCriteria:[record recordID]]];
    [recordXML appendString:@"</delete></form></formlist></application></applicationlist></ZohoCreator>"];
    return recordXML;
}

+ (NSString*) deleteRecordStringXML: (NSString*) appLinkName : (NSString*) formLinkName : (NSString*) idValue {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><formlist><form name='%@'><delete>",appLinkName,formLinkName];
    [recordXML appendString:[ZCRecordString editRecordCriteria:idValue]];
    [recordXML appendString:@"</delete></form></formlist></application></applicationlist></ZohoCreator>"];
    return recordXML;
}

+ (NSString*) deleteRecordStringXML: (NSString*) appLinkName withViewName: (NSString*) viewLinkName : (NSString*) idValue {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><viewlist><view name='%@'><delete>",appLinkName,viewLinkName];
    [recordXML appendString:[ZCRecordString editRecordCriteria:idValue]];
    [recordXML appendString:@"</delete></view></viewlist></application></applicationlist></ZohoCreator>"];
    return recordXML;
}

+ (NSString*) bulkDeleteRecordStringXML: (NSString*) appLinkName withViewLinkName : (NSString*) viewLinkName : (NSMutableArray*) idValues {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><viewlist><view name='%@'>",appLinkName,viewLinkName];
    for(NSInteger index=0;index<[idValues count];index++) {
        [recordXML appendFormat:@"<delete>%@</delete>",[ZCRecordString editRecordCriteria:[idValues objectAtIndex:index]]];
    }
    [recordXML appendString:@"</view></viewlist></application></applicationlist></ZohoCreator>"];
    return recordXML;
}

+ (NSString*) bulkDeleteRecordStringXML: (NSString*) appLinkName : (NSString*) formLinkName : (NSMutableArray*) idValues {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><formlist><form name='%@'>",appLinkName,formLinkName];
    for(NSInteger index=0;index<[idValues count];index++) {
        [recordXML appendFormat:@"<delete>%@</delete>",[ZCRecordString editRecordCriteria:[idValues objectAtIndex:index]]];
    }
    [recordXML appendString:@"</form></formlist></application></applicationlist></ZohoCreator>"];
    return recordXML;
}

+ (NSString*) newRecordStringXML : (NSString*) appLinkName : (NSString*) formLinkName : (NSDictionary*) fieldDict {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><formlist><form name='%@'><add>",appLinkName,formLinkName];
    [recordXML appendString:[ZCRecordString recordValueXML:fieldDict]];
    [recordXML appendString:@"</add></form></formlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}

+ (NSString*) newRecordsStringXML : (NSString*) appLinkName : (NSString*) formLinkName : (NSMutableArray*) records {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><formlist><form name='%@'>",appLinkName,formLinkName];
    ZOHOCreator *object = [ZOHOCreator getObject];
//    [object getApplication:appLinkName];
    [object getApplication:appLinkName appOwner:[[object userObject]userName]];

    for(NSInteger index=0;index<[records count];index++) {
        ZCRecord *record = [records objectAtIndex:index];
        [recordXML appendString:[ZCRecordString recordValueXML:record.record]];
    }
    [recordXML appendString:@"</form></formlist></application></applicationlist></ZohoCreator>"];
    return  recordXML;
}

+ (NSString*) editRecordCriteria:(NSString *)idValue {
    
//    return [NSString stringWithFormat:@"<criteria><field name='ID' compOperator='Equals' value='%@'></field><reloperator>OR</reloperator><field name='ID' compOperator='Equals' value='%@'></field></criteria>",idValue,idValue];
    
    return [NSString stringWithFormat:@"<criteria><![CDATA[(ID == \"%@\")]]></criteria>",idValue];

    
    
}

+ (NSString*) deleteRecordCriteria:(NSString *)idValue {
    
    return [NSString stringWithFormat:@"ID=%@",idValue];
}

+ (NSString*) recordXMLforSubformRecord : (ZCForm*) form : (ZCRecord*) record {
    
    NSMutableArray *fields = [form fields];
    NSMutableString *returnString = [[NSMutableString alloc] init];
    for(NSInteger index=0;index<[fields count];index++) {
        
        ZCField *field = [fields objectAtIndex:index];
        NSString *fieldName = [field fieldName];
        NSInteger fieldType = [field fieldType];
        
        ZCFieldData *fieldData = [[record record] objectForKey:fieldName];
//NSLog@"Vishnu ::::::  %@ %@",[fieldData fieldValue],[fieldData fieldName]);
        
        if([fieldData fieldValue] != nil) {
            
            if(![fieldName isEqualToString:@"ID"])
                
            {

            [returnString appendFormat:@"<field name='%@'>",fieldName];
            if(fieldType == [ZCFieldList ZCMultiSelect] || fieldType==[ZCFieldList ZCCheckbox])
            {
                
//                [returnString appendFormat:@"<value>"];
                
                NSArray *options;
                

                if ([[fieldData fieldValue ]isKindOfClass:[NSDictionary class]]) {
                    
                    options=[[fieldData fieldValue] allKeys];
                    
                }
              else if ([[fieldData fieldValue ]isKindOfClass:[NSArray class]]) {
                    
                 options = [fieldData fieldValue];

                  
                }
                
                else if([[fieldData fieldValue]isKindOfClass:[NSString class]])
                {
                
                    options=[NSMutableArray arrayWithObject:[fieldData fieldValue]];

                }
                
                
                [returnString appendString:@"<options>"];

                if(options != nil && [options isKindOfClass:[NSArray class]] ) {
                    if(options != nil && [options count] > 0 )//&& [options isMemberOfClass:[NSArray class]] )
                    {
                        for(NSInteger opt=0;opt<[options count];opt++)
                        {
                            NSString *optionValue =  [options objectAtIndex:opt];
                            optionValue = [ZCRecordString removeEndSpaceFrom:optionValue];
                                                        if(optionValue != nil) {
                                                            
                                                            optionValue=[ZCEncodeUtil encodeStringUsingUT8:optionValue];

                                [returnString appendFormat:@"<option><![CDATA[%@]]></option>",optionValue];
                            }
                        }
                    }
                }
                [returnString appendString:@"</options>"];
//                [returnString appendFormat:@"</value>"];

                
            }
            else if(fieldType == [ZCFieldList ZCFileupload] || fieldType ==[ZCFieldList ZCImage]|| fieldType ==[ZCFieldList ZCFormula]) {
                
            }
            else if(fieldType == [ZCFieldList ZCURL]) {
                
                NSMutableDictionary *dic = [fieldData fieldValue];
                NSString *url = [dic valueForKey:@"url"];
                NSString *urltitle = [dic valueForKey:@"title"];
                NSString *urlLinkname = [dic valueForKey:@"urllinkname"];
                
                if (url==Nil) {
                    url=@"";
                }
                if (urlLinkname==Nil) {
                    urlLinkname=@"";
                }
                if (urltitle==Nil) {
                    urltitle=@"";
                }
                
                NSString *URLData = [NSString stringWithFormat:@"<a href=\"%@\" title=\"%@\">%@</a>",url,urltitle,urlLinkname];
                
//                NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) URLData,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
                
                NSString *escapedString =[ZCEncodeUtil encodeStringUsingUT8:URLData];

                [returnString appendFormat:@"<value><![CDATA[%@]]></value>",escapedString];
                
            }
                
            

            else {
                [returnString appendFormat:@"<value>"];

                //                ////// ////NSLog@"Field Name %@ ==== %@",[fieldData fieldName],[fieldData fieldValue]);
                
                NSString* cdata=@"";
                if([[fieldData fieldValue]isKindOfClass:[NSString class]])

                {
                    cdata= [fieldData fieldValue];
                }
                if([[fieldData fieldValue]isKindOfClass:[NSDictionary class]])
                {
                
                    if ([[fieldData fieldValue]allKeys].count==1) {
                        
                        cdata=[[[fieldData fieldValue]allKeys]objectAtIndex:0];
                    
                }
                }
                
            
                
//                NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) cdata,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
//                NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) cdata,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
                NSString *escapedString =[ZCEncodeUtil encodeStringUsingUT8:cdata];


                [returnString appendFormat:@"<![CDATA[%@]]>",escapedString];
                [returnString appendFormat:@"</value>"];

            }
            [returnString appendString:@"</field>"];
        }
    }
}

//    //NSLog@"retu %@",returnString);
//    NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) returnString,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));

    return returnString;
}

+ (NSString*) newDuplicateRecords : (NSString*) viewLinkName withApplication : (NSString*) appLinkName AndRecords : (NSMutableArray*) records {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><viewlist><view name='%@'>",appLinkName,viewLinkName];
    [recordXML appendString:@"<duplicate>"];
    [recordXML appendFormat:@"<criteria>"];
    if([records count] > 1) {
        
        [recordXML appendFormat:@"<![CDATA[(ID in {" ];
        for(NSInteger index=0;index<[records count];index++) {
            
            id record = [records objectAtIndex:index];
            if([record isKindOfClass:[ZCRecord class]]) {
                [recordXML appendFormat:@" %@ ",[record recordID]];
            }
            else {
                [recordXML appendFormat:@" %@ ",record];
            }
            
            if(index != ([records count]  -1)) {
                [recordXML appendString:@","];
            }
        }
        [recordXML appendString:@"})]]>"];
    }
    else {
        
        id record = [records objectAtIndex:0];
        if([record isKindOfClass:[ZCRecord class]]) {
            
            [recordXML appendFormat:@"<![CDATA[(ID == %@)]]>",[record recordID]];
        }
        else {
            [recordXML appendFormat:@"<![CDATA[(ID == %@)]]>",record];
        }
    }
    [recordXML appendFormat:@"</criteria>"];
    [recordXML appendString:@"</duplicate>"];
    [recordXML appendString:@"</view></viewlist></application></applicationlist></ZohoCreator>"];
    // ////NSLog@"duplicate XML %@",recordXML);
    return  recordXML;
}


+ (NSString*) duplicateRecords : (NSString*) viewLinkName withApplication : (NSString*) appLinkName AndRecords : (NSMutableArray*) records {
    
    NSMutableString *recordXML = [[NSMutableString alloc] init];
    [recordXML appendFormat:@"XMLString=<ZohoCreator><applicationlist><application name='%@'><viewlist><view name='%@'>",appLinkName,viewLinkName];
    for(NSInteger index=0;index<[records count];index++) {
        [recordXML appendString:@"<add>"];
        ZCRecord *record = [records objectAtIndex:index];
        [recordXML appendString:[ZCRecordString recordValueXMLForZCRecord:record]];
        [recordXML appendString:@"</add>"];
    }
    [recordXML appendString:@"</view></viewlist></application></applicationlist></ZohoCreator>"];
    // ////NSLog@"duplicate XML %@",recordXML);
    return  recordXML;
}

@end

@implementation ZCRecordString (hidden)


+ (NSString*) recordValueXMLForZCRecord:(ZCRecord *) record {
    
    return [ZCRecordString recordValueXML:[record record]];
}

+ (NSString*) recordValueXML:(NSDictionary*) fieldDict {
    
    // ////NSLog@"field Dict %@",fieldDict);
    NSMutableString *returnString = [NSMutableString string];
    NSEnumerator *fieldEnum = [fieldDict keyEnumerator];
    NSString *fieldName;
    while((fieldName = [fieldEnum nextObject])!= nil) {
        
        ZCFieldData *fieldData = [fieldDict objectForKey:fieldName];
        if(fieldData != nil) {
            id fieldValue = [fieldData fieldValue];
            // ////NSLog@"field Value %@ %@",fieldValue,[fieldValue class]);
            if(fieldValue != nil) {
                [returnString appendFormat:@"<field name='%@'>",fieldName];
                
                if([fieldValue isMemberOfClass:[NSArray class]] || [fieldValue isMemberOfClass:[NSArray class]]) {
                    [returnString appendFormat:@"<field name='%@'>",fieldName];
                    [returnString appendString:@"<options>"];
                    for(NSInteger opt=0;opt<[fieldValue count];opt++) {
                        NSString *optionValue =  [fieldValue objectAtIndex:opt];
                        optionValue = [ZCRecordString removeEndSpaceFrom:optionValue];
                        
//                        NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) optionValue,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));

                        NSString *escapedString =[ZCEncodeUtil encodeStringUsingUT8:optionValue];

                        [returnString appendFormat:@"<option><![CDATA[%@]]></option>",escapedString];
                    }
                    [returnString appendString:@"</options>"];
                }
                if([fieldValue isMemberOfClass:[NSMutableDictionary class]] || [fieldValue isMemberOfClass:[NSDictionary class]]) {
                    
                }
                else {
                    
//                    NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) fieldValue,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
                    NSString *escapedString =[ZCEncodeUtil encodeStringUsingUT8:fieldValue];

                    [returnString appendFormat:@"<value><![CDATA[%@]]></value>",escapedString];
                    //                    [returnString appendString:@"</field>"];
                }
            }
            [returnString appendString:@"</field>"];
        }
    }
    return returnString;
}
+(NSString *)deleteRecordValueXMLFormSubformRecord:(ZCRecord *)record
{
    NSMutableString *returnString = [[NSMutableString alloc] init];
    [returnString appendFormat:@"<delete ID=\"%@\"",[record.record objectForKey:@"ID"]];
    
    [returnString appendFormat:@"</delete>"];
    
    return returnString;
    
    
}
+(NSString *)updateRecordValueXMLFormSubformRecord:(ZCRecord *)record form:(ZCForm *)
form
{
    //
    //    <update ID="3000000150243">
    //    <field name="Name" ><value>Nandhini</value></field>
    //    <field name="Email" ><value>pnandhini@zohocorp.com</value></field>
    //    </update>
    NSMutableString *returnString = [[NSMutableString alloc] init];
//    NSEnumerator *fieldNames =  [[record record] keyEnumerator];
//    NSString *fieldName;
    
    [returnString appendFormat:@"<update ID=\"%@\">",[[record.record objectForKey:@"ID" ]fieldValue] ];
    
    
    [returnString appendString:[ self recordXMLforSubformRecord:form :record ]];
    return returnString;
//    
//    while(fieldName=[fieldNames nextObject])
//    {
//        
//        //        //NSLog@"fieldname %@",fieldName);
//        if(![fieldName isEqualToString:@"ID"])
//            
//        {
//            id fieldValue = [[[record record] objectForKey:fieldName]fieldValue ];
//            //NSLog@"fieldvalue %@",[fieldValue class]);
//            
//            if([fieldValue isKindOfClass:[NSString class]] ) {
//                
//                fieldValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) fieldValue,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
//
////                [returnString appendFormat:@"<field name='%@' value=![CDATA[%@]]>",fieldName,fieldValue];
//                [returnString appendFormat:@"<field name='%@'>",fieldName];
//
//                [returnString appendFormat:@"<value><![CDATA[%@]]></value>",fieldValue];
//
//                [returnString appendString:@"</field>"];
//                
//            }
//            else if([fieldValue isKindOfClass:[NSArray class]]) {
//                [returnString appendFormat:@"<field name='%@'>",fieldName];
//
//                NSArray *options =fieldValue;
//                //NSLog@"option value for update %@",options);
//                [returnString appendString:@"<options>"];
//                if(options != nil && [options count] > 0 )//&& [options isMemberOfClass:[NSArray class]] )
//                {
//                    for(NSInteger opt=0;opt<[options count];opt++)
//                    {
//                        NSString *optionValue =  [options objectAtIndex:opt];
//                        optionValue = [ZCRecordString removeEndSpaceFrom:optionValue];
//                        if(optionValue != nil) {
//                            optionValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) optionValue,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
//
//                            [returnString appendFormat:@"<option><![CDATA[%@]]></option>",optionValue];
//                        }
//                    }
//                }
//                [returnString appendString:@"</options>"];
//                [returnString appendString:@"</field>"];
//                
//            }
//            else if([fieldValue isKindOfClass:[NSDictionary class]]) {
//                [returnString appendFormat:@"<field name='%@'>",fieldName];
//                
//                NSArray *options =[fieldValue allValues];
//                //NSLog@"option value for update %@",options);
//                [returnString appendString:@"<options>"];
//                if(options != nil && [options count] > 0 )//&& [options isMemberOfClass:[NSArray class]] )
//                {
//                    for(NSInteger opt=0;opt<[options count];opt++)
//                    {
//                        NSString *optionValue =  [options objectAtIndex:opt];
//                        optionValue = [ZCRecordString removeEndSpaceFrom:optionValue];
//                        if(optionValue != nil) {
//                            optionValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) optionValue,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
//                            
//                            [returnString appendFormat:@"<option><![CDATA[%@]]></option>",optionValue];
//                        }
//                    }
//                }
//                [returnString appendString:@"</options>"];
//                [returnString appendString:@"</field>"];
//
//            }
//            
//        }
//        
//    }
//    
//    return  returnString ;
    
    
    
}
+ (NSString*) updateRecordValueXML : (ZCForm*) form : (ZCRecord*) record {
    
    NSMutableArray *fields = [form fields];
    NSMutableString *returnString = [[NSMutableString alloc] init];
    for(NSInteger index=0;index<[fields count];index++) {
        
        NSMutableArray *fields = [form fields];
        
        ZCField *field = [fields objectAtIndex:index];
        NSString *fieldName = [field fieldName];
        
        NSInteger fieldType = [field fieldType];
        
        
        ZCFieldData *fieldData = [[record record] objectForKey:fieldName];
        
        
        
        ////NSLog@"fieldvaluew %@  ----  %@",[fieldData fieldName],[fieldData fieldValue]);
        
        
        
//        if([fieldData fieldValue] != nil)
//        
//        {
        
            if(fieldType == [ZCFieldList ZCCheckbox] || fieldType == [ZCFieldList ZCMultiSelect] ) {
                
                [returnString appendFormat:@"<field name='%@'>",fieldName];
                
                NSArray *options;
                
                if ([[fieldData fieldValue]isKindOfClass:[NSArray class]] || [[fieldData fieldValue] isKindOfClass:[NSMutableArray class]] ) {
                    options= [fieldData fieldValue];
                }
                else if([[fieldData fieldValue]isKindOfClass:[NSString class]])
                {
                    
                    
                    //                    NSString *tempValues = (NSString*) [fieldData fieldValue];
                    //                    NSRange range;
                    //                    range.location=1;
                    //                    range.length = [tempValues length] - 2;
                    options=[[fieldData fieldValue] componentsSeparatedByString:@", "];
                    
                    
                }
                
                [returnString appendString:@"<options>"];
                if(options != nil && [options count] > 0 )
                {
                    for(NSInteger opt=0;opt<[options count];opt++)
                    {
                        NSString *optionValue =  [options objectAtIndex:opt];
                        optionValue = [ZCRecordString removeEndSpaceFrom:optionValue];
                        NSString *escapedString =[ZCEncodeUtil encodeStringUsingUT8:optionValue];

                        //[returnString appendFormat:@"<option><![CDATA[%@]]></option>",optionValue];
                        if(optionValue != nil) {
                            [returnString appendFormat:@"<option>%@</option>",escapedString];
                        }
                    }
                }
                [returnString appendString:@"</options>"];
                
                [returnString appendString:@"</field>"];

                
            }
            else if(fieldType == [ZCFieldList ZCURL]) {
                [returnString appendFormat:@"<field name='%@'>",fieldName];
                
                NSMutableDictionary *dic = [fieldData fieldValue];
                NSString *url = [dic valueForKey:@"url"];
                NSString *urltitle = [dic valueForKey:@"title"];
                NSString *urlLinkname = [dic valueForKey:@"urllinkname"];
                if (!urlLinkname) {
                    urlLinkname=@"";
                }
                if (!url) {
                    url=@"";
                }
                if (!urltitle) {
                    urltitle=@"";
                }

                NSString *URLData = [NSString stringWithFormat:@"<a href=\"%@\" title=\"%@\">%@</a>",url,urltitle,urlLinkname];
                
//                NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) URLData,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
                NSString *escapedString =[ZCEncodeUtil encodeStringUsingUT8:URLData];
                [returnString appendFormat:@"<value><![CDATA[%@]]></value>",escapedString];
                [returnString appendString:@"</field>"];

                
            }
            else if(fieldType == [ZCFieldList ZCSubform] || fieldType ==[ZCFieldList ZCNewSubform])
            {
                [returnString appendFormat:@"<field name='%@'>",fieldName];
                
                NSMutableArray * subFormRectoAdd=[NSMutableArray arrayWithArray:[[fieldData fieldValue]recordsToAdd ]];
                NSMutableArray * subFormRectoupdate=[NSMutableArray arrayWithArray:[[fieldData fieldValue]recordsToUpdate ]];
                NSMutableArray * subFormRectodelete=[NSMutableArray arrayWithArray:[[fieldData fieldValue]recordsToDelete ]];
                ZCForm * zcSubform=[[fieldData fieldValue]zcSubForm];
                int addrecCount=0;
                int updatateRecordCount=0;
                int deleteREcordCount=0;
                NSMutableString * subformRECORDSXML=[[NSMutableString alloc]init];
                
                while (updatateRecordCount<subFormRectoupdate.count)
                {
                    ZCRecord *SubFOrmRecord = [subFormRectoupdate objectAtIndex:updatateRecordCount];
                    //                    ZCApplication *application =    [form application];
                    //                    ZCForm* zcForm =     [application getForm:[[field relatedComponent]  linkName]];
                    NSMutableString *SubFormrecordXML = [[NSMutableString alloc] init];
                    //                    [SubFormrecordXML appendFormat:@"<update>"];
                    //                    ZCFieldData *fieldData = [record getFieldData:@"ID"];
                    //                    [SubFormrecordXML appendString:[ZCRecordString editRecordCriteria:[fieldData fieldValue]]];
                    //                    [SubFormrecordXML appendFormat:@"<newvalues>"];
                    
                    
                    //                    <field name="Team_Email"><value>creator@zoho.com</value></field>
                    
                    
                    //                    <update ID="3000000150243">
                    //                    <field name="Name" ><value>Nandhini</value></field>
                    //                    <field name="Email" ><value>pnandhini@zohocorp.com</value></field>
                    //                    </update>
                    //
                    //
                    
                    NSString * SubFormRecordString=[NSString stringWithFormat:@"%@", [ZCRecordString updateRecordValueXMLFormSubformRecord:SubFOrmRecord form:zcSubform ] ];
                    
                    
                    [SubFormrecordXML appendString:SubFormRecordString];
                    [SubFormrecordXML appendFormat:@"</update>"];
                    
                    
                    
                    ////// ////NSLog@"\n\n subform string %@\n\n",SubFormrecordXML);
                    [subformRECORDSXML appendString:SubFormrecordXML];
                    updatateRecordCount++;
                }
                while (addrecCount<subFormRectoAdd.count)
                {
                    ZCRecord *SubFOrmRecord = [subFormRectoAdd objectAtIndex:addrecCount];
//                    ZCApplication *application =    [form application];
//                    ZCForm* zcForm =     [application getForm:[[field relatedComponent]  linkName]];
                    
                    
                    
                    NSMutableString *SubFormrecordXML = [[NSMutableString alloc] init];
                    [SubFormrecordXML appendFormat:@"<add>"];
                    NSString * SubFormRecordString=[NSString stringWithFormat:@"%@", [ZCRecordString recordXMLforSubformRecord:zcSubform :SubFOrmRecord]];
                    [SubFormrecordXML appendString:SubFormRecordString];
                    [SubFormrecordXML appendString:@"</add>"];
            //NSLog@"\n\n subform string %@\n\n",SubFormrecordXML);
                    [subformRECORDSXML appendString:SubFormrecordXML];
                    addrecCount++;
                }
                while (deleteREcordCount<subFormRectodelete.count)
                {
                    ZCRecord *SubFOrmRecord = [subFormRectodelete objectAtIndex:deleteREcordCount];
                    //                    ZCApplication *application =    [form application];
                    NSMutableString *SubFormrecordXML = [[NSMutableString alloc] init];
                    
                    [SubFormrecordXML appendFormat:@"<delete ID=\"%@\">",[[[SubFOrmRecord record] objectForKey:@"ID" ]fieldValue] ];
                    
                    [SubFormrecordXML appendString:@"</delete>"];
                    ////// ////NSLog@"\n\n subform string %@\n\n",SubFormrecordXML);
                    [subformRECORDSXML appendString:SubFormrecordXML];
                    deleteREcordCount++;
                }
                
                [returnString appendString:subformRECORDSXML];
                
                [returnString appendString:@"</field>"];

                
                //                //NSLog@"subformrecord xml riyaz:: %@",subformRECORDSXML);
                
            }
            else if (fieldType ==[ZCFieldList ZCFileupload] || fieldType ==[ZCFieldList ZCImage]|| fieldType ==[ZCFieldList ZCFormula])
            {
                
                
            }
            else
                
            {
                [returnString appendFormat:@"<field name='%@'>",fieldName];
                
                NSString * fieldvalue=[fieldData fieldValue];
                if (fieldvalue==Nil) {
                    fieldvalue=@"";
                }
//                fieldvalue= (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) fieldvalue,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingASCII));
                fieldvalue =[ZCEncodeUtil encodeStringUsingUT8:fieldvalue];
                [returnString appendFormat:@"<value><![CDATA[%@]]></value>",fieldvalue];

                [returnString appendString:@"</field>"];

            }
        
    }
    return returnString;
}

+ (NSString*) updateRecordValueXML : (NSDictionary*) dataDict {
    
    NSMutableString *returnString = [[NSMutableString alloc] init];
    NSEnumerator *fieldNames =  [dataDict keyEnumerator];
    NSString *fieldName;
    while(fieldName=[fieldNames nextObject]) {
        
        if(![fieldName isEqualToString:@"ID"]) {
            id fieldValue = [dataDict objectForKey:fieldName];
            if([fieldValue isKindOfClass:[NSString class]] ) {
                fieldValue =[ZCEncodeUtil encodeStringUsingUT8:fieldValue];
                [returnString appendFormat:@"<field name='%@'>",fieldName];
                [returnString appendFormat:@"<value><![CDATA[%@]]></value>",fieldValue];

            }
            else if([fieldValue isKindOfClass:[NSArray class]]) {
                
                NSArray *options =fieldValue;
                //// ////NSLog@"option value for update %@",options);
                [returnString appendString:@"<options>"];
                if(options != nil && [options count] > 0 )//&& [options isMemberOfClass:[NSArray class]] )
                {
                    for(NSInteger opt=0;opt<[options count];opt++)
                    {
                        NSString *optionValue =  [options objectAtIndex:opt];
                        optionValue = [ZCRecordString removeEndSpaceFrom:optionValue];
                        optionValue =[ZCEncodeUtil encodeStringUsingUT8:optionValue];

                        if(optionValue != nil) {
                            [returnString appendFormat:@"<option>%@</option>",optionValue];
                        }
                    }
                }
                [returnString appendString:@"</options>"];
            }
            else if([fieldValue isKindOfClass:[NSMutableDictionary class]]) {
                
            }
            [returnString appendString:@"</field>"];
        }
    }
    return returnString;
}


+ (NSString*) recordValueXML : (ZCForm*) form : (ZCRecord*) record {
    
    NSMutableArray *fields = [form fields];
    NSMutableString *returnString = [[NSMutableString alloc] init];
    for(NSInteger index=0;index<[fields count];index++) {
        
        ZCField *field = [fields objectAtIndex:index];
        NSString *fieldName = [field fieldName];
        NSInteger fieldType = [field fieldType];
        //NSLog@"fieldnamerecordvaluexml %@", fieldName);
        
        ZCFieldData *fieldData = [[record record] objectForKey:fieldName];
        
        if([fieldData fieldValue] != nil) {
            
            if(fieldType == [ZCFieldList ZCMultiSelect] || fieldType==[ZCFieldList ZCCheckbox])
            {
                [returnString appendFormat:@"<field name='%@'>",fieldName];
                
                NSArray *options = [fieldData fieldValue];
                //// ////NSLog@"Option Values %@",options);
                [returnString appendString:@"<options>"];
                if(options != nil )//&& [options isMemberOfClass:[NSArray class]] )
                {
                    for(NSInteger opt=0;opt<[options count];opt++)
                    {
                        NSString *optionValue =  [options objectAtIndex:opt];
                        optionValue = [ZCRecordString removeEndSpaceFrom:optionValue];
                        optionValue =[ZCEncodeUtil encodeStringUsingUT8:optionValue];

                        //[returnString appendFormat:@"<option><![CDATA[%@]]></option>",optionValue];
                        [returnString appendFormat:@"<option>%@</option>",optionValue];
                    }
                }
                [returnString appendString:@"</options>"];
                [returnString appendString:@"</field>"];
                
            }
            else if(fieldType == [ZCFieldList ZCURL]) {
                [returnString appendFormat:@"<field name='%@'>",fieldName];
                
                NSMutableDictionary *dic = [fieldData fieldValue];
                NSString *url = [dic valueForKey:@"url"];
                NSString *urltitle = [dic valueForKey:@"title"];
                NSString *urlLinkname = [dic valueForKey:@"urllinkname"];
                NSString *URLData = [NSString stringWithFormat:@"<a href=\"%@\" title=\"%@\">%@</a>",url,urltitle,urlLinkname];
                
//                NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) URLData,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
                NSString *escapedString =[ZCEncodeUtil encodeStringUsingUT8:URLData];

                [returnString appendFormat:@"<value><![CDATA[%@]]></value>",escapedString];
                [returnString appendString:@"</field>"];
                
            }
            else if(fieldType == [ZCFieldList ZCFileupload] || fieldType == [ZCFieldList ZCImage] ) {
                
                
                if ( [[fieldData fieldValue]isKindOfClass:[NSString class]])
                    {
                        [returnString appendFormat:@"<field name='%@'>",fieldName];
                        
                        //NSLog@"Field Name %@ ==== %@",[fieldData fieldName],[fieldData fieldValue]);
                        
                        NSString* cdata = [fieldData fieldValue];
                        
//                        NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) cdata,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
                        
                        NSString *escapedString =[ZCEncodeUtil encodeStringUsingUT8:cdata];

                        [returnString appendFormat:@"<value><![CDATA[%@]]></value>",escapedString];
                        [returnString appendString:@"</field>"];

                        
                    }
                
                
                
            }
            else if(fieldType == [ZCFieldList ZCSubform] || fieldType ==[ZCFieldList ZCNewSubform])
            {
                //NSLog@"It is a subform");
                [returnString appendFormat:@"<field name='%@'>",fieldName];
                
                //   ZCField * fieldLocal=[form getFieldByName:[field fieldName]];
                
                //NSLog@"record to add %@",[[fieldData fieldValue] recordsToAdd]);
                ZCForm * zcSubform=[[fieldData fieldValue]zcSubForm];

                NSMutableArray * subFormRec=[NSMutableArray arrayWithArray:[[fieldData fieldValue] recordsToAdd]];
                
                int recCount=0;
                
                NSMutableString * subformRECORDSXML=[[NSMutableString alloc]init];
                
                while (recCount<subFormRec.count)
                {
                    ZCRecord *SubFOrmRecord = [subFormRec objectAtIndex:recCount];
//                    ZCApplication *application =    [form application];
//                    ZCForm* zcForm =     [application getForm:[[field relatedComponent]  linkName]];
                    NSMutableString *SubFormrecordXML = [[NSMutableString alloc] init];
                    [SubFormrecordXML appendFormat:@"<add>"];
                    NSString * SubFormRecordString=[NSString stringWithFormat:@"%@", [ZCRecordString recordXMLforSubformRecord:zcSubform :SubFOrmRecord]];
                    [SubFormrecordXML appendString:SubFormRecordString];
                    [SubFormrecordXML appendString:@"</add>"];
                    ////// ////NSLog@"\n\n subform string %@\n\n",SubFormrecordXML);
                    [subformRECORDSXML appendString:SubFormrecordXML];
                    recCount++;
                }
                
                [returnString appendString:subformRECORDSXML];
                
                [returnString appendString:@"</field>"];
                
            }
            else if (fieldType ==[ZCFieldList ZCFormula])
            {
            
            }
            else {
                [returnString appendFormat:@"<field name='%@'>",fieldName];
                
                //NSLog@"Field Name %@ ==== %@",[fieldData fieldName],[fieldData fieldValue]);
                
                NSString* cdata = [fieldData fieldValue];
                
//                NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                NULL,(__bridge CFStringRef) cdata,NULL,CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
                
                NSString *escapedString =[ZCEncodeUtil encodeStringUsingUT8:cdata];

                [returnString appendFormat:@"<value><![CDATA[%@]]></value>",escapedString];
                [returnString appendString:@"</field>"];
                
            }
        }
    }
    return returnString;
}

+ (NSString *)removeEndSpaceFrom:(NSString *)strtoremove{
    NSUInteger location = 0;
    unichar charBuffer[[strtoremove length]];
    [strtoremove getCharacters:charBuffer];
    int i = 0;
    for ( i = [strtoremove length]; i >0; i--){
        if (![[NSCharacterSet whitespaceCharacterSet] characterIsMember:charBuffer[i - 1]]){
            break;
        }
    }
    return  [strtoremove substringWithRange:NSMakeRange(location, i  - location)];
}

@end