//
//  ZCApplication.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCApplication.h"


@interface ZCApplication(hidden)

- (BOOL) hasFormObject : (NSString*) formLinkName;
- (BOOL) hasViewObject : (NSString*) formLinkName;

@end

@implementation ZCApplication

@synthesize appDisplayName=_appDisplayName,appLinkName=_appLinkName,accessType=_accessType,createdOn=_createdOn,appOwner=_appOwner, appLayout=_appLayout, isZAppBox=_isZAppBox;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self->_appDisplayName=[aDecoder decodeObjectForKey:@"appDisplayName"];
    self->_appLinkName=[aDecoder decodeObjectForKey:@"appLinkName"];
    self->_accessType=[aDecoder decodeObjectForKey:@"accessType"];
    self->_createdOn=[aDecoder decodeObjectForKey:@"createdOn"];
    self->_appOwner=[aDecoder decodeObjectForKey:@"appOwner"];
    self->_appLayout= [aDecoder decodeIntegerForKey:@"layout"];
    self->_isZAppBox=NO;
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_appDisplayName forKey:@"appDisplayName"];
    [aCoder encodeObject:_appLinkName forKey:@"appLinkName"];
    [aCoder encodeObject:_createdOn forKey:@"createdOn"];
    [aCoder encodeObject:_accessType forKey:@"accessType"];
    [aCoder encodeObject:_appOwner forKey:@"appOwner"];
    [aCoder encodeInteger:_appLayout forKey:@"layout"];
}

- (ZCSections*) getSections {
    
    if(_sections==nil) {
        return [self getSections:YES];
    }
    else {
        return _sections;
    }
}

- (ZCSections*) getSections : (BOOL) fromSever {
    
    ZCSectionFetcher *fetcher = [[ZCSectionFetcher alloc] initSectionFetcher:self];
    _sections = [fetcher zcSections];
    return _sections;
    
}

- (ZCSections*) getSectionsForSharedApp:(BOOL)fromServer {
    
    ZCSectionFetcher *fetcher = [[ZCSectionFetcher alloc] initSectionFetcherForSharedApp:self];
    _sections = [fetcher zcSections];
    return _sections;
    
}

- (ZCForm*) getForm: (NSString *)formLinkName {
    
    if([self hasFormObject:formLinkName]) {
        return [_formDictionary valueForKey:formLinkName];
    }
    else {
        return [self getForm:formLinkName fromServer:YES];
    }
}

- (ZCForm*) getForm : (NSString*) formLinkName fromServer : (BOOL) fromServer {
    
    ZCFormFetcher *fetcher = [[ZCFormFetcher alloc] initFormFetcher:_appLinkName : [self getComponent:formLinkName] appOwner:_appOwner];
    ZCForm *_form = [fetcher zcForm];
    if(_formDictionary == nil) {
        _formDictionary = [[NSMutableDictionary alloc] init];
    }
    [_formDictionary setValue:_form forKey:formLinkName];
    return _form;
}

- (ZCView*) getView :  (NSString*) viewLinkName {
    
    if([self hasViewObject:viewLinkName]) {
        return [_viewDictionary valueForKey:viewLinkName];
    }
    else {
        return [self getView:viewLinkName fromServer:YES];
    }
}

- (ZCView*) getView : (NSString*) viewLinkName withParameter : (ZCViewParam*) viewParam  {
    
    ZCViewFetcher *fetcher = [[ZCViewFetcher alloc] initViewFetcher:_appLinkName :[self getComponent:viewLinkName] withParam:viewParam appOwner:_appOwner];
    ZCView *zcView = [fetcher zcView];
    
    if(_viewDictionary == nil) {
        _viewDictionary = [[NSMutableDictionary alloc] init];
    }
    [_viewDictionary setValue:zcView forKey:viewLinkName];
    return zcView;
}

- (ZCView*) getView :  (NSString*) viewLinkName fromServer:(BOOL) fromServer {
    
    if(fromServer==YES) {
        
        ZCViewFetcher *fetcher = [[ZCViewFetcher alloc] initViewFetcher:_appLinkName :[self getComponent:viewLinkName] appOwner:_appOwner];
        ZCView *zcView = [fetcher zcView];
        if(_viewDictionary == nil) {
        	_viewDictionary = [[NSMutableDictionary alloc] init];
        }
        [_viewDictionary setValue:zcView forKey:viewLinkName];
        return zcView;
    }
    else {
        return [self getView:viewLinkName ];
    }
}

- (ZCComponent*) createComponent : (NSString*) componentLinkName {
    
    // //NSLog(@"%@",[NSThread callStackSymbols]);
    if(_sections == nil) {
        [self getSections:YES];
    }
    
    for (NSInteger index=0;index<[[_sections sectionList] count]; index++) {
        ZCSection *section = [[_sections sectionList] objectAtIndex:index];
        for(NSInteger jndex=0;jndex<[[section componentList] count];jndex++) {
            ZCComponent *component = [[section componentList] objectAtIndex:jndex];
            if([[component linkName] isEqualToString:componentLinkName]) {
                return component;
            }
        }
    }
    
    ZCComponent *newComponent = [[ZCComponent alloc] init];
    [newComponent setLinkName:componentLinkName];
    [newComponent setDisplayName:componentLinkName];
    [newComponent setZcApplication:self];
    return newComponent;
}


- (ZCComponent*) getComponent : (NSString*) componentLinkName {
    
    NSLog(@"%@",[NSThread callStackSymbols]);
    if(_sections == nil) {
        [self getSections:YES];
    }
    
    for (NSInteger index=0;index<[[_sections sectionList] count]; index++) {
        ZCSection *section = [[_sections sectionList] objectAtIndex:index];
        for(NSInteger jndex=0;jndex<[[section componentList] count];jndex++) {
            ZCComponent *component = [[section componentList] objectAtIndex:jndex];
            if([[component linkName] isEqualToString:componentLinkName]) {
                return component;
            }
        }
    }
    [NSException raise:@"Not Found" format:@"Component Not found in this application"];
    return nil;
}

- (id) copyWithZone:(NSZone *)zone {
    
    ZCApplication *application = [[[self class] alloc] init];
    
    if(application) {
        [application setAppLinkName:[_appLinkName copy]];
        [application setAppDisplayName:[_appDisplayName copy]];
        [application setCreatedOn:[_createdOn copy]];
        [application setAccessType:[_accessType copy]];
        [application setAppOwner:[_appOwner copy]];
        [application setAppLayout:_appLayout];
        [application setIsZAppBox:_isZAppBox];
    }
    return application;
}

@end

@implementation ZCApplication(hidden)

- (BOOL) hasFormObject : (NSString*) formLinkName {
    
    if(_formDictionary == nil) {
        return NO;
    }
    else {
        
        NSArray *keys= [_formDictionary allKeys];
        for(NSInteger index=0;index<[keys count];index++) {
            
            NSString *key = [keys objectAtIndex:index];
            if([key isEqualToString:formLinkName])
                return YES;
        }
    }
    return NO;
}

- (BOOL) hasViewObject : (NSString*) viewLinkName {
    
    if(_viewDictionary == nil) {
        return NO;
    }
    else {
        
        NSArray *keys= [_viewDictionary allKeys];
        for(NSInteger index=0;index<[keys count];index++) {
            
            NSString *key = [keys objectAtIndex:index];
            if([key isEqualToString:viewLinkName])
                return YES;
        }
    }
    return NO;
}

@end
