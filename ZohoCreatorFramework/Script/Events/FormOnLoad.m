//
//  FormOnLoad.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "FormOnLoad.h"

@implementation FormOnLoad

@synthesize application=_application,form=_form;

- (FormOnLoad*) initFormOnLoad:(ZCApplication *)applicationLocal :(ZCForm *)formLocal : (ZCRecord*) _record : (id) delegate  {
    
    self = [super init];
    if(self) {
        self->_application = applicationLocal;
        self->_form = formLocal;
        NSString *paramString  = [DelugeEvent getParamXMLString:_record:[applicationLocal appOwner]];
        [super setCallerDelegate:delegate];
        [super setDelugeURL:[URLConstructor formOnLoad:[applicationLocal appLinkName] :[formLocal linkName] : paramString:[applicationLocal appOwner]]];
    }
    return self;
}

- (FormOnLoad*) initFormOnLoad:(ZCApplication *)applicationLocal :(ZCForm *)formLocal : (id) delegate {
    
    self = [super init];
    if(self) {
        self->_application = applicationLocal;
        self->_form = formLocal;
        [super setCallerDelegate:delegate];
        [super setDelugeURL:[URLConstructor delugeURL]];
        [super setDelugeParams:[URLConstructor formOnLoadWithJSON:[applicationLocal appLinkName] :[formLocal linkName]: nil:[applicationLocal appOwner]]];
//          [super setDelugeURL:[URLConstructor formOnLoadWithJSON:[applicationLocal appLinkName] :[formLocal linkName]: @"":[applicationLocal appOwner]]];
//        [super setDelugeURL:[URLConstructor formOnLoad:[applicationLocal appLinkName] :[formLocal linkName]: @"":[applicationLocal appOwner]]];
    }
    return self;
}

- (DelugeTasks*) execute {
    
    return [super execute];
}

@end