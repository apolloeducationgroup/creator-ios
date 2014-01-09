//
//  ZCFormFetcher.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 03/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCFormFetcher.h"
#import "ZCEncodeUtil.h"
@interface ZCFormFetcher(hidden)

- (ZCForm*) fetchFromServer;
- (ZCForm*) fetchFromLocal;
- (void) encodeZCForm;
@end

@implementation ZCFormFetcher

@synthesize zcForm=_zcForm;

+ (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (NSString*) formLinkName recordLinkID : (NSString*) _recLinkID appOwner : (NSString *) appOwner   {
    
    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:formLinkName];
    [_comp setDisplayName:formLinkName];
    [_comp setType:1];
    ZCFormFetcher *fetcher = [[ZCFormFetcher alloc] initFormFetcher:appLinkName :_comp recordLinkID:_recLinkID appOwner:appOwner];
    return fetcher;
}
+(ZCFormFetcher *) initSubFormFetcher:(NSString *)appLinkName formLinkname:(NSString *)formLinkName subformmode:(BOOL)subformMode appOwner:(NSString *)appOwner  mainAppLinkname:(NSString *)mainAppLinkname mainFormLinkname:(NSString *)mainFormLinkname subformFieldLinkname:(NSString *)subformFieldLinkname
{
    
    
    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:formLinkName];
    [_comp setDisplayName:formLinkName];
    [_comp setType:1];
    ZCFormFetcher *fetcher = [[ZCFormFetcher alloc] initSubFormFetcher:appLinkName :_comp appOwner:appOwner subformmode:subformMode mainAppLinkname:mainAppLinkname mainFormLinkname:mainFormLinkname subformFieldLinkname:subformFieldLinkname];
    
    return fetcher;
    
    
}
+ (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (NSString*) formLinkName viewLinkName : (NSString*) viewLinkName  recordLinkID : (NSString*) _recLinkID appOwner : (NSString *) appOwner  {
    
    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:formLinkName];
    [_comp setDisplayName:formLinkName];
    [_comp setType:1];
    ZCFormFetcher *fetcher = [[ZCFormFetcher alloc] initFormFetcher:appLinkName :_comp viewLinkName : viewLinkName recordLinkID:_recLinkID appOwner:appOwner];
    return fetcher;
}

+ (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (NSString*) formLinkName appOwner : (NSString *) appOwner urlParameters:(NSString *)urlParameters {
    
    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:formLinkName];
    [_comp setDisplayName:formLinkName];
    [_comp setType:1];
    ZCFormFetcher *fetcher = [[ZCFormFetcher alloc] initFormFetcher:appLinkName :_comp appOwner:appOwner urlParameters:urlParameters];
    return fetcher;
}

+ (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (NSString*) formLinkName viewLinkName : (NSString*) viewLinkName appOwner : (NSString *) appOwner urlParameters:(NSString *)urlParameters
{
    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:formLinkName];
    [_comp setDisplayName:formLinkName];
    [_comp setType:1];
    ZCFormFetcher *fetcher = [[ZCFormFetcher alloc] initFormFetcher:appLinkName :viewLinkName :_comp appOwner:appOwner urlParameters:urlParameters];
    return fetcher;

}

+ (ZCFormFetcher*) initFormFetcherForBulkedit : (NSString*) appLinkName : (NSString*) formLinkName viewLinkName : (NSString*) viewLinkName appOwner : (NSString *) appOwner

{

    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:formLinkName];
    [_comp setDisplayName:formLinkName];
    [_comp setType:1];
    ZCFormFetcher *fetcher = [[ZCFormFetcher alloc] initFormFetcherforBulkedit:appLinkName :viewLinkName :_comp appOwner:appOwner];
    return fetcher;
}

+ (ZCFormFetcher*) initFormFetcherformAddtoPickListForm: (NSString*) appLinkName   formLinkname: (NSString*) formLinkName appOwner : (NSString *) appOwner childappsINORDER:(NSArray *)childappsINORDER childFormsINORDER:(NSArray *)childFormsINORDER baseFieldsINORDER:(NSArray *)baseFieldsINORDER recordID:(NSString *)recordID viewLinkName:(NSString *)viewLinkName
{
    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:formLinkName];
    [_comp setDisplayName:formLinkName];
    [_comp setType:1];
    ZCFormFetcher *fetcher = [[ZCFormFetcher alloc] initFormFetcherformAddtoPickListForm:appLinkName :_comp appOwner:appOwner childappsINORDER:childappsINORDER childFormsINORDER:childFormsINORDER baseFieldsINORDER:baseFieldsINORDER viewLinkName:viewLinkName recordLinkID:recordID];
                              
                              return fetcher;
    
}




- (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (ZCComponent*) component viewLinkName : (NSString*) viewLinkName recordLinkID : (NSString*) recordLinkID appOwner : (NSString *) appOwner {
    
    self = [super init];
    if(self) {
        
        self->_appLinkName = appLinkName;
        self->_component = component;
        self->_appOwner = appOwner;
        self->_recordLinkID = recordLinkID;
        self->_viewLinkName = viewLinkName;
        
        if([ConnectionChecker isServerActive]) {
            
            
            ZOHOCreator *creator = [ZOHOCreator getObject];
//            ZCApplication *application = [creator getApplication:appLinkName];
            ZCApplication * application=[creator getApplication:appLinkName appOwner:appOwner];
            if(application != nil) {
                [self->_component setZcApplication:application];
            }
            else {
                application = [[ZCApplication alloc] init];
                [application setAppLinkName:appLinkName];
                [application setAppOwner:appOwner];
                
                [self->_component setZcApplication:application];
            }
            self->_zcForm = [self fetchFromServer];
            [self->_zcForm setApplication:application];
            [self encodeZCForm];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
        }
    }
    return self;
}
-(ZCFormFetcher*) initFormFetcherformAddtoPickListForm : (NSString*) appLinkName : (ZCComponent*) component appOwner : (NSString *) appOwner childappsINORDER:(NSArray *)childappsINORDER childFormsINORDER:(NSArray *)childFormsINORDER baseFieldsINORDER:(NSArray *)baseFieldsINORDER viewLinkName : (NSString*) viewLinkName recordLinkID : (NSString*) recordLinkID
{
    
    self = [super init];
    if(self) {
        
        self->_appLinkName = appLinkName;
        self->_component = component;
        self->_appOwner = appOwner;
        self->addtoPicklistForm=YES;

        self->_recordLinkID = recordLinkID;
        self->_viewLinkName = viewLinkName;

        if([ConnectionChecker isServerActive]) {
            
            childappsINORDER_forAddtoPickList=childappsINORDER;
            childFormsINORDER_forAddtoPickList=childFormsINORDER;
            baseFieldsINORDER_forAddtoPickList=baseFieldsINORDER;
            
            ZOHOCreator *creator = [ZOHOCreator getObject];
//            ZCApplication *application = [creator getApplication:appLinkName];
                ZCApplication *application = [creator getApplication:appLinkName appOwner:appOwner];

            if(application != nil) {
                [self->_component setZcApplication:application];
            }
            else {
                application = [[ZCApplication alloc] init];
                [application setAppLinkName:appLinkName];
                [application setAppOwner:appOwner];
                
                [self->_component setZcApplication:application];
            }
            self->_zcForm = [self fetchFromServer];
            [self->_zcForm setApplication:application];
            [self encodeZCForm];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
        }
    }
    return self;
}
- (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (ZCComponent*) component recordLinkID : (NSString*) recordLinkID appOwner : (NSString *) appOwner {
    
    self = [super init];
    if(self) {
        
        self->_appLinkName = appLinkName;
        self->_component = component;
        self->_appOwner = appOwner;
        self->_recordLinkID = recordLinkID;
        
        if([ConnectionChecker isServerActive]) {
            
            
            ZOHOCreator *creator = [ZOHOCreator getObject];
//            ZCApplication *application = [creator getApplication:appLinkName];
            ZCApplication *application = [creator getApplication:appLinkName appOwner:appOwner];

            if(application != nil) {
                [self->_component setZcApplication:application];
            }
            else {
                application = [[ZCApplication alloc] init];
                [application setAppLinkName:appLinkName];
                [application setAppOwner:appOwner];
                
                [self->_component setZcApplication:application];
            }
            self->_zcForm = [self fetchFromServer];
            [self->_zcForm setApplication:application];
            [self encodeZCForm];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
        }
    }
    return self;
}

- (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (ZCComponent*) component appOwner : (NSString *) appOwner urlParameters:(NSString *)urlParameters  {
    
    self = [super init];
    if(self) {
        
        self->_appLinkName = appLinkName;
        self->_component = component;
        self->_appOwner = appOwner;
        self->_urlParameters = urlParameters;

        if([ConnectionChecker isServerActive]) {
            
            ZOHOCreator *creator = [ZOHOCreator getObject];
//            ZCApplication *application = [creator getApplication:appLinkName];
            ZCApplication *application = [creator getApplication:appLinkName appOwner:appOwner];

            if(application != nil) {
                [self->_component setZcApplication:application];
            }
            else {
                application = [[ZCApplication alloc] init];
                [application setAppLinkName:appLinkName];
                [application setAppOwner:appOwner];
                
                [self->_component setZcApplication:application];
            }
            self->_zcForm = [self fetchFromServer];
            [self->_zcForm setApplication:application];
            [self encodeZCForm];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
            // self->_zcForm = [self fetchFromLocal];
        }
    }
    return self;
}

- (ZCFormFetcher *) initFormFetcherforBulkedit:(NSString *)appLinkName :(NSString *)viewLinkName :(ZCComponent *)component appOwner:(NSString *)appOwner
{
    self = [super init];
    if(self) {
        
        self->_appLinkName = appLinkName;
        self->_component = component;
        self->_appOwner = appOwner;
        self->_viewLinkName = viewLinkName;
        _isBulkeditForm=YES;
        if([ConnectionChecker isServerActive]) {
            
            ZOHOCreator *creator = [ZOHOCreator getObject];
            //            ZCApplication *application = [creator getApplication:appLinkName];
            ZCApplication *application = [creator getApplication:appLinkName appOwner:appOwner];
            
            if(application != nil) {
                [self->_component setZcApplication:application];
            }
            else {
                application = [[ZCApplication alloc] init];
                [application setAppLinkName:appLinkName];
                [application setAppOwner:appOwner];
                
                [self->_component setZcApplication:application];
            }
            self->_zcForm = [self fetchFromServer];
            [self->_zcForm setApplication:application];
            [self encodeZCForm];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
            // self->_zcForm = [self fetchFromLocal];
        }
    }
    return self;
}

- (ZCFormFetcher *) initFormFetcher:(NSString *)appLinkName :(NSString *)viewLinkName :(ZCComponent *)component appOwner:(NSString *)appOwner urlParameters:(NSString *)urlParameters
{
    self = [super init];
    if(self) {
        
        self->_appLinkName = appLinkName;
        self->_component = component;
        self->_appOwner = appOwner;
        self->_viewLinkName = viewLinkName;
        self->_urlParameters = urlParameters;

        if([ConnectionChecker isServerActive]) {
            
            ZOHOCreator *creator = [ZOHOCreator getObject];
//            ZCApplication *application = [creator getApplication:appLinkName];
            ZCApplication *application = [creator getApplication:appLinkName appOwner:appOwner];

            if(application != nil) {
                [self->_component setZcApplication:application];
            }
            else {
                application = [[ZCApplication alloc] init];
                [application setAppLinkName:appLinkName];
                [application setAppOwner:appOwner];
                
                [self->_component setZcApplication:application];
            }
            self->_zcForm = [self fetchFromServer];
            [self->_zcForm setApplication:application];
            [self encodeZCForm];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
            // self->_zcForm = [self fetchFromLocal];
        }
    }
    return self;
}

- (ZCFormFetcher*) initSubFormFetcher : (NSString*) appLinkName : (ZCComponent*) component appOwner : (NSString *) appOwner subformmode:(BOOL)subformmode mainAppLinkname:(NSString *)mainAppLinkname mainFormLinkname:(NSString *)mainFormLinkname subformFieldLinkname:(NSString *)subformFieldLinkname {
    
    self = [super init];
    if(self) {
        
        self->_appLinkName = appLinkName;
        self->_component = component;
        self->_appOwner = appOwner;
        _isSubform=subformmode;
        mainAppLinkname_forSubform=mainAppLinkname;
        mainFormLinkname_forSubform=mainFormLinkname;
        subformFieldLinkname_forSubform=subformFieldLinkname;
        if([ConnectionChecker isServerActive]) {
            
            ZOHOCreator *creator = [ZOHOCreator getObject];
//            ZCApplication *application = [creator getApplication:appLinkName];
            ZCApplication *application = [creator getApplication:appLinkName appOwner:appOwner];

            if(application != nil) {
                [self->_component setZcApplication:application];
            }
            else {
                application = [[ZCApplication alloc] init];
                [application setAppLinkName:appLinkName];
                [application setAppOwner:appOwner];
                
                [self->_component setZcApplication:application];
            }
            self->_zcForm = [self fetchFromServer];
            [self->_zcForm setApplication:application];
            [self encodeZCForm];
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
            // self->_zcForm = [self fetchFromLocal];
        }
    }
    return self;
}

@end

@implementation ZCFormFetcher(hidden)

- (void) encodeZCForm {
    
    [EncodeObject encode:[ArchiveUtil applicationPath:_appLinkName] :[_component linkName] :_zcForm];
}

- (ZCForm*) fetchFromLocal {
    
    NSString *appPath = [ArchiveUtil applicationPath:_appLinkName];
    ZCForm *form =  [DecodeObject decode:appPath :[_component linkName]];
    return form;
}

- (ZCForm*) fetchFromServer {
    
    NSLog(@"Coming to ZCForm ");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *formMetaURL;
    
    if (addtoPicklistForm) {
        
        
        formMetaURL = [URLConstructor formURLforAddTOFickListAppname:_appLinkName formName:[_component linkName] withApplicationOwner:_appOwner childappsINORDER:childappsINORDER_forAddtoPickList childFormsINORDER:childFormsINORDER_forAddtoPickList baseFieldsINORDER:baseFieldsINORDER_forAddtoPickList recordID:_recordLinkID viewLinkname:_viewLinkName];
        
        
    }
    
   else if(_recordLinkID != nil) {
        formMetaURL = [URLConstructor editFormMetaJSON:_appLinkName :_viewLinkName :_recordLinkID :_appOwner];
    }
    else {
        
        if (_isSubform) {
            
            formMetaURL=[URLConstructor subformMetaURL:_appLinkName formLinkname:[_component linkName] mainAppLinkname:mainAppLinkname_forSubform mainFormLinkname:mainFormLinkname_forSubform subformFieldLinkname:subformFieldLinkname_forSubform appOwner:_appOwner  ];
        }
        else if(_isBulkeditForm)
        {
        
            formMetaURL = [URLConstructor  formURLforBulkedit:_appLinkName formName:[_component linkName] viewName:_viewLinkName withApplicationOwner:_appOwner];

        }
        else
        {
            if (_viewLinkName==NULL||_viewLinkName==nil||[_viewLinkName isEqualToString:@""]) {
                
                formMetaURL = [URLConstructor formURL:_appLinkName formName:[_component linkName] withApplicationOwner:_appOwner];
            }
            else{
                formMetaURL = [URLConstructor formURL:_appLinkName formName:[_component linkName] viewName:_viewLinkName withApplicationOwner:_appOwner];
            }
            NSLog(@"form meta url : %@",formMetaURL);
        }
    }
    
    if (_urlParameters.length) {
        formMetaURL =[formMetaURL stringByAppendingFormat:@"&%@",[ZCEncodeUtil encodeStringUsingUT8:_urlParameters]];
    }
    NSLog(@"Coming to get json");
    URLConnector *connector = [[URLConnector alloc] initFetcher:formMetaURL];
    NSString *formMetaXML = [connector apiResponse];
    NSLog(@"form json String %@",formMetaXML);
    ZCApplication *tempApp = [[ZCApplication alloc] init];
    [tempApp setAppLinkName:_appLinkName];
    [tempApp setAppOwner:_appOwner];
    FormJSONParser *_jsonParser = [[FormJSONParser alloc] initFormJSONParser:formMetaXML:tempApp];

    //NSLog(@"formMetaXML %@",formMetaXML);
//    FormParser *parser = [[FormParser alloc] initFormParser:formMetaXML :_component ];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  //  return [parser zcForm];
    
    NSLog(@"Form JSON Object %@",[_jsonParser zcForm]);
    NSLog(@"Form JSON Object appowner%@ %@",_appOwner,[[_zcForm application]appOwner]);

    return [_jsonParser zcForm];
}

//&
//refAppLinkName=sub
//&
//refFormLinkName=Sub_form
//&
//refFieldName=SubForm_1
@end