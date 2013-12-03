//
//  FormOnLoad.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "FormOnLoad.h"
#import "ZCSharedAppsEventsParamsUtil.h"
#import "DelugeEvent.h"
@implementation FormOnLoad

@synthesize application=_application,form=_form;

//- (FormOnLoad*) initFormOnLoad:(ZCApplication *)applicationLocal :(ZCForm *)formLocal : (ZCRecord*) _record : (id) delegate  {
//    
//    self = [super init];
//    if(self) {
//        self->_application = applicationLocal;
//        self->_form = formLocal;
//        NSString *paramString  = [DelugeEvent getParamXMLString:_record:[applicationLocal appOwner]];
//        [super setCallerDelegate:delegate];
//        [super setDelugeURL:[URLConstructor formOnLoad:[applicationLocal appLinkName] :[formLocal linkName] : paramString:[applicationLocal appOwner]]];
//    }
//    return self;
//}

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


- (FormOnLoad*) initFormOnLoad:(ZCApplication *)_appLocal fieldForm:(ZCForm *)_formLocal zcRecors:(ZCRecord *)zcrecord delegate:(id)delegate recordIDIncaseOFEDITFORM:(NSString *)recID viewLinkname:(NSString *)viewLinkname childAppsIncaseOFAddTOPickListForm:(NSArray *)apps childforms:(NSArray *)forms basefields:(NSArray *)fields appOwner:(NSString *)appowner
{
    
    self = [super init];
    
    if(self) {
        
        NSString *paramString  = [DelugeEvent getParamXMLString:zcrecord:[_appLocal appOwner]];
        
        paramString=[paramString stringByAppendingString:[ZCSharedAppsEventsParamsUtil getAddtoPickListParamsWithAPPS:apps Forms:forms fields:fields viewLinkname:viewLinkname recordID:recID deluge:YES]];
//        FORM_ALONE =1,
//        VIEW_ADD_FORM =2,
//        VIEW_EDIT_FORM =3,
//        FORM_LOOKUP_ADD_FORM =5

        int rectype=1;
        if (recID.length) {
            
            rectype=3;
            
            
        }
        else if (viewLinkname.length)
        {
            
            rectype=2;
        }
        
        if (forms.count) {
            
            rectype =5;
        }
        paramString =[paramString stringByAppendingFormat:@"&recType=%i",rectype];
        self->_application = _appLocal;
        self->_form = _formLocal;
        [super setCallerDelegate:delegate];
        [super setDelugeURL:[URLConstructor delugeURL]];
    
        paramString =[[URLConstructor formOnLoadWithJSON:[_appLocal appLinkName] :[_formLocal linkName]: nil:[_appLocal appOwner]] stringByAppendingString:paramString ];
        [super setDelugeParams:paramString];

    }
    return self;
    
    
    
    
}


@end