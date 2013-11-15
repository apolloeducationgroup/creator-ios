//
//  ZCSharedAppsEventsParamsUtil.m
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 13/11/13.
//  Copyright (c) 2013 mathankumar vv. All rights reserved.
//

#import "ZCSharedAppsEventsParamsUtil.h"
#import "ZCForm.h"
#import "ZCApplication.h"
@implementation ZCSharedAppsEventsParamsUtil
+(NSString *)getAddtoPickListParamsWithAPPS:(NSArray *)apps Forms:(NSArray *)forms fields:(NSArray *)fields viewLinkname:(NSString *)viewLinkname recordID:(NSString *)recordID
{

    
    
    
    NSLog(@"riyaz lookup %@",fields);
    
        NSMutableArray *childappNamesINORDER=[[NSMutableArray alloc]init];
        NSMutableArray *childFormNameINORDER=[[NSMutableArray alloc]init];
    
        NSMutableArray *baseFieldNameINORDER=[[NSMutableArray alloc]init];
        for (int index=fields.count;index>0;index--) {
    
          ZCField * field=  [fields objectAtIndex:index-1];
            ZCForm * form=[forms objectAtIndex:index -1];
            ZCApplication * app=[apps objectAtIndex:index -1];
         NSLog(@"field linkname  addtopic %@  form %@ %@",field.relatedComponent.linkName,field.relatedComponent.zcApplication.appLinkName,field.fieldName);
    
    
            [childappNamesINORDER addObject:[app appLinkName]];
            [childFormNameINORDER addObject:form.linkName];
            [baseFieldNameINORDER addObject:field.fieldName];
    
    
        }
    
    
    
    
    
    
    NSString * paramString=[[NSString alloc]init];
    
    for(int appInd=0;appInd<apps.count;appInd++)
    {
        
        paramString = [paramString stringByAppendingFormat:@"&zc_childappname_%i=%@",appInd+1,[childappNamesINORDER objectAtIndex:appInd]];
        paramString = [paramString stringByAppendingFormat:@"&zc_childformname_%i=%@",appInd+1,[childFormNameINORDER objectAtIndex:appInd]];
        paramString = [paramString stringByAppendingFormat:@"&zc_childlabelname_%i=%@",appInd+1,[baseFieldNameINORDER objectAtIndex:appInd]];
        
        if (appInd==apps.count-1) {
            paramString = [paramString stringByAppendingFormat:@"&childAppLinkName=%@",[childappNamesINORDER objectAtIndex:appInd]];
            paramString = [paramString stringByAppendingFormat:@"&childFormLinkName=%@",[childFormNameINORDER objectAtIndex:appInd]];
            paramString = [paramString stringByAppendingFormat:@"&childFieldLabelName=%@",[baseFieldNameINORDER objectAtIndex:appInd]];

        }
    }
    
    if (forms.count) {
        

    paramString = [paramString stringByAppendingFormat:@"&zc_lookupCount=%i",forms.count];
//           paramString =[paramString stringByAppendingFormat:@"&linkNameBased=true"];

    }
    
    /*
    
xx1:kk
xx2:
xx3:
xx4:
Multi_Line:
    zc-mobile:
formid:1411560000000081009
formLinkId:63
formLinkName:xxxx
tableName:t_1411560000000081009
lookupFieldName:ID
childFormAccessType:5
childFieldLabelName:xxxx
childFormLinkName:Single_Line
childAppLinkName:all-fields
childFormPrivateLink:
isFromSubForm:false
rowNo:-1
subFormAppName:
subFormLinkName:
recType:5
viewLinkName:
pkValue:
dateFormat:dd-MMM-yyyy
timeZone:America/Los_Angeles
uiDateFormat:%d-%b-%Y
fromIDX:
privatelink:
viewPrivateLink:
appLinkName:xxx
sharedBy:riyazmd
isNewTypeSubform:undefined
childSubformField:undefined
zc_lookupCount:2
zc_childappname_1:all-fields
zc_childappname_2:all-fields
zc_childformname_1:Lookup
zc_childformname_2:Single_Line
zc_childlabelname_1:Lookup_plus_add
zc_childlabelname_2:xxxx

    */
    NSLog(@"recLinkID %@ %@",recordID,viewLinkname);
    if (recordID.length) {
        paramString = [paramString stringByAppendingFormat:@"&recLinkID=%@",recordID];
    }
    if (viewLinkname.length) {
        
        paramString = [paramString stringByAppendingFormat:@"&viewLinkName=%@",viewLinkname];
        
    }
    


    return paramString;
}

+(NSString *)getAddtoPickListParamsWithAPPS:(NSArray *)apps Forms:(NSArray *)forms fields:(NSArray *)fields viewLinkname:(NSString *)viewLinkname recordID:(NSString *)recordID deluge:(BOOL)deluge
{

    NSString * paramString=[[NSString alloc]init];

    paramString = [ZCSharedAppsEventsParamsUtil getAddtoPickListParamsWithAPPS:apps Forms:forms fields:fields viewLinkname:viewLinkname recordID:recordID];
    
    if (deluge) {
    
    if (apps.count) {
//    paramString =[paramString stringByAppendingFormat:@"&childFormAccessType=5"];
//        paramString =[paramString stringByAppendingFormat:@"&childFieldLabelName=xxxx&childFormLinkName=Single_Line&childAppLinkName=all-fields&rowNo=-1&recType=5&lookupFieldName=ID&appLinkName=xxx"];
    }
    }
    return paramString;
    
    
}
@end
