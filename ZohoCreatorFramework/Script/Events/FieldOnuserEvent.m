//
//  FieldOnuserEvent.m
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 12/09/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "FieldOnuserEvent.h"
@implementation FieldOnuserEvent
- (FieldOnuserEvent*) initFieldOnUserEventWithFieldAppname: (NSString*) _appLocal fieldFormName: (NSString*) _formLocal fieldName:(NSString*) _fieldLocal parmString:(NSString*) paramString delegate:(id) delegate  fieldBElongToSubForm:(BOOL)subform mainAppLinkname:(NSString *)mainAppLinkname mainFormLinkname:(NSString *)mainFormLinkname subformFieldLinkname:(NSString *)subformFieldLinkname appOwner:(NSString *)appowner   {
    
    self = [super init];
    
    if(self) {
        if (subform) {
            //            [super setDelugeURL:[URLConstructor fieldOnUser:_appLocal :_formLocal:_fieldLocal:paramString]];
            _subform=YES;
//            subformOnuser=[[SubFormOnUser alloc]initSubFormOnUser:_appLocal :_formLocal :_fieldLocal :mainAppLinkname :mainFormLinkname :subformFieldLinkname :paramString :appowner :delegate  ];
            fieldonuser=[[FieldOnUser alloc]initFieldOnUser:_appLocal :_formLocal :_fieldLocal :paramString :delegate:appowner ];

        }
        else
        {
            fieldonuser=[[FieldOnUser alloc]initFieldOnUser:_appLocal :_formLocal :_fieldLocal :paramString :delegate:appowner ];
        }
    }
    return self;
}
//- (FieldOnuserEvent*) initFieldOnUser : (NSString*) _appLocal : (NSString*) _formLocal : (NSString*) _fieldLocal : (NSString*) paramString : (id) delegate {
//    self = [super init];
//    if(self) {
//        [super setCallerDelegate:delegate];
//        [super setDelugeURL:[URLConstructor fieldOnUser:_appLocal :_formLocal:_fieldLocal:paramString]];
//        //// //NSLog(@"On User URL %@",[super delugeURL]);
//        //// //NSLog(@"deluge initiated...with app : %@, form : %@, field : %@, param : %@ delegate class : %@",_appLocal,_formLocal,_fieldLocal,paramString,[delegate class]);
//    }
//    return self;
//}

- (DelugeTasks*) execute {
    if (_subform) {
        
        return [subformOnuser execute];
    }
    else
    {
        return [fieldonuser execute];
    }
    
    
}



@end