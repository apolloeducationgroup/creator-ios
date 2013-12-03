//
//  FormEditOnLoad.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 17/05/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "FormEditOnLoad.h"
#import "ZCSharedAppsEventsParamsUtil.h"
@implementation FormEditOnLoad

@synthesize application=_application,form=_form;
//
//- (FormEditOnLoad*) initFormEditOnLoad:(ZCApplication *)applicationLocal :(ZCForm *)formLocal : (ZCRecord*) _record : (id) delegate  {
//    
//    self = [super init];
//    if(self) {
//        self->_application = applicationLocal;
//        self->_form = formLocal;
//        NSString *paramString  = [DelugeEvent getParamXMLString:_record:[applicationLocal appOwner]];
//        [super setCallerDelegate:delegate];
//        [super setDelugeURL:[URLConstructor formEditOnLoad:[applicationLocal appLinkName] :[formLocal linkName] : paramString:[applicationLocal appOwner]]];
//        
//
//    }
//    return self;
//}
//
//- (FormEditOnLoad*) initFormOnLoad:(ZCApplication *)applicationLocal :(ZCForm *)formLocal : (id) delegate {
//    
//    self = [super init];
//    if(self) {
//        self->_application = applicationLocal;
//        self->_form = formLocal;
//        [super setCallerDelegate:delegate];
//        [super setDelugeURL:[URLConstructor formOnLoadWithJSON:[applicationLocal appLinkName] :[formLocal linkName]: @"":[applicationLocal appOwner]]];
////        formOnLoadWithJSON        
//    }
//    return self;
//}

- (FormEditOnLoad*) initFormEditOnLoad:(ZCApplication *)_appLocal fieldForm:(ZCForm *)_formLocal zcRecors:(ZCRecord *)zcrecord delegate:(id)delegate recordIDIncaseOFEDITFORM:(NSString *)recID viewLinkname:(NSString *)viewLinkname childAppsIncaseOFAddTOPickListForm:(NSArray *)apps childforms:(NSArray *)forms basefields:(NSArray *)fields appOwner:(NSString *)appowner
{
    
    self = [super init];
    
    if(self) {
        
        NSString *paramString  = [DelugeEvent getParamXMLString:zcrecord:[_appLocal appOwner]];
        
        paramString=[paramString stringByAppendingString:[ZCSharedAppsEventsParamsUtil getAddtoPickListParamsWithAPPS:apps Forms:forms fields:fields viewLinkname:viewLinkname recordID:nil deluge:YES]];
        //        FORM_ALONE =1,
        //        VIEW_ADD_FORM =2,
        //        VIEW_EDIT_FORM =3,
        //        FORM_LOOKUP_ADD_FORM =5
//               int rectype=1;
//        if (recID.length) {
//            
//            rectype=3;
//            
//            
//        }
//        else if (viewLinkname.length)
//        {
//            
//            rectype=2;
//        }
//        
//        if (forms.count) {
//            
//            rectype =5;
//        }
//        re
        paramString =[paramString stringByAppendingFormat:@"&recType=3&pkValue=%@",recID];
        self->_application = _appLocal;
        self->_form = _formLocal;
        [super setCallerDelegate:delegate];
        [super setDelugeURL:[URLConstructor delugeURL]];
        
        paramString =[[URLConstructor formOnLoadWithJSON:[_appLocal appLinkName] :[_formLocal linkName]: nil:[_appLocal appOwner]] stringByAppendingString:paramString ];
        [super setDelugeParams:paramString];
        
    }
    return self;
    
    
    
    
}




- (DelugeTasks*) execute {
    
    return [super execute];
}

@end
