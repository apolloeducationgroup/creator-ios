//
//  FormEditOnLoad.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 17/05/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "FormEditOnLoad.h"

@implementation FormEditOnLoad

@synthesize application=_application,form=_form;

- (FormEditOnLoad*) initFormEditOnLoad:(ZCApplication *)applicationLocal :(ZCForm *)formLocal : (ZCRecord*) _record : (id) delegate  {
    
    self = [super init];
    if(self) {
        self->_application = applicationLocal;
        self->_form = formLocal;
        NSString *paramString  = [DelugeEvent getParamXMLString:_record:[applicationLocal appOwner]];
        [super setCallerDelegate:delegate];
        [super setDelugeURL:[URLConstructor formEditOnLoad:[applicationLocal appLinkName] :[formLocal linkName] : paramString:[applicationLocal appOwner]]];
    }
    return self;
}

- (FormEditOnLoad*) initFormOnLoad:(ZCApplication *)applicationLocal :(ZCForm *)formLocal : (id) delegate {
    
    self = [super init];
    if(self) {
        self->_application = applicationLocal;
        self->_form = formLocal;
        [super setCallerDelegate:delegate];
        [super setDelugeURL:[URLConstructor formOnLoad:[applicationLocal appLinkName] :[formLocal linkName]: @"":[applicationLocal appOwner]]];
    }
    return self;
}


- (DelugeTasks*) execute {
    
    return [super execute];
}

@end
