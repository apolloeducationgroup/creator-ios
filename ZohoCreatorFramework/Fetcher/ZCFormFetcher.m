//
//  ZCFormFetcher.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 03/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCFormFetcher.h"

@interface ZCFormFetcher(hidden)

- (ZCForm*) fetchFromServer;
- (ZCForm*) fetchFromLocal;
- (void) encodeZCForm;
@end

@implementation ZCFormFetcher

@synthesize zcForm=_zcForm;

+ (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (NSString*) formLinkName recordLinkID : (NSString*) _recLinkID appOwner : (NSString *) appOwner {
    
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
+ (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (NSString*) formLinkName viewLinkName : (NSString*) viewLinkName  recordLinkID : (NSString*) _recLinkID appOwner : (NSString *) appOwner {
    
    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:formLinkName];
    [_comp setDisplayName:formLinkName];
    [_comp setType:1];
    ZCFormFetcher *fetcher = [[ZCFormFetcher alloc] initFormFetcher:appLinkName :_comp viewLinkName : viewLinkName recordLinkID:_recLinkID appOwner:appOwner];
    return fetcher;
}

+ (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (NSString*) formLinkName appOwner : (NSString *) appOwner {
    
    ZCComponent *_comp = [[ZCComponent alloc] init];
    [_comp setLinkName:formLinkName];
    [_comp setDisplayName:formLinkName];
    [_comp setType:1];
    ZCFormFetcher *fetcher = [[ZCFormFetcher alloc] initFormFetcher:appLinkName :_comp appOwner:appOwner];
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
            ZCApplication *application = [creator getApplication:appLinkName];
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
            ZCApplication *application = [creator getApplication:appLinkName];
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

- (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (ZCComponent*) component appOwner : (NSString *) appOwner {
    
    self = [super init];
    if(self) {
        
        self->_appLinkName = appLinkName;
        self->_component = component;
        self->_appOwner = appOwner;
        
        if([ConnectionChecker isServerActive]) {
            
            ZOHOCreator *creator = [ZOHOCreator getObject];
            ZCApplication *application = [creator getApplication:appLinkName];
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
            ZCApplication *application = [creator getApplication:appLinkName];
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
    if(_recordLinkID != nil) {
        formMetaURL = [URLConstructor editFormMetaURL1:_appLinkName :[_component linkName] viewLinkName:_viewLinkName recordLinkID:_recordLinkID appOwner:_appOwner];
    }
    else {
        
        if (_isSubform) {
            
            formMetaURL=[URLConstructor subformMetaURL:_appLinkName formLinkname:[_component linkName] mainAppLinkname:mainAppLinkname_forSubform mainFormLinkname:mainFormLinkname_forSubform subformFieldLinkname:subformFieldLinkname_forSubform appOwner:_appOwner ];
        }
        else
        {
            formMetaURL = [URLConstructor formURL:_appLinkName formName:[_component linkName] withApplicationOwner:_appOwner];
        }
    }
    NSLog(@"Coming to get json");
    URLConnector *connector = [[URLConnector alloc] initFetcher:formMetaURL];
    NSString *formMetaXML = [connector apiResponse];
    NSLog(@"form json String %@",formMetaXML);
    FormJSONParser *_jsonParser = [[FormJSONParser alloc] initFormJSONParser:formMetaXML];

    //NSLog(@"formMetaXML %@",formMetaXML);
//    FormParser *parser = [[FormParser alloc] initFormParser:formMetaXML :_component ];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  //  return [parser zcForm];
    NSLog(@"Form JSON Object %@",[_jsonParser zcForm]);
    return [_jsonParser zcForm];
}

//&
//refAppLinkName=sub
//&
//refFormLinkName=Sub_form
//&
//refFieldName=SubForm_1
@end