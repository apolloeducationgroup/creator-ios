//
//  ZOHOCreator.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 27/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ZOHOCreator.h"
#import "LookUPChoiceParser.h"

static ZOHOCreator *creatorObject = nil;

@interface ZOHOCreator(hidden)

@end

@implementation ZOHOCreator

+ (ZOHOCreator*) getObject {
    

    if([ZOHOUser userObject] != nil) {
        if(creatorObject==nil) {
            [ZOHOCreator constructZOHOCreator:[ZOHOUser userObject]];
        }
        return creatorObject;

    }
    else {
        [NSException raise:@"ZOHO Creator" format:@"User Authrntication not present"];
    }
    return nil;
}

+ (void) createZOHOCreator  : (NSString*) userName : (NSString*) password {
    
}

- (ZOHOCreator*) initZOHOCreator : (NSString*) userName : (NSString*) password {
    
    self = [super init];
    if(self) {
        self->_zohoUser = [[ZOHOUser alloc ]initZOHOUser:userName:password];
        ////// //NSLog(@"Auth Token %@",[self->_zohoUser authToken]);
    }
    creatorObject = self;
    return self;
}


+ (void) constructZOHOCreator : (ZOHOUser*) zohoUser {
    
    creatorObject =  [[ZOHOCreator alloc] initZOHOCreator:zohoUser];
}



- (ZOHOCreator*) initZOHOCreator : (ZOHOUser*) zohoUser {
    
    self = [super init];
    if(self) {
        self->_zohoUser = zohoUser;
    }
    creatorObject = self;
    return self;
}

- (ZCApplicationList*) getSharedApplicationList {
    
    return nil;
}

- (ZCApplicationList*) getWorkSpaceApplicationList : (NSString *) workspaceowner {
    
    ////// //NSLog(@"Cominf to get application list");
    
    if(_appList == nil) {
        return [self getWorkSpaceApplicationList:YES workspaceowner:workspaceowner];
    }
    else {
        return _appList;
    }
}


- (ZCApplicationList*) getWorkSpaceApplicationList : (BOOL) fromServer workspaceowner:(NSString *) workspaceowner{
    
    if(fromServer == YES) {
        ZCWorkSpaceAppListFetcher *fetcher = [[ZCWorkSpaceAppListFetcher alloc] initWorkSpaceAppListFetcher:workspaceowner];
        _appList = [fetcher applicationList];
        return _appList;
    }
    else {
        return [self getWorkSpaceApplicationList:workspaceowner];
    }
}

- (ZCAllAppsCategory *) getSharedCategoryList {
    
    ////// //NSLog(@"Cominf to get application list");
    
    if(_sharedCategoryList == nil) {
        return [self getSharedCategoryList:YES];
    }
    else {
        return _sharedCategoryList;
    }
}

- (ZCAllAppsCategory *) getSharedCategoryList : (BOOL) fromServer {
    
    if(fromServer == YES) {
        ZCAppsCategoryListFetcher *fetcher = [[ZCAppsCategoryListFetcher alloc] initZCAppsCategoryListFetcher];
        _sharedCategoryList = [fetcher allAppsCategoryList];
        return _sharedCategoryList;
    }
    else {
        return [self getSharedCategoryList];
    }
}

- (ZCApplicationList*) getSharedApplicationList : (BOOL) fromServer GroupID:(NSString *)groupId{
    
    if(fromServer == YES) {
        ZCSharedAppListFetcher *fetcher = [[ZCSharedAppListFetcher alloc] initSharedAppListFetcherForGroup:groupId];
        _appList = [fetcher applicationList];
        return _appList;
    }
    else {
        return [self getSharedApplicationList];
    }
}

+ (BOOL) deleteRecordWithID : (NSString*) recordLinkID withViewName : (NSString*) viewName andAppName : (NSString*) appLinkName {
    
    return YES;
}

- (ZCApplicationList*) getSharedApplicationList : (BOOL) fromServer {
    
    if(fromServer == YES) {
        ZCSharedAppListFetcher *fetcher = [[ZCSharedAppListFetcher alloc] initSharedAppListFetcher];
        _appList = [fetcher applicationList];
        return _appList;
    }
    else {
        return [self getSharedApplicationList];
    }
}

- (ZCApplicationList*) getApplicationList : (BOOL) fromServer {
    
    if(fromServer == YES) {
        ZCAppListFetcher *fetcher = [[ZCAppListFetcher alloc] initAppListFetcher];
        _appList = [fetcher applicationList];
        return _appList;
    }
    else {
        return [self getApplicationList];
    }
}

- (ZOHOUser*) userObject {
    return [ZOHOUser userObject];
}

+ (ZOHOUser*) userObject {
    return [ZOHOUser userObject];
}

- (ZCApplicationList*) getApplicationList {
    
    ////// //NSLog(@"Cominf to get application list");
    
    if(_appList == nil) {
        return [self getApplicationList:YES];
    }
    else {
        return _appList;
    }
}

- (ZCApplication*) getApplication : (NSString*) appLinkName appOwner:(NSString *)appOwner {
    
    [self getApplicationList];
    
    NSLog(@"getapplication riyaz %@ ",appLinkName);
    if(_appList != nil) {
        for(NSInteger index=0;index<[[_appList applicationList] count];index++) {
            
            ZCApplication *app = [[_appList applicationList] objectAtIndex:index];
            NSLog(@"getapplication riyaz %@  %@ %@",appLinkName,app ,app.appOwner);

            if([[app appLinkName] isEqualToString:appLinkName] && [appOwner isEqualToString:[app appOwner]] ) {
                _currentApp = app;
                NSLog(@"getapplication riyaz found %@ %@  %@",appLinkName,app ,app.appOwner);

                
                return app;
            }
        }
    }
    return nil;
}

- (ZCApplication*) lastAccessedApp {
    
    return _currentApp;
}

+ (ZOHOUser*) login : (NSString*) userName : (NSString*) password {
    
    ZOHOCreator *creator = [[ZOHOCreator alloc] initZOHOCreator:userName :password];
    return [creator userObject];
}

+ (NSArray*) getApplicationList {
    
    //// //NSLog(@"get application list..");
    ZCApplicationList *_appList = [[ZOHOCreator getObject] getApplicationList:YES];
    //// //NSLog(@"app list here.. %@",_appList);
    return [_appList applicationList];
}

+ (NSArray*) getSharedApplicationList {
    
    ZCApplicationList *_appList = [[ZOHOCreator getObject] getSharedApplicationList:YES];
    return [_appList applicationList];
}

+ (NSArray*) getSectionList : (NSString*) appLinkName appOwner : (NSString *) appOwner {
    
    ZCSectionFetcher *fetcher = [[ZCSectionFetcher alloc] initSectionFetcher:appLinkName appOwner:appOwner];
    ZCSections *sections = [fetcher zcSections];
    return [sections sectionList];
}

+ (ZCForm*) getEditFormWithView : (NSString*) appLinkName : (NSString*) formLinkName viewLinkName : (NSString*) viewLinkName recordLinkID : (NSString*) recordLinkID appOwner : (NSString *) appOwner {
    
    ZCFormFetcher *fetcher = [ZCFormFetcher initFormFetcher:appLinkName :formLinkName viewLinkName:viewLinkName recordLinkID:recordLinkID appOwner:appOwner];
    return [fetcher zcForm];
}


+ (ZCForm*) getForAddToPickListappLinkName : (NSString*) appLinkName : (NSString*) formLinkName appOwner : (NSString *) appOwner baseApps:(NSArray *)baseApps baseForms:(NSArray *)baseforms LookUpField:(NSArray *)lookupfields  recordID:(NSString *)recordID viewLinkname:(NSString *)viewLinkname
//                       childappNamesINORDER:(NSArray *)childappNamesINORDER childFormNameINORDER:(NSArray *)childFormNameINORDER baseFieldNameINORDER:(NSArray *)baseFieldNameINORDER;
{
    
    
//    NSLog(@"riyaz lookup %@",lookupfield);
    
    NSMutableArray *childappNamesINORDER=[[NSMutableArray alloc]init];
    NSMutableArray *childFormNameINORDER=[[NSMutableArray alloc]init];

    NSMutableArray *baseFieldNameINORDER=[[NSMutableArray alloc]init];
    for (int index=lookupfields.count;index>0;index--) {
        
      ZCField * field=  [lookupfields objectAtIndex:index-1];
        ZCForm * form=[baseforms objectAtIndex:index -1];
        ZCApplication * app=[baseApps objectAtIndex:index -1];
//     NSLog(@"field linkname  addtopic %@  form %@ %@",field.relatedComponent.linkName,field.relatedComponent.zcApplication.appLinkName,field.fieldName);
        

        [childappNamesINORDER addObject:[app appLinkName]];
        [childFormNameINORDER addObject:form.linkName];
        [baseFieldNameINORDER addObject:field.fieldName];

        
    }
    
    
    

    
    
    
    ZCFormFetcher * fetcher=[ZCFormFetcher initFormFetcherformAddtoPickListForm:appLinkName formLinkname:formLinkName appOwner:appOwner childappsINORDER:baseApps childFormsINORDER:baseforms baseFieldsINORDER:lookupfields recordID:recordID viewLinkName:viewLinkname];

//    ZCFormFetcher * fetcher=[ZCFormFetcher initFormFetcherformAddtoPickListForm:appLinkName formLinkname:formLinkName appOwner:appOwner childappsINORDER:baseApps childFormsINORDER:baseforms baseFieldsINORDER:lookupfields recordID:recordID viewLinkName:viewLinkname];

    
    
//    -(ZCFormFetcher*) initFormFetcherformAddtoPickListForm : (NSString*) appLinkName : (ZCComponent*) component appOwner : (NSString *) appOwner childappNamesINORDER:(NSArray *)childappNamesINORDER childFormNameINORDER:(NSArray *)childFormNameINORDER baseFieldNameINORDER:(NSArray *)baseFieldNameINORDER
    return [fetcher zcForm];

}

+ (ZCForm*) getEditForm : (NSString*) appLinkName : (NSString*) formLinkName recordLinkID : (NSString*) recordLinkID appOwner : (NSString *) appOwner {
    
    ZCFormFetcher *fetcher = [ZCFormFetcher initFormFetcher:appLinkName :formLinkName  recordLinkID:recordLinkID appOwner:appOwner];
    return [fetcher zcForm];
}

+ (ZCForm*) getForm : (NSString*) appLinkName : (NSString*) formLinkName appOwner : (NSString *) appOwner {
    
    ZCFormFetcher *fetcher = [ZCFormFetcher initFormFetcher:appLinkName :formLinkName appOwner:appOwner];
    return [fetcher zcForm];
}

+ (ZCForm*) getForm : (NSString*) appLinkName : (NSString*) formLinkName :(NSString *)viewLinkName appOwner:(NSString *)appOwner {

    ZCFormFetcher *fetcher = [ZCFormFetcher initFormFetcher:appLinkName :formLinkName viewLinkName:viewLinkName appOwner:appOwner];
    return [fetcher zcForm];
}

+(ZCForm*) getSubForm : (NSString*) appLinkName : (NSString*) formLinkName appOwner : (NSString *) appOwner   mainAppLinkname:(NSString *)mainAppLinkname mainFormLinkname:(NSString *)mainFormLinkname subformFieldLinkname:(NSString *)subformFieldLinkname
{
    
    ZCFormFetcher *fetcher = [ZCFormFetcher initSubFormFetcher:appLinkName formLinkname:formLinkName subformmode:YES appOwner:appOwner mainAppLinkname:mainAppLinkname mainFormLinkname:mainFormLinkname subformFieldLinkname:subformFieldLinkname];
    
    return  [fetcher zcForm];
}
+ (ZCView*) getView : (NSString*) appLinkName : (NSString*) viewLinkName appOwner : (NSString *) appOwner {
    
    ZCViewFetcher *fetcher = [ZCViewFetcher initViewFetcher:appLinkName :viewLinkName appOwner:appOwner];
    return [fetcher zcView];
}

+ (ZCView*) getView : (NSString*) appLinkName : (NSString*) viewLinkName withParameter : (ZCViewParam*) viewParam appOwner : (NSString *) appOwner {
    
    ZCViewFetcher *fetcher = [ZCViewFetcher initViewFetcher:appLinkName :viewLinkName  withParam : viewParam appOwner:appOwner];
    return [fetcher zcView];
}

+ (NSDictionary*) submitRecordForForm : (NSString*) formLinkName  WithApplication: (NSString*) appLinkName AndDataDictionary : (NSDictionary*) dataDict{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *newRecord = [URLConstructor newsubmitRecordURL];
    NSString *newRecordString = [URLConstructor postAuthTokenWithAppOwner];
    newRecordString = [newRecordString stringByAppendingFormat:@"&%@&zcRefValue=true",[ZCRecordString newRecordStringXML:appLinkName :formLinkName :dataDict]];
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:newRecord :newRecordString :[URLConnector POSTMETHOD]];
    [urlConnect apiResponse];
    //NewRecordParser *parser = [[NewRecordParser alloc] initRecordParser:response:nil];
    //    [parser recordStatus];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return nil;
}

+ (BOOL) deleteRecordWithID : (NSString*) recordLinkID withFormName : (NSString*) formName andAppName : (NSString*) appLinkName {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *deleteRecord = [URLConstructor writeURL];
    NSString *deleteCriteriaString = [URLConstructor postAuthTokenWithAppOwner];
    deleteCriteriaString = [deleteCriteriaString stringByAppendingFormat:@"&%@",[ZCRecordString deleteRecordStringXML:appLinkName:formName:recordLinkID]];
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:deleteRecord :deleteCriteriaString :[URLConnector POSTMETHOD]];
    [urlConnect apiResponse];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return YES;
}

+ (BOOL) deleteRecordWithID : (NSString*) recordLinkID withViewName : (NSString*) viewName andApplication : (ZCApplication*) application {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *deleteRecord = [URLConstructor writeURL];
    NSString *deleteCriteriaString = [URLConstructor postAuthTokenWithAppOwner:[application appOwner]];
    deleteCriteriaString = [deleteCriteriaString stringByAppendingFormat:@"&%@",[ZCRecordString deleteRecordStringXML:[application appLinkName] withViewName:viewName:recordLinkID]];
    //// //NSLog(@"delete string riyaz %@",deleteCriteriaString);
    
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:deleteRecord :deleteCriteriaString :[URLConnector POSTMETHOD]];
    [urlConnect apiResponse];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return YES;
}

+ (NSMutableArray*) deleteRecordWithIDs : (NSMutableArray*) recordLinkIDs withViewName : (NSString*) viewName andAppName : (NSString*) appLinkName {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *deleteRecord = [URLConstructor writeURL];
//    NSString *deleteCriteriaString = [URLConstructor postAuthTokenWithApplication:[[ZOHOCreator getObject] getApplication:appLinkName]];
    NSString *deleteCriteriaString = [URLConstructor postAuthTokenWithApplication:[[ZOHOCreator getObject ]lastAccessedApp]];

    deleteCriteriaString = [deleteCriteriaString stringByAppendingFormat:@"&%@",[ZCRecordString bulkDeleteRecordStringXML:appLinkName withViewLinkName:viewName:recordLinkIDs]];
    //// //NSLog(@"delete criteria string %@",deleteCriteriaString);
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:deleteRecord :deleteCriteriaString :[URLConnector POSTMETHOD]];
    [urlConnect apiResponse];
    //    NewRecordParser *parser = [[NewRecordParser alloc] initRecordParser:response:nil];
    //    [parser recordStatus];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return nil;
}

+ (NSMutableArray*) deleteRecordWithIDs : (NSMutableArray*) recordLinkIDs withFormName : (NSString*) formName andAppName : (NSString*) appLinkName {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *deleteRecord = [URLConstructor writeURL];
//    deleteCriteriaString = [deleteCriteriaString stringByAppendingFormat:@"&%@",[ZCRecordString bulkDeleteRecordStringXML:appLinkName:formName:recordLinkIDs]];
    
    NSString *deleteCriteriaString = [URLConstructor postAuthTokenWithApplication:[[ZOHOCreator getObject] lastAccessedApp]];

    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:deleteRecord :deleteCriteriaString :[URLConnector POSTMETHOD]];
    [urlConnect apiResponse];
    //NewRecordParser *parser = [[NewRecordParser alloc] initRecordParser:response:nil];
    //    [parser recordStatus];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return nil;
}

+ (NSDictionary*) updateRecordForView : (NSString*) viewLinkName  WithApplication: (NSString*) appLinkName AmdDataDictionary : (NSMutableArray*) dataDict {
    
    return nil;
}

+ (NSMutableArray*) updateRecordWithIDs:(NSMutableArray *)records withViewLinkName :(NSString*) viewLinkName andApplicationName : (NSString*) applicationName  {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *updateRecord = [URLConstructor submitRecordURL];
    //// //NSLog(@"view link name %@",viewLinkName);
//    NSString *updateRecordString = [URLConstructor postAuthTokenWithApplication:[[ZOHOCreator getObject] getApplication:applicationName]];
    NSString *updateRecordString = [URLConstructor postAuthTokenWithApplication:[[ZOHOCreator getObject] lastAccessedApp]];

    updateRecordString = [updateRecordString stringByAppendingFormat:@"&%@&zcRefValue=true",[ZCRecordString bulkDeleteRecordStringXML:applicationName withViewLinkName:viewLinkName :records]];
    NSLog(@"Bulk edit request %@",updateRecordString);
    //// //NSLog(@"\n update rec string \n   %@   \n",updateRecordString);
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:updateRecord :updateRecordString :[URLConnector POSTMETHOD]];
    NSLog(@"Bulk Edit Response %@",[urlConnect apiResponse]);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return nil;
}


+ (NSMutableArray*) updateRecordWithIDs : (ZCForm*) form : (NSMutableArray*) records
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *updateRecord = [URLConstructor submitRecordURL];
    
    NSString *updateRecordString = [URLConstructor postAuthTokenWithAppOwner:[[form application] appOwner]];
    updateRecordString = [updateRecordString stringByAppendingFormat:@"&%@&zcRefValue=true",[ZCRecordString bulKUpdateRcordStringXML:form :records]];
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:updateRecord :updateRecordString :[URLConnector POSTMETHOD]];
    NSString *response = [urlConnect apiResponse];
    if(form != nil) {
        NewRecordParser *parser = [[NewRecordParser alloc] initRecordParser:response:form];
        [parser recordStatus];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return nil;
}

+ (NSDictionary*) updateRecordForView : (NSString*) viewLinkName  WithApplication: (NSString*) appLinkName AndDataDictionary : (NSDictionary*) dataDict {
    
    return nil;
}

+ (NSArray*) newDuplicateRecordForView : (NSString*) viewLinkName  WithApplication: (NSString*) appLinkName AndRecords : (NSMutableArray*) records AndAppOwner : (NSString*) appOwner {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *newRecord = [URLConstructor submitRecordURL];
    NSString *newRecordString = [URLConstructor postAuthTokenWithAppOwner:appOwner];
    
    newRecordString = [newRecordString  stringByAppendingFormat:@"&%@&zcRefValue=true",[ZCRecordString newDuplicateRecords:viewLinkName withApplication:appLinkName AndRecords:records]];
    
    //    newRecordString = [newRecordString stringByAppendingFormat:@"&%@",[ZCRecordString duplicateRecords:viewLinkName withApplication:appLinkName AndRecords:records]];
    
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:newRecord :newRecordString :[URLConnector POSTMETHOD]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //NSLog(@"xml response for duplicate record %@",[urlConnect apiResponse]);
    
    return [NSArray arrayWithObject:[urlConnect apiResponse]];
}

+ (void) duplicateRecordsForView : (NSString*) viewLinkName  WithApplication: (NSString*) appLinkName AndRecords : (NSMutableArray*) records AndAppOwner : (NSString*) appOwner {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *newRecord = [URLConstructor submitRecordURL];
    NSString *newRecordString = [URLConstructor postAuthTokenWithAppOwner:appOwner];
    newRecordString = [newRecordString stringByAppendingFormat:@"&%@&zcRefValue=true",[ZCRecordString duplicateRecords:viewLinkName withApplication:appLinkName AndRecords:records]];
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:newRecord :newRecordString :[URLConnector POSTMETHOD]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [urlConnect apiResponse];
    // //NSLog(@"api response %@",[urlConnect apiResponse]);
}

+ (void) submitRecordsForForm : (NSString*) formLinkName  WithApplication: (NSString*) appLinkName AndRecords : (NSMutableArray*) records{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *newRecord = [URLConstructor submitRecordURL];
    NSString *newRecordString = [URLConstructor postAuthTokenWithAppOwner];
    ZOHOCreator *zohoCreator = [ZOHOCreator getObject];
//    ZCApplication *app = [zohoCreator getApplication:appLinkName];
    ZCApplication *app = [zohoCreator lastAccessedApp];

    ZCForm *formObject = [app getForm:formLinkName];
    newRecordString = [newRecordString stringByAppendingFormat:@"&%@&zcRefValue=true",[ZCRecordString newRecordsStringXML:formObject:records]];
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:newRecord :newRecordString :[URLConnector POSTMETHOD]];
    [urlConnect apiResponse];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //    NSString *response = [urlConnect apiResponse];
    //    NewRecordParser *parser = [[NewRecordParser alloc] initRecordParser:response:nil];
    //    [parser recordStatus];
}
+(ZCLookUpChoices *)getLookupChoicesWithAppLinkname:(NSString *)appLinkName formLinkname:(NSString *)formLinkName lookUpFieldLinkName:(NSString *)lookupFieldName appOwner:(NSString *)appOwner subformComponent:(NSString *)subformComponent searchString: (NSString *)searchString startindex:(int)startIndex limit:(int)limit viewLinkname:(NSString *)ViewLinkname recordID:(NSString *)recordID
{
    
    
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *url = [URLConstructor construckLookupChoicesURLWithAppLinkname:appLinkName formLinkname:formLinkName lookUpFieldLinkName:lookupFieldName appOwner:appOwner subformComponent:subformComponent searchString:searchString startindex:startIndex limit:limit viewLinkname:ViewLinkname recordID:recordID];
    URLConnector *urlConnect = [[URLConnector alloc] initFetcher:url];
    
    [urlConnect apiResponse];
    
    NSLog(@"api response %@",[urlConnect apiResponse]);
    
    LookUPChoiceParser * lookupparser=[[LookUPChoiceParser alloc]initLookUPChoiceParser:[urlConnect apiResponse]];
    
    
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    
    return [lookupparser lookUpChoicesParm];
    
}
//
//-(NSString *)subFormAddRowWithAppLinkname:(NSString *)appLinkName formLinkName:(NSString *)formLinkName fieldLinkName:(NSString *)fieldLinkName numberofsubformEntries:(int)numberofsubformEntries appOwner:(NSString *)appOwner recordParm:(NSString *)params
//{
//
//    
//
//}

+ (void) logout {
    
    ZOHOUser *userObject = [ZOHOUser userObject];
    NSString *fileName = [ArchiveUtil archiveFilePath:@"Login"];
    if([ArchiveUtil deleteEncodeFile : fileName] == YES) {
        [userObject removeZCuser];
    }
    else {
        //////// //NSLog(@"File Not Deleted");
    }
    
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [sharedHTTPCookieStorage cookies];  //cookiesForURL:[NSURL URLWithString:webView.request.URL.absoluteString]];
    NSEnumerator *enumerator = [cookies objectEnumerator];
    NSHTTPCookie *cookie;
    while (cookie = [enumerator nextObject])
    {
        if ([[cookie name]isEqualToString:@"IAMAUTHTOKEN"]) {
            
            
            [sharedHTTPCookieStorage deleteCookie:cookie];
        }
    }
    
}

+ (ZCForm*) getIssueReportForm  {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    ZCFormFetcher *fetcher = [ZCFormFetcher initFormFetcher:@"ios-customer-reported-issue" :@"Issues" appOwner:@"zoho1"];
    return [fetcher zcForm];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end

@implementation ZOHOCreator (hidden)


@end