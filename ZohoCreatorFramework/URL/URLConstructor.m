//
//  URLConstructor.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "URLConstructor.h"
#import "ZCSharedAppsEventsParamsUtil.h"
@interface URLConstructor(hidden)

+ (NSString*) appendAuthToken : (NSString*) urlString;
+ (NSString*) appendAuthTokenWithAppOwner : (NSString*) urlString;
+ (NSString*) constructViewParameter : (ZCViewParam*) viewParameter;
+ (NSString*) constructRecordCountParameter : (ZCViewParam*) viewParameter;

@end

static NSString *CREATOR_URL;
static NSString *ACCOUNTS_URL;
static NSString *SERVICE_NAME;

/*
formAccessType
int FORM_ALONE =1;
int VIEW_ADD_FORM =2;
int VIEW_EDIT_FORM =3;
int VIEW_BULK_EDIT_FORM =4;
int FORM_LOOKUP_ADD_FORM =5;
*/
 
@implementation URLConstructor

+ (NSString*) formURL : (NSString*) appLinkName formName : (NSString*) formLinkName withApplicationOwner: (NSString *) appOwner {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/%@/json/%@/form/%@/fields/",appOwner,appLinkName,formLinkName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    formURL = [formURL stringByAppendingString:@"&metaData=complete"];
    
    
    NSLog(@"frm URL %@",appOwner);
//    formURL = [formURL stringByAppendingFormat:@"&sharedBy=%@",appOwner];
    return formURL;
}

+(NSString *)formURLforAddTOFickListAppname:(NSString *)  appLinkName formName : (NSString*) formLinkName withApplicationOwner: (NSString *) appOwner childappsINORDER:(NSArray *)childappINORDER childFormsINORDER:(NSArray *)childFormsINORDER baseFieldsINORDER:(NSArray *)baseFieldsINORDER recordID :(NSString *)recID viewLinkname:(NSString *)viewLinkname;
{

    NSString * formURL=[URLConstructor formURL:appLinkName formName:formLinkName withApplicationOwner:appOwner];
//    for(int appInd=0;appInd<childappNamesINORDER.count;appInd++)
//    {
//    
//        formURL = [formURL stringByAppendingFormat:@"&zc_childappname_%i=%@",appInd+1,[childappNamesINORDER objectAtIndex:appInd]];
//        formURL = [formURL stringByAppendingFormat:@"&zc_childformname_%i=%@",appInd+1,[childFormNameINORDER objectAtIndex:appInd]];
//        formURL = [formURL stringByAppendingFormat:@"&zc_childlabelname_%i=%@",appInd+1,[baseFieldNameINORDER objectAtIndex:appInd]];
//    }
//    
//    formURL = [formURL stringByAppendingFormat:@"&zc_lookupCount=%i",childFormNameINORDER.count];
//    formURL = [formURL stringByAppendingFormat:@"&formAccessType=5"];
//    
//    NSLog(@"recLinkID %@ %@",recID,viewLinkname);
//    if (recID.length) {
//        formURL = [formURL stringByAppendingFormat:@"&recLinkID=%@",recID];
//    }
//    if (viewLinkname.length) {
//        
//        formURL = [formURL stringByAppendingFormat:@"&viewLinkName=%@",viewLinkname];
//
//    }
    
    formURL =[formURL stringByAppendingString:[ZCSharedAppsEventsParamsUtil getAddtoPickListParamsWithAPPS:childappINORDER Forms:childFormsINORDER fields:baseFieldsINORDER viewLinkname:viewLinkname recordID:recID]];
    formURL = [formURL stringByAppendingFormat:@"&formAccessType=5"];
    
    return formURL;
    
//https://creator.zoho.com/api/riyazmd/json/all-fields/form/Single_Line/fields/authtoken=803356c6d1cbf52dfabb68f0ce8a99ff&scope=creatorapi&metaData=complete&formAccessType=5&zc_lookupCount=1&zc_childappname_1=all-fields&zc_childformname_1=Lookup&zc_childlabelname_1=Lookup_plus_add
    
    
//https://creator.zoho.com/api/all-fields/json/all-fields/form/Single_Line/fields/authtoken=803356c6d1cbf52dfabb68f0ce8a99ff&scope=creatorapi&metaData=complete&zc_childappname_1=all-fields&zc_childformname_1=all-fields&zc_childlabelname_1=Lookup_plus_add&zc_lookupCount=1&formAccessType=5
    
//https://creator.zoho.com/api/all-fields/json/all-fields/form/Single_Line/fields/authtoken=803356c6d1cbf52dfabb68f0ce8a99ff&scope=creatorapi&metaData=complete&zc_childappname_1=Single_Line&zc_childformname_1=Single_Line&zc_childlabelname_1=Lookup_plus_add&zc_lookupCount=1&formAccessType=5
//https://creator.zoho.com/api/all-fields/json/all-fields/form/Single_Line/fields/authtoken=803356c6d1cbf52dfabb68f0ce8a99ff&scope=creatorapi&metaData=complete&zc_childappname_1=Single_Line&zc_childformname_1=Single_Line&zc_childlabelname_1=Lookup_plus_add&zc_lookupCount=1&formAccessType=5


}

+ (NSString*) formURL : (NSString*) appLinkName formName : (NSString*) formLinkName viewName:(NSString*) viewLinkName withApplicationOwner: (NSString *) appOwner
{
    NSString *formURL = [self formURL:appLinkName formName:formLinkName withApplicationOwner:appOwner];
    formURL = [formURL stringByAppendingString:[NSString stringWithFormat:@"&viewLinkName=%@&formAccessType=%d",viewLinkName,2]];
    return formURL;
}

+ (NSString*) appListURL  {
    
    NSString *appList = @"/api/xml/applications/";
    appList = [[URLConstructor serverURL:false] stringByAppendingString:appList];
    appList = [URLConstructor appendAuthToken:appList];
    appList = [appList stringByAppendingString:@"&action=license"];
    NSLog(@"gee appListURL %@",appList);

    return appList;
}

+ (NSString*) sharedAppListURL  {
    
    //    NSString *appList = @"/api/mobile/xml/sharedapp/?";
    NSString *appList = @"/api/xml/sharedapps/";
    appList = [[URLConstructor serverURL:false] stringByAppendingString:appList];
    appList = [URLConstructor appendAuthToken:appList];
    appList = [appList stringByAppendingString:@"&action=license"];
    NSLog(@"gee sharedAppListURL %@",appList);

    return appList;
}

+ (NSString*) sharedAppListURL : (NSString *) groupid  {
    
    NSString *appList = @"/api/xml/sharedapps/";
    appList = [[URLConstructor serverURL:false] stringByAppendingString:appList];
    appList = [URLConstructor appendAuthToken:appList];
    appList = [appList stringByAppendingFormat:@"&groupid=%@",groupid];
    NSLog(@"gee sharedAppListURL %@",appList);

    return appList;
}

+ (NSString*) workSpaceAppListURL : (NSString *) workspaceowner  {
    
    NSString *appList = @"/api/xml/workspaceapps/";
    appList = [[URLConstructor serverURL:false] stringByAppendingString:appList];
    appList = [URLConstructor appendAuthToken:appList];
    appList = [appList stringByAppendingString:@"&action=license"];
    appList = [appList stringByAppendingFormat:@"&workSpaceOwner=%@",workspaceowner];
    NSLog(@"gee workSpaceAppListURL %@",appList);

    return appList;
}

+ (NSString*) allAppsCategoryListURL  {
    
    NSString *appList = @"/api/xml/allappscategory/";
    appList = [[URLConstructor serverURL:false] stringByAppendingString:appList];
    appList = [URLConstructor appendAuthToken:appList];
    NSLog(@"gee allAppsCategoryListURL %@",appList);

    return appList;
}

+ (NSString*) sectionMetaURL : (NSString*) appLinkName appOwner: (NSString *) appOwner {
    
    NSString *sectionMeta = [NSString stringWithFormat:@"/api/mobile/xml/%@/sections/",appLinkName];
    sectionMeta = [[URLConstructor serverURL:false] stringByAppendingString:sectionMeta];
    sectionMeta = [URLConstructor appendAuthToken:sectionMeta];
    sectionMeta = [sectionMeta stringByAppendingFormat:@"&sharedBy=%@",appOwner];

    //// //NSLog(@"Section Meta URL %@",sectionMeta);
    return sectionMeta;
}

+ (NSString*) uploadURL : (NSString*) applicationName : (NSString*) formName : (NSString*) fieldName : (NSString*) recordID : (NSString*) fileName : (NSString*) appOwner {
    
    NSString *sectionMeta = @"/api/xml/fileupload/";
    sectionMeta = [[URLConstructor serverURL:false] stringByAppendingString:sectionMeta];
    sectionMeta = [URLConstructor appendAuthToken:sectionMeta];
    sectionMeta = [sectionMeta stringByAppendingFormat:@"&applinkname=%@&formname=%@&fieldname=%@&recordId=%@&filename=%@&sharedBy=%@",applicationName,formName,fieldName,recordID,fileName,appOwner];
    return sectionMeta;
}

+ (NSString*) sectionMetaURL : (NSString*) appLinkName : (NSString*) section appOwner: (NSString *) appOwner{
    
    NSString *sectionMeta = [NSString stringWithFormat:@"/api/mobile/xml/%@/sections/",appLinkName];
    sectionMeta = [[URLConstructor serverURL:false] stringByAppendingString:sectionMeta];
    sectionMeta = [URLConstructor appendAuthToken:sectionMeta];

    // sectionMeta = [sectionMeta stringByAppendingFormat:@"&appowner=%@",appOwner];
    return sectionMeta;
}

+ (NSString*) viewURL : (NSString*) appLinkName : (NSString*) viewLinkName appOwner: (NSString *) appOwner{
    
    NSString *viewURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/view/%@/",appLinkName,viewLinkName];
    viewURL = [[URLConstructor serverURL:false] stringByAppendingString:viewURL];
    viewURL = [URLConstructor appendAuthToken:viewURL];
    viewURL = [viewURL stringByAppendingFormat:@"&sharedBy=%@",appOwner];
    return viewURL;
}

+ (NSString*) viewURL : (NSString*) appLinkName : (NSString*) viewLinkName withParam : (ZCViewParam*) viewParam appOwner: (NSString *) appOwner{
    
    NSString *viewURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/view/%@/",appLinkName,viewLinkName];
    viewURL = [[URLConstructor serverURL:false] stringByAppendingString:viewURL];
    viewURL = [URLConstructor appendAuthToken:viewURL];
    viewURL = [viewURL stringByAppendingString:[URLConstructor constructViewParameter : viewParam]];
    viewURL = [viewURL stringByAppendingFormat:@"&sharedBy=%@",appOwner];
    return viewURL;
}

+ (NSString*) downloadFile : (NSString*) filePath viewLinkName : (NSString*) viewLinkName  : (NSString*) appLinkName : (NSString*) appOwner {
    
    NSString *downloadURL = [NSString stringWithFormat:@"/DownloadFileFromMig.do?filepath=%@&appLinkName=%@&viewLinkName=%@&sharedBy=%@&",filePath,appLinkName,viewLinkName,appOwner];
    downloadURL = [[URLConstructor serverURL:false] stringByAppendingString:downloadURL];
    downloadURL = [URLConstructor appendAuthToken:downloadURL];
    
    NSLog(@"image download url %@",downloadURL);
    return downloadURL;
}

+ (NSString*) htmlView : (NSString*) appLinkName htmlViewLinkName : (NSString*) htmlViewLinkName applicationOwner : (NSString*) appOwner {
    
    NSString *htmlViewURL = [NSString stringWithFormat:@"/showHtmlViewApi.do?appLinkName=%@&viewLinkName=%@&sharedBy=%@&",appLinkName,htmlViewLinkName,appOwner];
    htmlViewURL = [[URLConstructor serverURL:false] stringByAppendingString:htmlViewURL];
    htmlViewURL = [URLConstructor appendAuthToken:htmlViewURL];
    return htmlViewURL;
}

+ (NSString*) formMetaURL : (NSString*) appLinkName : (NSString*) formLinkName appOwner: (NSString *) appOwner{
    
    NSString *formURL = [NSString stringWithFormat:@"/api/xml/%@/%@/fields/",appLinkName,formLinkName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    formURL = [formURL stringByAppendingString:@"&complete=true&combinedLookup=true"];
    formURL = [formURL stringByAppendingFormat:@"&sharedBy=%@",appOwner];
    
    return formURL;
}

+(NSString *) subformMetaURL:(NSString *)appLinkName formLinkname:(NSString *)formLinkName mainAppLinkname:(NSString *)mainAppLinkname  mainFormLinkname:(NSString *)mainFormLinkname subformFieldLinkname:(NSString *)subformFieldLinkname appOwner:(NSString *)appOwner
{
    
    
    
    NSString *formURL = [NSString stringWithFormat:@"/api/xml/%@/%@/fields/",appLinkName,formLinkName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    formURL = [formURL stringByAppendingString:@"&complete=true&combinedLookup=true"];
    formURL = [formURL stringByAppendingFormat:@"&sharedBy=%@",appOwner];
    formURL =[formURL stringByAppendingFormat:@"&isSubFormMeta=true&refAppLinkName=%@&refFormLinkName=%@&refFieldName=%@",mainAppLinkname,mainFormLinkname,subformFieldLinkname];
    
    
    return formURL;
    
    
    }


+ (NSString*) editFormMetaJSON : (NSString*) _appLinkName : (NSString*) _viewLinkName : (NSString*) _recordLinkID : (NSString*) appOwner {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/%@/json/%@/view/%@/record/%@/edit/",appOwner,_appLinkName,_viewLinkName,_recordLinkID];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    formURL = [formURL stringByAppendingString:@"&metaData=complete"];
    return formURL;
}


+ (NSString*) editFormMetaURL1 : (NSString*) appLinkName : (NSString*) formLinkName viewLinkName : (NSString*) viewLinkName recordLinkID : (NSString*) _recordLinkID appOwner: (NSString *) appOwner{
    
    NSString *formURL = [NSString stringWithFormat:@"/api/xml/%@/%@/fields/",appLinkName,formLinkName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    formURL = [formURL stringByAppendingFormat:@"&complete=true&combinedLookup=true&recLinkID=%@&viewLinkName=%@",_recordLinkID,viewLinkName];
    formURL = [formURL stringByAppendingFormat:@"&sharedBy=%@",appOwner];
    return formURL;
}


//https://creator.zoho.com/api/<ownername>/<format>/<applicationName>/view/<viewname>/record/<recordlinkid>/edit

+ (NSString*) editFormMetaURL : (NSString*) appLinkName : (NSString*) formLinkName recordLinkID : (NSString*) _recordLinkID appOwner: (NSString *) appOwner{
    
    NSString *formURL = [NSString stringWithFormat:@"/api/xml/%@/%@/fields/",appLinkName,formLinkName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    formURL = [formURL stringByAppendingFormat:@"&complete=true&combinedLookup=true&recLinkID=%@",_recordLinkID];
    formURL = [formURL stringByAppendingFormat:@"&sharedBy=%@",appOwner];
    return formURL;
}

+ (NSString*) delugeURL {
    
    NSString *formURL = @"/generateJSAPI.do";
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    return formURL;
}

+ (NSString*) formOnLoadWithJSON :(NSString*) appLinkName : (NSString*) formLinkName : (NSString*) _zcRecord : (NSString*) appOwner {
    
    NSString *formURL = [NSString stringWithFormat:@"sharedBy=%@&linkNameBased=true&appLinkName=%@&formLinkName=%@&",appOwner,appLinkName,formLinkName];
    formURL = [URLConstructor appendAuthToken:formURL];
    NSLog(@"new json url %@",formURL);
//    formURL = [formURL stringByAppendingFormat:@"&xmlString=%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    return formURL;
}

+ (NSString*) formOnLoad:(NSString*) appLinkName : (NSString*) formLinkName : (NSString*) paramString : (NSString*) appOwner {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/OnLoad/",appLinkName,formLinkName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    formURL = [formURL stringByAppendingFormat:@"&xmlString=%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    formURL = [formURL stringByAppendingFormat:@"&sharedBy=%@",appOwner];
    //// //NSLog(@"On load URL %@",formURL);
    
    return formURL;
}

+ (NSString*) formEditOnLoad:(NSString*) appLinkName : (NSString*) formLinkName  : (NSString*) paramString : (NSString*) appOwner {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/OnEditLoad/",appLinkName,formLinkName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    formURL = [formURL stringByAppendingFormat:@"&xmlString=%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    formURL = [formURL stringByAppendingFormat:@"&sharedBy=%@",appOwner];
    //// //NSLog(@"On Edit URL %@",formURL);
    return formURL;
}

+ (NSString*) subFormOnuser : (NSString*) appLinkName : (NSString*) formLinkName : (NSString*) fieldName : (NSString*) refAppName : (NSString*) refFormName : (NSString*) refFieldName : (NSString*) paramString : (NSString*) appOwner {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/SubOnUser/%@/",appLinkName,formLinkName,fieldName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    formURL = [formURL stringByAppendingFormat:@"&xmlString=%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    formURL = [formURL stringByAppendingFormat:@"&refAppLinkName=%@&refFormLinkName=%@&refFieldName=%@",refAppName,refFormName,refFieldName];
    formURL = [formURL stringByAppendingFormat:@"&sharedBy=%@",appOwner];
    return formURL;
}

+ (NSString*) sunFormOnUser:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) subFormName : (NSString*) fieldLinkName {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/SubOnUser/%@/%@/",appLinkName,formLinkName,subFormName,fieldLinkName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    return formURL;
}


+ (NSString*) fieldOnUser:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) fieldLinkName : (NSString*) paramString {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/OnUser/%@/",appLinkName,formLinkName,fieldLinkName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    if(paramString != nil) {
        formURL = [formURL stringByAppendingFormat:@"&xmlString=%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }
    return formURL;
}

+ (NSString*) fieldOnUserWithJSON:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) fieldLinkName : (NSString*) paramString : (NSString*) appOwner {
    
    NSString *formURL = [NSString stringWithFormat:@"sharedBy=%@&linkNameBased=true&appLinkName=%@&formLinkName=%@&fieldName=%@&",appOwner,appLinkName,formLinkName,fieldLinkName];
    formURL = [URLConstructor appendAuthToken:formURL];


    if(paramString != nil) {
formURL = [formURL stringByAppendingFormat:@"%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }
    
//    return @"Single_Line=&Single_Line1=&SF(SubForm).FD(t::row_1).SV(record::status)=added&SF(SubForm).FD(t::row_1).SV(Multi_Line)=&SF(SubForm).FD(t::row_1).SV(Single_Line)=riyazheehdh&authtoken=a6068ae81f07813b3c264276863792d4&scope=creatorapi&sharedBy=vignesh.rajamani&appLinkName=riyazsubformapp&formLinkName=Untitled_Form&linkNameBased=true&fieldName=SubForm&subformFieldName=Single_Line&subfcname=SF(SubForm).FD(t::row_1).SV(Single_Line)&rowseqid=t::row_1";
    return formURL;
}
+ (NSString*) subFormOnuserWithJSON : (NSString*) appLinkName formLinkname: (NSString*) formLinkName fieldlinkname: (NSString*) fieldName subformFieldName:(NSString *)subformFieldname rowNumberincaseOFsubofrmField:(int)rownum param: (NSString*) paramString appowner: (NSString*) appOwner

{
//    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/SubOnUser/%@/",appLinkName,formLinkName,fieldName];
    
    NSString *formURL = [NSString stringWithFormat:@"sharedBy=%@&linkNameBased=true&appLinkName=%@&formLinkName=%@&fieldName=%@&",appOwner,appLinkName,formLinkName,fieldName];

    formURL = [URLConstructor appendAuthToken:formURL];
    if(paramString != nil) {
        formURL = [formURL stringByAppendingFormat:@"%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }
    
    
    
    formURL=[formURL stringByAppendingFormat:@"&subformFieldName=%@",subformFieldname];
    
    formURL=[formURL stringByAppendingFormat:@"&rowseqid=t::row_%i",rownum];
    

    return formURL;
}


+ (NSString*) fieldOnUserFormaula:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) fieldLinkName : (NSString*) paramString {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/OnUserFormula/%@/",appLinkName,formLinkName,fieldLinkName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    if(paramString != nil) {
        formURL = [formURL stringByAppendingFormat:@"&xmlString=%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }
    return formURL;
}

+ (NSString*) customActionURL : (NSString*) appLinkName : (NSString*) viewLinkName : (NSString*) functionId : (NSString*) sharedBy : (NSMutableArray*) recordIds {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/OnExecute/%@/",appLinkName,viewLinkName,functionId];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    formURL = [formURL stringByAppendingFormat:@"&sharedBy=%@",sharedBy];
    
    if(recordIds != nil) {
        for(NSInteger index=0;index<[recordIds count];index++) {
            formURL = [formURL stringByAppendingFormat:@"&functiongroup=%@",[recordIds objectAtIndex:index]];
        }
    }
    return formURL;
}

+ (NSString*) userDetailsURL  {
    
    NSString *userDetailsURL = @"/api/xml/user/";
    userDetailsURL = [[URLConstructor serverURL:false] stringByAppendingString:userDetailsURL];
    userDetailsURL = [URLConstructor appendAuthToken:userDetailsURL];
    return userDetailsURL;
}

+ (NSString*) paymentDetails : (NSString*) ownerName {
    
    NSString *paymentURL = [NSString stringWithFormat:@"/api/xml/license/mobile/%@/",ownerName];
    paymentURL = [[URLConstructor serverURL:false] stringByAppendingString:paymentURL];
    paymentURL = [URLConstructor appendAuthToken:paymentURL];
    return paymentURL;
}





+ (NSString*) newsubmitRecordURL {
    
    NSString *recordURL = @"/api/xml/write/";
    recordURL = [[URLConstructor serverURL:false] stringByAppendingString:recordURL];
    return recordURL;
}

+ (NSString*) submitRecordURL {
    
    NSString *recordURL = @"/api/xml/write/";
    recordURL = [[URLConstructor serverURL:false] stringByAppendingString:recordURL];
    return recordURL;
}

+ (NSString*) updateRecordURL {
    
    NSString *recordURL = @"/api/xml/write/";
    recordURL = [[URLConstructor serverURL:false] stringByAppendingString:recordURL];
    return recordURL;
}

+ (NSString*) writeURL {
    
    NSString *recordURL = @"/api/xml/write/";
    recordURL = [[URLConstructor serverURL:false] stringByAppendingString:recordURL];
    return recordURL;
}

+ (NSString*) newRecordURL : (NSString*) appLinkName : (NSString*) formLinkName {
    
    NSString *recordURL = [NSString stringWithFormat:@"/api/xml/%@/%@/add/",appLinkName,formLinkName];
    recordURL = [[URLConstructor serverURL:false] stringByAppendingString:recordURL];
    return recordURL;
}

+ (NSString*) editRecordURL : (NSString*) appLinkName : (NSString*) formLinkName {
    
    NSString *recordURL = [NSString stringWithFormat:@"/api/xml/%@/%@/update",appLinkName,formLinkName];
    recordURL = [[URLConstructor serverURL:false] stringByAppendingString:recordURL];
    recordURL = [URLConstructor appendAuthToken:recordURL];
    return recordURL;
}

+ (NSString*) deleteRecordURL : (NSString*) appLinkName : (NSString*) formLinkName {
    
    NSString *recordURL = [NSString stringWithFormat:@"/api/xml/%@/%@/delete",appLinkName,formLinkName];
    recordURL = [[URLConstructor serverURL:false] stringByAppendingString:recordURL];
    recordURL = [URLConstructor appendAuthToken:recordURL];
    return recordURL;
}

+ (NSString*) postAuthToken {
    
    ZOHOUser *user = [ZOHOUser userObject];
    NSString *urlString = [NSString stringWithFormat:@"authtoken=%@&scope=creatorapi",[user authToken]];
    return urlString;
}

+ (NSString*) postAuthTokenWithAppOwner {
    
    ZOHOUser *user = [ZOHOUser userObject];
    NSString *urlString = [NSString stringWithFormat:@"authtoken=%@&scope=creatorapi&sharedBy=%@",[user authToken],[user userName]];
    return urlString;
}

+ (NSString*) postAuthTokenWithAppOwner : (NSString*) appOwner {
    
    ZOHOUser *user = [ZOHOUser userObject];
    NSString *urlString = [NSString stringWithFormat:@"authtoken=%@&scope=creatorapi&zc_ownername=%@",[user authToken],appOwner];
    return urlString;
}

+ (NSString*) postAuthTokenWithApplication : (ZCApplication*) _application {
    
    ZOHOUser *user = [ZOHOUser userObject];
    NSString *urlString = [NSString stringWithFormat:@"authtoken=%@&scope=creatorapi&sharedBy=%@",[user authToken],[_application appOwner]];
    return urlString;
}


+ (NSString*) recordCountURL : (NSString*) appLinkName : (NSString*) viewLinkName withParam : (ZCViewParam*) viewParam appOwner: (NSString *) appOwner{
    
    NSString *viewURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/recordcount/%@/",appLinkName,viewLinkName];
    viewURL = [[URLConstructor serverURL:false] stringByAppendingString:viewURL];
    viewURL = [URLConstructor appendAuthToken:viewURL];
    viewURL = [viewURL stringByAppendingString:[URLConstructor constructRecordCountParameter : viewParam]];
    viewURL = [viewURL stringByAppendingFormat:@"&sharedBy=%@",appOwner];
    return viewURL;
}


+ (NSString*) deleteAuthToken : (NSString*) authToken  {
    
    if (ACCOUNTS_URL == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ZCProperty" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
        
        if ([dict objectForKey:@"AccountsURL"] != nil) {
            ACCOUNTS_URL = [dict objectForKey:@"AccountsURL"];
            SERVICE_NAME =[dict objectForKey:@"ServiceName"];
        }
        else
        {
            ACCOUNTS_URL = @"accounts.zoho.com";
            SERVICE_NAME = @"ZohoCreator";
        }
    }
    
    NSString *deleteAuth = [NSString stringWithFormat:@"https:/%@/apiauthtoken/delete?AUTHTOKEN=%@",ACCOUNTS_URL,authToken];
    return deleteAuth;
}

+ (NSString*) accountsURL : (NSString*) userName : (NSString*) password {
    if (ACCOUNTS_URL == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ZCProperty" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
        
        if ([dict objectForKey:@"AccountsURL"] != nil) {
            ACCOUNTS_URL = [dict objectForKey:@"AccountsURL"];
            SERVICE_NAME =[dict objectForKey:@"ServiceName"];
        }
        else
        {
            ACCOUNTS_URL = @"accounts.zoho.com";
            SERVICE_NAME = @"ZohoCreator";
        }
    }
    
    NSString *accountURL = [NSString stringWithFormat:@"https://%@/apiauthtoken/nb/create?SCOPE=%@/creatorapi&EMAIL_ID=%@&PASSWORD=%@",ACCOUNTS_URL, SERVICE_NAME, userName,password];
    return accountURL;
}
+(NSString *)accountsURL
{
    if (ACCOUNTS_URL == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ZCProperty" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
        
        if ([dict objectForKey:@"AccountsURL"] != nil) {
            ACCOUNTS_URL = [dict objectForKey:@"AccountsURL"];
            SERVICE_NAME =[dict objectForKey:@"ServiceName"];
        }
        else
        {
            ACCOUNTS_URL = @"accounts.zoho.com";
            SERVICE_NAME = @"ZohoCreator";
        }
    }
    
    NSString *accountURL = [NSString stringWithFormat:@"https://%@",ACCOUNTS_URL];
    return accountURL;
}

+ (NSString*) buttonOnClick:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) buttonName : (NSString*) paramString
{
    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/OnClick/%@/",appLinkName,formLinkName,buttonName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    if(paramString != nil) {
        formURL = [formURL stringByAppendingFormat:@"&xmlString=%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }
    return formURL;
}

+ (NSString*) subFormAddRow:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) fieldName : (NSString*) paramString {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/OnAddRow/%@/",appLinkName,formLinkName,fieldName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    if(paramString != nil) {
        formURL = [formURL stringByAppendingFormat:@"&xmlString=%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }
    return formURL;
}

+ (NSString*) subFormOnUser:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) fieldName : (NSString*) paramString {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/OnDeleteRow/%@/",appLinkName,formLinkName,fieldName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    if(paramString != nil) {
        formURL = [formURL stringByAppendingFormat:@"&xmlString=%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }
    return formURL;
}

+ (NSString*) subFormDeleteRow:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) fieldName : (NSString*) paramString {
    
    NSString *formURL = [NSString stringWithFormat:@"/api/mobile/xml/%@/%@/OnDeleteRow/%@/",appLinkName,formLinkName,fieldName];
    formURL = [[URLConstructor serverURL:false] stringByAppendingString:formURL];
    formURL = [URLConstructor appendAuthToken:formURL];
    if(paramString != nil) {
        formURL = [formURL stringByAppendingFormat:@"&xmlString=%@",[paramString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }
    return formURL;
}

+ (NSString*)  serverURL : (BOOL) secureConnection {
    
    NSString *protocol = @"http://";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZCProperty" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    if (CREATOR_URL == nil) {
        
        if ([dict objectForKey:@"CreatorURL"] != nil) {
            CREATOR_URL = [dict objectForKey:@"CreatorURL"];
        }
        else
        {
            CREATOR_URL = @"creator.zoho.com";
        }
    }
    
    if ([dict objectForKey:@"protocol"] != nil) {
        protocol = [dict objectForKey:@"protocol"];
    }
    return [NSString stringWithFormat:@"%@%@",protocol,CREATOR_URL];
}

+(NSString *)authenticationUrl
{
    
    //    NSString * authenticationUrl=[NSString stringWithFormat:@"%@/login?scopes=creatorapi/Creator&appname=ZohoCreator&serviceurl=%@&hide_fp=false&hide_remember=true&getticket=true&hide_gsignup=false&hidegooglesignin=false",[URLConstructor accountsURL],[URLConstructor serverURL:YES]];
    //
    //
    NSString * authenticationUrl=[NSString stringWithFormat:@"%@/login?scopes=ZohoCreator/creatorapi&serviceurl=%@&hide_fp=false&hide_remember=true&hide_signup=true&hide_gsignup=false&hidegooglesignin=false",[URLConstructor accountsURL],[URLConstructor serverURL:YES]];
    
    
    //    NSString * authenticationUrl=[NSString stringWithFormat:@"https://accounts.zoho.com/login?scopes=JProxy/jmobileapi,ZohoShow/DataAPI&serviceurl=https://creator.zoho.com&hide_fp=false&hide_remember=true&hide_gsignup=false&hidegooglesignin=false&getticket=true"];
    
    //        hide_remember (true / false) - Used to hide Keep me Signed in option.
    //        hide_fp (true / false) - Used to hide Forgot Password option.
    //        hide_gsignup (true/false) - Hides all the open id signins.
    //        hide_signup (true / false) - Hides the Signup button.
    //        hidegooglesignin (true / false) - Hide Google Signin.
    //        hidegappsignup (true / false) - Hide GApp Signin.
    //        hideyahoosignin (true / false) - Hide Yahoo Signin.
    //        hidefbconnect (true / false) - Hide FB Signin.
    //        hide_logo (true / false) - Hide the logo for mobile signin
    //            appinfo (url) - provide help document for the app (refer https://pulse.zoho.com/portal/intranet/stream/105000024446088).
    //
    
    //    NSString * authenticationUrll=[NSString stringWithFormat:@"%@/loginhide_signup=true&hide_fp=true&hide_remember=true&hide_gsignup=true&scopes=creatorapi/ZohoCreator&getticket=true&serviceurl=https://docs.zoho.com&appname=Zoho",[URLConstructor accountsURL]];
    
    
    //    https://accounts.zoho.com/loginhide_signup=true&hide_fp=true&hide_remember=true&hide_gsignup=true&scopes=ZohoPC/docsapi,ZohoShow/DataAPI,ZohoSheet/DataAPI,ZohoWriter/DataAPI&getticket=true&serviceurl=https://docs.zoho.com&appname=Zoho
    
    return authenticationUrl;
}
+(NSString *)construckLookupChoicesURLWithAppLinkname:(NSString *)appLinkName formLinkname:(NSString *)formLinkName lookUpFieldLinkName:(NSString *)lookupFieldName appOwner:(NSString *)appOwner subformComponent:(NSString *)subformComponent searchString: (NSString *)searchString startindex:(int)startIndex limit:(int)limit viewLinkname:(NSString *)viewLinkname recordID:(NSString *)recordID
{
    NSString * lookUpchoiceURL=[NSString stringWithFormat:@"/api/%@/xml/%@/form/%@/lookup/%@/options//",appOwner,appLinkName,formLinkName,lookupFieldName];
    lookUpchoiceURL = [URLConstructor appendAuthToken:lookUpchoiceURL];
    
    lookUpchoiceURL =[lookUpchoiceURL stringByAppendingFormat:@"&limit=%i&appendRows=true&startindex=%i&zcRefValue=true&searchValue=%@",limit,startIndex,searchString];
    
    int formAccestype=1;
    if (viewLinkname.length) {
        
        lookUpchoiceURL =[lookUpchoiceURL stringByAppendingFormat:@"&viewLinkName=%@",viewLinkname];
        formAccestype=2;
    }

    if (recordID.length) {
        
        formAccestype=3;
    }

    lookUpchoiceURL =[lookUpchoiceURL stringByAppendingFormat:@"&formAccessType=%i",formAccestype];

    
    
    lookUpchoiceURL = [[URLConstructor serverURL:false] stringByAppendingString:lookUpchoiceURL];
    
    
    return lookUpchoiceURL;
    
    //https://creator.localzoho.com/api/charles/xml/sales-data123/form/Lookup_testing/lookup/Sales_Data/options//authtoken=eb7285f9bd1b913cd8ebb8b1abb25d4b&scope=creatorapi&limit=50&appendRows=true&startindex=0&zcRefValue=true&searchValue=cha
    
    
}

+(NSString *)subFormAddRowWithAppLinkname:(NSString *)appLinkName formLinkName:(NSString *)formLinkName fieldLinkName:(NSString *)fieldLinkName numberofsubformEntries:(int)numberofsubformEntries appOwner:(NSString *)appOwner recordParm:(NSString *)params  
{
    NSString * paramString=[[NSString alloc]init];
    paramString=[paramString stringByAppendingString:[URLConstructor postAuthToken]];
    NSLog(@"param  string %@",paramString);

    paramString =[paramString stringByAppendingString:params];

               paramString =[paramString stringByAppendingFormat:@"&sharedBy=%@",appOwner];
//    NSLog(@"param  string %@",paramString);

    
               paramString =[paramString stringByAppendingFormat:@"&appLinkName=%@",appLinkName];
//    NSLog(@"param  string %@",paramString);

               paramString =[paramString stringByAppendingFormat:@"&formLinkName=%@",formLinkName];
//    NSLog(@"param  string %@",paramString);

               paramString =[paramString stringByAppendingFormat:@"&linkNameBased=true"];
//    NSLog(@"param  string %@",paramString);

               paramString =[paramString stringByAppendingFormat:@"&rowactiontype=onaddrow"];
//    NSLog(@"param  string %@",paramString);

               paramString =[paramString stringByAppendingFormat:@"&rowseqid=t::row_%i=",numberofsubformEntries];
//    NSLog(@"param  string %@",paramString);

//    NSLog(@"param  string %@",paramString);
    
    
//        [param appendFormat:@"&rowseqid=t::row_%i",records.count];
    

    
    paramString =[paramString stringByAppendingFormat:@"&fieldName=%@",fieldLinkName];

    
    return paramString;
}

+(NSString *)subFormONDELETERowWithAppLinkname:(NSString *)appLinkName formLinkName:(NSString *)formLinkName fieldLinkName:(NSString *)fieldLinkName deleteRowNumber:(int)deleteRowNumber appOwner:(NSString *)appOwner recordParm:(NSString *)params {
    NSString * paramString=[[NSString alloc]init];
    paramString=[paramString stringByAppendingString:[URLConstructor postAuthToken]];
//    NSLog(@"param  string %@",paramString);
    
    paramString =[paramString stringByAppendingString:params];
    
    paramString =[paramString stringByAppendingFormat:@"&sharedBy=%@",appOwner];
//    NSLog(@"param  string %@",paramString);
    
    
    paramString =[paramString stringByAppendingFormat:@"&appLinkName=%@",appLinkName];
//    NSLog(@"param  string %@",paramString);
    
    paramString =[paramString stringByAppendingFormat:@"&formLinkName=%@",formLinkName];
//    NSLog(@"param  string %@",paramString);
    
    paramString =[paramString stringByAppendingFormat:@"&linkNameBased=true"];
//    NSLog(@"param  string %@",paramString);
    
    paramString =[paramString stringByAppendingFormat:@"&rowactiontype=ondeleterow"];
//    NSLog(@"param  string %@",paramString);
    
      paramString =[paramString stringByAppendingFormat:@"&rowseqid=t::row_%i=",deleteRowNumber];

    
    paramString =[paramString stringByAppendingFormat:@"&fieldName=%@",fieldLinkName];

    
    
    
    
    return paramString;
}

@end
@implementation URLConstructor(hidden)

+ (NSString*) appendAuthToken : (NSString*) urlString {
    
    ZOHOUser *user = [ZOHOUser userObject];
    urlString = [urlString stringByAppendingFormat:@"authtoken=%@&scope=creatorapi",[user authToken]];
    return urlString;
}

+ (NSString*) appendAuthTokenWithAppOwner : (NSString*) urlString {
    
    ZOHOUser *user = [ZOHOUser userObject];
    urlString = [urlString stringByAppendingFormat:@"authtoken=%@&scope=creatorapi&sharedBy=%@",[user authToken],[user userName]];
    return urlString;
}


+ (NSString*) constructViewParameter : (ZCViewParam*) viewParameter {
    
    NSMutableString *returnString = [NSMutableString string];
    if(viewParameter!=nil) {
        if([viewParameter startRecordIndex] !=0 ) {
            [returnString appendFormat:@"&startIndex=%d",[viewParameter startRecordIndex]];
        }
        if([viewParameter recordCount]!=0) {
            [returnString appendFormat:@"&limit=%d",[viewParameter recordCount]];
        }
        
        NSString *filterString = [viewParameter getFilterString];
        if(filterString != nil) {
            [returnString appendFormat:@"&%@",filterString];
        }
        
        NSString *criteriaString = [viewParameter getCriteriaString];
        if(criteriaString != nil) {
            [returnString appendFormat:@"&%@",criteriaString];
        }
        
        NSString *sortByString = [viewParameter getSortByString];
        if(sortByString != nil) {
            [returnString appendFormat:@"&%@",sortByString];
        }
        
        NSString *groupByString = [viewParameter getGroupByString];
        if(groupByString != nil) {
            [returnString appendFormat:@"&%@",groupByString];
        }
        NSString *calString = [viewParameter getCalParamString];
        if (calString != nil) {
            [returnString appendFormat:@"&%@",calString];
        }
        if([viewParameter getPageSize] != 0) {
            [returnString appendFormat:@"&pageSize=%d",[viewParameter getPageSize]];
        }
    }
    return returnString;
}


+ (NSString*) constructRecordCountParameter : (ZCViewParam*) viewParameter {
    
    NSMutableString *returnString = [NSMutableString string];
    if(viewParameter!=nil) {
        /*        if([viewParameter startRecordIndex] !=0 ) {
         [returnString appendFormat:@"&startIndex=%d",[viewParameter startRecordIndex]];
         }
         if([viewParameter recordCount]!=0) {
         [returnString appendFormat:@"&limit=%d",[viewParameter recordCount]];
         }  */
        
        NSString *filterString = [viewParameter getFilterString];
        if(filterString != nil) {
            [returnString appendFormat:@"&%@",filterString];
        }
        
        NSString *criteriaString = [viewParameter getCriteriaString];
        if(criteriaString != nil) {
            [returnString appendFormat:@"&%@",criteriaString];
        }
        
        NSString *sortByString = [viewParameter getSortByString];
        if(sortByString != nil) {
            [returnString appendFormat:@"&%@",sortByString];
        }
        
        NSString *groupByString = [viewParameter getGroupByString];
        if(groupByString != nil) {
            [returnString appendFormat:@"&%@",groupByString];
        }
        NSString *calString = [viewParameter getCalParamString];
        if (calString != nil) {
            [returnString appendFormat:@"&%@",calString];
        }
        /*        if([viewParameter getPageSize] != 0) {
         [returnString appendFormat:@"&pageSize=%d",[viewParameter getPageSize]];
         }  */
    }
    return returnString;
}


@end
